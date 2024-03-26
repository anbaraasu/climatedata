package com.sme.climatedata.controller;

import com.sme.climatedata.model.ClimateData;
import com.sme.climatedata.service.ClimateService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * The controller class for ClimateData model, responsible for handling CRUD operations using the ClimateService interface.
 * This class follows REST API best practices and is versioned under "/api/v1/climatedata" endpoint.
 */
@RestController
@RequestMapping("/api/v1/climatedata")
public class ClimateController {

    private final ClimateService climateService;

    /**
     * Constructs a new ClimateController with the given ClimateService.
     *
     * @param climateService The ClimateService implementation to be used for handling ClimateData operations.
     */
    public ClimateController(ClimateService climateService) {
        this.climateService = climateService;
    }

    /**
     * Creates a new ClimateData record.
     *
     * @param climateData The ClimateData object to be created.
     * @return The ResponseEntity containing the created ClimateData object and the HTTP status code 201 (Created).
     */
    @PostMapping
    public ResponseEntity<ClimateData> createClimateData(@RequestBody ClimateData climateData) {
        return new ResponseEntity<>(climateService.createClimateData(climateData), HttpStatus.CREATED);
    }

    /**
     * Retrieves all ClimateData records.
     *
     * @return The ResponseEntity containing a list of all ClimateData objects and the HTTP status code 200 (OK).
     */
    @GetMapping
    public ResponseEntity<List<ClimateData>> getAllClimateData() {
        return new ResponseEntity<>(climateService.getAllClimateData(), HttpStatus.OK);
    }

    /**
     * Retrieves a specific ClimateData record by its ID.
     *
     * @param id The ID of the ClimateData record to be retrieved.
     * @return The ResponseEntity containing the retrieved ClimateData object and the HTTP status code 200 (OK).
     */
    @GetMapping("/{id}")
    public ResponseEntity<ClimateData> getClimateDataById(@PathVariable Long id) {
        return new ResponseEntity<>(climateService.getClimateDataById(id), HttpStatus.OK);
    }

    /**
     * Updates a specific ClimateData record.
     *
     * @param id           The ID of the ClimateData record to be updated.
     * @param climateData  The updated ClimateData object.
     * @return The ResponseEntity containing the updated ClimateData object and the HTTP status code 200 (OK).
     */
    @PutMapping("/{id}")
    public ResponseEntity<ClimateData> updateClimateData(@PathVariable Long id, @RequestBody ClimateData climateData) {
        return new ResponseEntity<>(climateService.updateClimateData(id, climateData), HttpStatus.OK);
    }

    /**
     * Deletes a specific ClimateData record.
     *
     * @param id The ID of the ClimateData record to be deleted.
     * @return The ResponseEntity with no content and the HTTP status code 204 (No Content).
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteClimateData(@PathVariable Long id) {
        climateService.deleteClimateData(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}