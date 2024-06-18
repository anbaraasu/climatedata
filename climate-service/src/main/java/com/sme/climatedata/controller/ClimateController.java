// REST api Controller class for handling climate data related requests.

package com.sme.climatedata.controller;

import com.sme.climatedata.model.ClimateData;
import com.sme.climatedata.service.ClimateService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/climate")
public class ClimateController {

    @Autowired
    private ClimateService climateService;

    @GetMapping()
    public List<ClimateData> getAllClimateData() {
        return climateService.getAllClimateData();
    }
}