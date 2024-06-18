package com.preventivecare.controller;

import com.preventivecare.model.CareEntry;
import com.preventivecare.service.PreventiveCareService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/care-entries")
public class PreventiveCareController {

    private final PreventiveCareService preventiveCareService;

    @Autowired
    public PreventiveCareController(PreventiveCareService preventiveCareService) {
        this.preventiveCareService = preventiveCareService;
    }

    @GetMapping
    public ResponseEntity<List<CareEntry>> getAllCareEntries() {
        List<CareEntry> careEntries = preventiveCareService.getAllCareEntries();
        return new ResponseEntity<>(careEntries, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<CareEntry> getCareEntryById(@PathVariable Long id) {
        CareEntry careEntry = preventiveCareService.getCareEntryById(id);
        if (careEntry != null) {
            return new ResponseEntity<>(careEntry, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping
    public ResponseEntity<CareEntry> createCareEntry(@RequestBody CareEntry careEntry) {
        CareEntry createdCareEntry = preventiveCareService.createCareEntry(careEntry);
        return new ResponseEntity<>(createdCareEntry, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<CareEntry> updateCareEntry(@PathVariable Long id, @RequestBody CareEntry careEntry) {
        CareEntry updatedCareEntry = preventiveCareService.updateCareEntry(id, careEntry);
        if (updatedCareEntry != null) {
            return new ResponseEntity<>(updatedCareEntry, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCareEntry(@PathVariable Long id) {
        preventiveCareService.deleteCareEntry(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}