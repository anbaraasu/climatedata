// REST api Controller class for handling climate data related requests. ref: ClimateService.java file
package com.sme.climatedata.controller;

import com.sme.climatedata.model.ClimateData;
import com.sme.climatedata.service.ClimateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Controller for handling climate data related requests.
 */
@RestController
@RequestMapping("/climate")
public class ClimateController {

    private final ClimateService _climateService;

    @Autowired
    public ClimateController(ClimateService climateService) {
        this._climateService = climateService;
    }

    /**
     * Get all climate data.
     *
     * @return List of all climate data.
     */
    @GetMapping("/all")
    public List<ClimateData> getAllClimateData() {
        return _climateService.getAllClimateData();
    }
}