package com.sme.climatedata.controller;

//rest controller class for climatedata model for CRUD operations using ClaimService interface with all imports statement

import com.sme.climatedata.model.ClimateData;
import com.sme.climatedata.service.ClimateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/climate")
public class ClimateController {
    private final ClimateService climateService;

    @Autowired
    public ClimateController(ClimateService climateService) {
        this.climateService = climateService;
    }

    @GetMapping
    public ResponseEntity<List<ClimateData>> getAllClimateData() {
        return new ResponseEntity<>(climateService.getAllClimateData(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ClimateData> getClimateDataById(@PathVariable Long id) {
        return new ResponseEntity<>(climateService.getClimateDataById(id), HttpStatus.OK);
    }

    @PostMapping
    public ResponseEntity<ClimateData> createClimateData(@RequestBody ClimateData climateData) {
        return new ResponseEntity<>(climateService.createClimateData(climateData), HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ClimateData> updateClimateData(@PathVariable Long id, @RequestBody ClimateData climateData) {
        return new ResponseEntity<>(climateService.updateClimateData(id, climateData), HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteClimateData(@PathVariable Long id) {
        climateService.deleteClimateData(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @GetMapping("/city")
    public ResponseEntity<List<ClimateData>> getClimateDataByCity() {
        return new ResponseEntity<>(climateService.getClimateDataByCity(), HttpStatus.OK);
    }
}