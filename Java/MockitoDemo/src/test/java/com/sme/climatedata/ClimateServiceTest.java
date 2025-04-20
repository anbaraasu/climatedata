package com.sme.climatedata;

import com.sme.climatedata.model.ClimateData;
import com.sme.climatedata.repository.ClimateDataRepository;
import com.sme.climatedata.service.ClimateServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class ClimateServiceTest {

    @Mock
    private ClimateDataRepository climateDataRepository;

    @InjectMocks
    private ClimateServiceImpl climateService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testGetAllClimateData() {
        ClimateData data1 = new ClimateData(1, "City1", "Country1", "January", 25.0f, 60.0f, 10.0f);
        ClimateData data2 = new ClimateData(2, "City2", "Country2", "February", 30.0f, 70.0f, 20.0f);
        when(climateDataRepository.findAll()).thenReturn(Arrays.asList(data1, data2));

        List<ClimateData> result = climateService.getAllClimateData();

        assertEquals(2, result.size());
        assertEquals(data1, result.get(0));
        assertEquals(data2, result.get(1));
    }

    @Test
    void testGetClimateDataById() {
        ClimateData data = new ClimateData(1, "City1", "Country1", "January", 25.0f, 60.0f, 10.0f);
        when(climateDataRepository.findById(1)).thenReturn(Optional.of(data));

        ClimateData result = climateService.getClimateDataById(1);

        assertNotNull(result);
        assertEquals("City1", result.getCity());
    }

    @Test
    void testCreateClimateData() {
        ClimateData data = new ClimateData(null, "City1", "Country1", "January", 25.0f, 60.0f, 10.0f);
        ClimateData savedData = new ClimateData(1, "City1", "Country1", "January", 25.0f, 60.0f, 10.0f);
        when(climateDataRepository.save(data)).thenReturn(savedData);

        ClimateData result = climateService.createClimateData(data);

        assertNotNull(result);
        assertEquals(1, result.getId());
    }

    @Test
    void testUpdateClimateData() {
        ClimateData existingData = new ClimateData(1, "City1", "Country1", "January", 25.0f, 60.0f, 10.0f);
        ClimateData updatedData = new ClimateData(null, "CityUpdated", "CountryUpdated", "February", 30.0f, 70.0f, 20.0f);
        when(climateDataRepository.findById(1)).thenReturn(Optional.of(existingData));
        when(climateDataRepository.save(existingData)).thenReturn(existingData);

        ClimateData result = climateService.updateClimateData(1, updatedData);

        assertNotNull(result);
        assertEquals("CityUpdated", result.getCity());
        assertEquals("CountryUpdated", result.getCountry());
    }

    @Test
    void testDeleteClimateData() {
        doNothing().when(climateDataRepository).deleteById(1);

        climateService.deleteClimateData(1);

        verify(climateDataRepository, times(1)).deleteById(1);
    }
}
