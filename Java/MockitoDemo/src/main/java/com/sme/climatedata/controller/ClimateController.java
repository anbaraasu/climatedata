// REST api Controller class for handling climate data related requests. ref: ClimateService.java file
package com.sme.climatedata.controller;

import com.sme.climatedata.model.ClimateData;
import com.sme.climatedata.service.ClimateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Controller for handling climate data related requests.
 */
@RestController
@RequestMapping("/climate")
public class ClimateController {

    private static final Logger _logger = LoggerFactory.getLogger(ClimateController.class);
    private final ClimateService _climateService;

    @Autowired
    public ClimateController(ClimateService climateService) {
        _logger.info("Initializing ClimateController");
        this._climateService = climateService;
    }

    /**
     * Get all climate data.
     *
     * @return List of all climate data.
     */
    @GetMapping("/all")
    public List<ClimateData> getAllClimateData() {
        _logger.info("Fetching all climate data");
        List<ClimateData> climateDataList = _climateService.getAllClimateData();
        _logger.debug("Fetched {} records", climateDataList.size());
        return climateDataList;
    }

    @GetMapping("/{id}")
    public ClimateData getClimateDataById(@PathVariable Integer id) {
        _logger.info("Fetching climate data for ID: {}", id);
        ClimateData climateData = _climateService.getClimateDataById(id);
        if (climateData != null) {
            _logger.debug("Fetched climate data: {}", climateData);
        } else {
            _logger.warn("No climate data found for ID: {}", id);
        }
        return climateData;
    }

    @PostMapping
    public ClimateData createClimateData(@RequestBody ClimateData climateData) {
        _logger.info("Creating new climate data: {}", climateData);
        ClimateData createdData = _climateService.createClimateData(climateData);
        _logger.debug("Created climate data: {}", createdData);
        return createdData;
    }

    @PutMapping("/{id}")
    public ClimateData updateClimateData(@PathVariable Integer id, @RequestBody ClimateData climateData) {
        _logger.info("Updating climate data for ID: {}", id);
        ClimateData updatedData = _climateService.updateClimateData(id, climateData);
        if (updatedData != null) {
            _logger.debug("Updated climate data: {}", updatedData);
        } else {
            _logger.warn("No climate data found to update for ID: {}", id);
        }
        return updatedData;
    }

    @DeleteMapping("/{id}")
    public void deleteClimateData(@PathVariable Integer id) {
        _logger.info("Deleting climate data for ID: {}", id);
        _climateService.deleteClimateData(id);
        _logger.debug("Deleted climate data for ID: {}", id);
    }

    @GetMapping("/city")
    public List<ClimateData> getClimateDataByCity() {
        _logger.info("Fetching climate data by city");
        List<ClimateData> climateDataList = _climateService.getClimateDataByCity();
        _logger.debug("Fetched {} records by city", climateDataList.size());
        return climateDataList;
    }
}