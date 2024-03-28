package com.sme.climatedata.controller;

import com.sme.climatedata.model.ClimateData;
import com.sme.climatedata.service.ClimateService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Controller class for handling climate data related requests.
 */
@RestController
@RequestMapping("/api/v1/climatedata")
public class ClimateController {

    private final ClimateService climateService;

    /**
     * Constructor for ClimateController.
     * @param climateService The ClimateService instance to be used for handling climate data.
     */
    public ClimateController(ClimateService climateService) {
        this.climateService = climateService;
    }

    /**
     * Get all climate data.
     * @return A ResponseEntity containing a list of ClimateData objects.
     */
    @GetMapping
    public ResponseEntity<List<ClimateData>> getAllClimateData() {
        return ResponseEntity.ok(climateService.getAllClimateData());
    }

    /**
     * Get climate data by ID.
     * @param id The ID of the climate data.
     * @return A ResponseEntity containing the ClimateData object with the specified ID.
     */
    @GetMapping("/{id}")
    public ResponseEntity<ClimateData> getClimateDataById(@PathVariable Long id) {
        return ResponseEntity.ok(climateService.getClimateDataById(id));
    }

    /**
     * Create new climate data.
     * @param climateData The ClimateData object to be created.
     * @return A ResponseEntity containing the created ClimateData object.
     */
    @PostMapping
    public ResponseEntity<ClimateData> createClimateData(@RequestBody ClimateData climateData) {
        return ResponseEntity.status(HttpStatus.CREATED).body(climateService.createClimateData(climateData));
    }

    /**
     * Update existing climate data.
     * @param id The ID of the climate data to be updated.
     * @param climateData The updated ClimateData object.
     * @return A ResponseEntity containing the updated ClimateData object.
     */
    @PutMapping("/{id}")
    public ResponseEntity<ClimateData> updateClimateData(@PathVariable Long id, @RequestBody ClimateData climateData) {
        return ResponseEntity.ok(climateService.updateClimateData(id, climateData));
    }

    /**
     * Delete climate data by ID.
     * @param id The ID of the climate data to be deleted.
     * @return A ResponseEntity with no content.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteClimateData(@PathVariable Long id) {
        climateService.deleteClimateData(id);
        return ResponseEntity.noContent().build();
    }
}
