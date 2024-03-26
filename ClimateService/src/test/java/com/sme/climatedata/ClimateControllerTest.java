package com.sme.climatedata;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sme.climatedata.controller.ClimateController;
import com.sme.climatedata.model.ClimateData;
import com.sme.climatedata.service.ClimateService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import java.util.Arrays;
import java.util.List;

import static org.mockito.Mockito.when;

@WebMvcTest(ClimateController.class)
public class ClimateControllerTest {

    private static final String BASE_URL = "/api/v1/climate";

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockBean
    private ClimateService climateService;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testGetAllClimateData() throws Exception {
        ClimateData climateData1 = new ClimateData();
        climateData1.setId(1L);
        ClimateData climateData2 = new ClimateData();
        climateData2.setId(2L);
        List<ClimateData> climateDataList = Arrays.asList(climateData1, climateData2);

        when(climateService.getAllClimateData()).thenReturn(climateDataList);

        mockMvc.perform(MockMvcRequestBuilders.get(BASE_URL)
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$[0].id").value(1))
                .andExpect(MockMvcResultMatchers.jsonPath("$[1].id").value(2));
    }

    // Add more test methods for other controller methods

    @Test
    public void testGetClimateDataById() throws Exception {
        ClimateData climateData = new ClimateData();
        climateData.setId(1L);

        when(climateService.getClimateDataById(1L)).thenReturn(climateData);

        mockMvc.perform(MockMvcRequestBuilders.get(BASE_URL + "/1")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.id").value(1));
    }

    @Test
    public void testCreateClimateData() throws Exception {
        ClimateData climateData = new ClimateData();
        climateData.setId(1L);

        when(climateService.createClimateData(climateData)).thenReturn(climateData);

        mockMvc.perform(MockMvcRequestBuilders.post(BASE_URL)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(climateData)))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.id").value(1));
    }

}package com.sme.climatedata;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sme.climatedata.controller.ClimateController;
import com.sme.climatedata.model.ClimateData;
import com.sme.climatedata.service.ClimateService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import java.util.Arrays;
import java.util.List;

import static org.mockito.Mockito.when;

@WebMvcTest(ClimateController.class)
public class ClimateControllerTest {

    private static final String BASE_URL = "/api/v1/climatedata";

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockBean
    private ClimateService climateService;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testGetAllClimateData() throws Exception {
        ClimateData climateData1 = new ClimateData();
        climateData1.setId(1L);
        ClimateData climateData2 = new ClimateData();
        climateData2.setId(2L);
        List<ClimateData> climateDataList = Arrays.asList(climateData1, climateData2);

        when(climateService.getAllClimateData()).thenReturn(climateDataList);

        mockMvc.perform(MockMvcRequestBuilders.get(BASE_URL)
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$[0].id").value(1))
                .andExpect(MockMvcResultMatchers.jsonPath("$[1].id").value(2));
    }

    @Test
    public void testGetClimateDataById() throws Exception {
        ClimateData climateData = new ClimateData();
        climateData.setId(1L);

        when(climateService.getClimateDataById(1L)).thenReturn(climateData);

        mockMvc.perform(MockMvcRequestBuilders.get(BASE_URL + "/{id}", 1)
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.id").value(1));
    }

    @Test
    public void testCreateClimateData() throws Exception {
        ClimateData climateData = new ClimateData();
        climateData.setId(1L);

        when(climateService.createClimateData(climateData)).thenReturn(climateData);

        mockMvc.perform(MockMvcRequestBuilders.post(BASE_URL)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(climateData)))
                .andExpect(MockMvcResultMatchers.status().isCreated())
                .andExpect(MockMvcResultMatchers.jsonPath("$.id").value(1));
    }

    @Test
    public void testUpdateClimateData() throws Exception {
        ClimateData climateData = new ClimateData();
        climateData.setId(1L);

        when(climateService.updateClimateData(1L, climateData)).thenReturn(climateData);

        mockMvc.perform(MockMvcRequestBuilders.put(BASE_URL + "/{id}", 1)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(climateData)))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.id").value(1));
    }

    @Test
    public void testDeleteClimateData() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.delete(BASE_URL + "/{id}", 1)
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(MockMvcResultMatchers.status().isNoContent());
    }
}