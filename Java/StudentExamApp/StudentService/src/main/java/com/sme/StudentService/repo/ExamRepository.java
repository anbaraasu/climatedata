package com.sme.StudentService.repo;

import com.sme.StudentService.model.Exam;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

// Repository interface for Exam entity
@Repository
public interface ExamRepository extends CrudRepository<Exam, Integer> {
}
