package com.sme.climatedata;


import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.junit.jupiter.api.extension.ExtendWith;

import java.util.Arrays;
import java.util.List;

import com.sme.climatedata.controller.ClimateController;
import com.sme.climatedata.model.ClimateData;
import com.sme.climatedata.service.ClimateService;

@ExtendWith(MockitoExtension.class)
public class ClimateControllerTest {

    @Mock
    private ClimateService climateService;

    @InjectMocks
    private ClimateController climateController;

    @Test
    public void testGetAllClimateData() {
        ClimateData climateData1 = new ClimateData(1, "city1", "country1", "month1", 1.0f, 1.0f, 1.0f);
        ClimateData climateData2 = new ClimateData(2, "city2", "country2", "month2", 2.0f, 2.0f, 2.0f);
        List<ClimateData> climateDataList = Arrays.asList(climateData1, climateData2);

        when(climateService.getAllClimateData()).thenReturn(climateDataList);

        List<ClimateData> result = climateController.getAllClimate();

        assertEquals(2, result.size());
        assertEquals(climateData1, result.get(0));
        assertEquals(climateData2, result.get(1));
    }   
  
}