package com.sme.StudentService.service;

import com.sme.StudentService.model.Exam;

import java.util.List;
import java.util.Optional;

// Interface for CRUD operations on Exam model
public interface ExamService {
    Exam createExam(Exam exam); // Create a new exam

    Optional<Exam> getExamById(int id); // Retrieve an exam by ID

    List<Exam> getAllExams(); // Retrieve all exams

    Exam updateExam(int id, Exam exam); // Update an existing exam

    void deleteExam(int id); // Delete an exam by ID
}
