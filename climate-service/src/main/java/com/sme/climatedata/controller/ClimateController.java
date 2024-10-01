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

    /**
     * Get climate data by ID.
     *
     * @param id the ID of the climate data.
     * @return the climate data with the specified ID.
     */
    @GetMapping("/{id}")
    public ClimateData getClimateDataById(@PathVariable Long id) {
        return _climateService.getClimateDataById(id);
    }

    /**
     * Add new climate data.
     *
     * @param climateData the climate data to add.
     * @return the added climate data.
     */
    @PostMapping("/add")
    public ClimateData addClimateData(@RequestBody ClimateData climateData) {
        return _climateService.createClimateData(climateData);
    }

    

    /**
     * Delete climate data by ID.
     *
     * @param id the ID of the climate data to delete.
     */
    @DeleteMapping("/delete/{id}")
    public void deleteClimateData(@PathVariable Long id) {
        _climateService.deleteClimateData(id);
    }
}