//Climate Data Rest Controller

package com.sme.climatedata.controller;

import com.sme.climatedata.model.ClimateData;
import com.sme.climatedata.service.ClimateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * The `ClimateController` class is the REST controller for the Climate Data service.
 * It allows the user to perform CRUD operations on climate data.
 */
@RestController
@RequestMapping("/climate")
public class ClimateController {

    @Autowired
    private ClimateService climateService;

    /**
     * The `getClimateData` method retrieves all climate data from the database.
     *
     * @return A list of all climate data.
     */
    @GetMapping
    public List<ClimateData> getClimateData() {
        return climateService.getAllClimateData();
    }

    /**
     * The `getClimateDataById` method retrieves a specific climate data record from the database.
     *
     * @param id The ID of the climate data record to retrieve.
     * @return The climate data record with the specified ID.
     */
    @GetMapping("/{id}")
    public ClimateData getClimateDataById(@PathVariable Long id) {
        return climateService.getClimateDataById(id);
    }

    
}
