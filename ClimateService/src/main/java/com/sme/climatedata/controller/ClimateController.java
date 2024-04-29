package com.sme.climatedata.controller;

import com.sme.climatedata.model.ClimateData;
import com.sme.climatedata.service.ClimateService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

//Rest Controller API for Climate Data version 1.0
@RestController
@RequestMapping("/api/v1/climate")
public class ClimateController {

    private final ClimateService climateService;

    public ClimateController(ClimateService climateService) {
        this.climateService = climateService;
    }

    //Get all Climate Data
    @GetMapping
    public ResponseEntity<List<ClimateData>> getAllClimateData() {
        return new ResponseEntity<>(climateService.getAllClimateData(), HttpStatus.OK);
    }

    //Get Climate Data by Id
    @GetMapping("/{id}")
    public ResponseEntity<ClimateData> getClimateDataById(@PathVariable Long id) {
        return new ResponseEntity<>(climateService.getClimateDataById(id), HttpStatus.OK);
    }

    //Create Climate Data
    @PostMapping
    public ResponseEntity<ClimateData> createClimateData(@RequestBody ClimateData climateData) {
        return new ResponseEntity<>(climateService.createClimateData(climateData), HttpStatus.CREATED);
    }

    //Update Climate Data
    @PutMapping("/{id}")
    public ResponseEntity<ClimateData> updateClimateData(@PathVariable Long id, @RequestBody ClimateData climateData) {
        return new ResponseEntity<>(climateService.updateClimateData(id, climateData), HttpStatus.OK);
    }

    //Delete Climate Data
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteClimateData(@PathVariable Long id) {
        climateService.deleteClimateData(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}