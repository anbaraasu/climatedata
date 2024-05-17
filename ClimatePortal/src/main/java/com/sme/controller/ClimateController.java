package com.sme.controller;

import com.sme.model.ClimateData;
import com.sme.service.ClimateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/api/climate")
public class ClimateController {

    private final ClimateService climateService;

    @Autowired
    public ClimateController(ClimateService climateService) {
        this.climateService = climateService;
    }

    @GetMapping
    public List<ClimateData> getAllClimateData() {
        return climateService.getClimateData();
    }
}