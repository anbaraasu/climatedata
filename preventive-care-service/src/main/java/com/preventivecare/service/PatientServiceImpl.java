package com.preventivecare.service;

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
        // flatten patient object to DTO including child collections, one patient will
        // have multiple diagnosis, diagnosis will have hospital and doctor 
        return patientRepository.findAll().stream()
                .flatMap(p -> p.getDiagnosis().stream()
                        .map(d -> PatientDTO.builder()
                                .patientName(p.getName())
                                .doctorName(d.getDoctor().getName())
                                .hospitalName(d.getHospital().getName())
                                .diagnosisDetails(d.getDescription())
                                .build()))
                .collect(Collectors.toList());
    }
}