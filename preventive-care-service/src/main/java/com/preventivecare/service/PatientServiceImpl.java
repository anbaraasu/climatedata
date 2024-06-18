package com.preventivecare.service.impl;

import com.preventivecare.dto.PatientDTO;
import com.preventivecare.model.Patient;
import com.preventivecare.repository.PatientRepository;
import com.preventivecare.service.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class PatientServiceImpl implements PatientService {

    private final PatientRepository patientRepository;

    @Autowired
    public PatientServiceImpl(PatientRepository patientRepository) {
        this.patientRepository = patientRepository;
    }

    @Override
    public List<PatientDTO> getAllPatients() {
        return patientRepository.findAll().stream().map(this::convertToDTO).collect(Collectors.toList());
    }

    private PatientDTO convertToDTO(Patient patient) {
        return new PatientDTO(
                patient.getPatientName(),
                patient.getDoctorName(),
                patient.getHospitalName(),
                patient.getDiagnosisDetails()
        );
    }
}