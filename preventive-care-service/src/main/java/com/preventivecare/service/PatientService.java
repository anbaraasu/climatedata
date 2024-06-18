package com.preventivecare.service;

import java.util.List;

import com.preventivecare.dto.PatientDTO;

public interface PatientService {
    List<PatientDTO> getAllPatients();
}