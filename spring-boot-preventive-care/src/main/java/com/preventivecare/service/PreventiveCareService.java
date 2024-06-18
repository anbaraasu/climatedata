package com.preventivecare.service;

import com.preventivecare.model.CareEntry;
import com.preventivecare.repository.CareEntryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PreventiveCareService {

    private final CareEntryRepository careEntryRepository;

    @Autowired
    public PreventiveCareService(CareEntryRepository careEntryRepository) {
        this.careEntryRepository = careEntryRepository;
    }

    public List<CareEntry> getAllCareEntries() {
        return careEntryRepository.findAll();
    }

    public CareEntry getCareEntryById(Long id) {
        return careEntryRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Care entry not found with id: " + id));
    }

    public CareEntry createCareEntry(CareEntry careEntry) {
        return careEntryRepository.save(careEntry);
    }

    public CareEntry updateCareEntry(Long id, CareEntry careEntry) {
        CareEntry existingCareEntry = getCareEntryById(id);
        existingCareEntry.setTitle(careEntry.getTitle());
        existingCareEntry.setDescription(careEntry.getDescription());
        // Update other fields as needed
        return careEntryRepository.save(existingCareEntry);
    }

    public void deleteCareEntry(Long id) {
        CareEntry careEntry = getCareEntryById(id);
        careEntryRepository.delete(careEntry);
    }
}