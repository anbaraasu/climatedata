package com.sme.climatedata.controller; // Add the missing package declaration

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import com.sme.climatedata.model.ClimateData;
import com.sme.climatedata.service.ClimateService;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import java.util.List;

/**
 * The ClimateController class is responsible for handling HTTP requests related to climate data.
 * It provides endpoints for retrieving, adding, updating, and deleting climate data.
 */
@RestController
@RequestMapping("/api/v1")
public class ClimateController {
    private final ClimateService climateService;

    /**
     * The ClimateController class is responsible for handling HTTP requests related to climate data.
     */
    @Autowired
    public ClimateController(ClimateService climateService) {
        this.climateService = climateService;
    }

    @GetMapping("/climate")
    public List<ClimateData> getAllClimateData() {
        return climateService.getAllClimateData();
    }

    @GetMapping("/climate/{id}")
    public ClimateData getClimateDataById(@PathVariable Long id) {
        return climateService.getClimateDataById(id);
    }

    @PostMapping("/climate")
    public ClimateData addClimateData(@RequestBody ClimateData climateData) {
        return climateService.createClimateData(climateData); // Fix: Check if the method is defined in ClimateService and import it if necessary
    }

    @PutMapping("/climate/{id}")
    public ClimateData updateClimateData(@PathVariable Long id, @RequestBody ClimateData climateData) {
        return climateService.updateClimateData(id, climateData); // Fix: Check if the method accepts a Long parameter and update it if necessary
    }

    @DeleteMapping("/climate/{id}")
    public void deleteClimateData(@PathVariable Long id) {
        climateService.deleteClimateData(id); // Fix: Check if the method accepts a Long parameter and update it if necessary
    }
}