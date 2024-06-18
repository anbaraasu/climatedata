package com.preventivecare.repository;

import com.preventivecare.model.CareEntry;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CareEntryRepository extends JpaRepository<CareEntry, Long> {
    // Add custom query methods if needed
}