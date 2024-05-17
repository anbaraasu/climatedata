package com.sme.service;

import com.sme.model.ClimateData;

import java.util.List;

import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class ClimateService {

    private static final String API_URL = "http://localhost:1111/api/v1/climate";

    private final RestTemplate restTemplate;

    public ClimateService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public List<ClimateData> getClimateData() {
        //call the api and get the response as List<ClimateData>
        return restTemplate.exchange(API_URL, HttpMethod.GET, null, new ParameterizedTypeReference<List<ClimateData>>() {
        }).getBody();
    }
}