package com.preventivecare.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

// Patient Repo
import com.preventivecare.model.Patient;

@Repository
public interface PatientRepository extends JpaRepository<Patient, Long> {
}
