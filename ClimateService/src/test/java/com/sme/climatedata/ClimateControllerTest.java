package com.sme.climatedata;
//Mockito Test Case for ClimateController
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.ResponseEntity;
import org.junit.jupiter.api.extension.ExtendWith;

import java.util.Arrays;
import java.util.List;

import com.sme.climatedata.controller.ClimateController;
import com.sme.climatedata.model.ClimateData;
import com.sme.climatedata.service.ClimateService;

@ExtendWith(MockitoExtension.class)
public class ClimateControllerTest {

    @InjectMocks
    private ClimateController climateController;

    @Mock
    private ClimateService climateService;

    @Test
    public void testGetAllClimateData() {
        // Arrange
        ClimateData climateData = new ClimateData();
        climateData.setCity("London");
        climateData.setTemperature(20.0f);
        climateData.setHumidity(50.0f);
        climateData.setPrecipitation(0.0f);

        when(climateService.getAllClimateData()).thenReturn(Arrays.asList(climateData));

        // Act
        ResponseEntity<List<ClimateData>> response = climateController.getAllClimateData();
        List<ClimateData> result = response.getBody();

        // Assert
        assertEquals(1, result.size());
        assertEquals("London", result.get(0).getCity());
        assertEquals(20.0f, result.get(0).getTemperature());
        assertEquals(50.0f, result.get(0).getHumidity());
        assertEquals(0.0f, result.get(0).getPrecipitation());
    }
}