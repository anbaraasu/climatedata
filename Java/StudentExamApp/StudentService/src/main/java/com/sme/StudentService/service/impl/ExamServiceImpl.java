package com.sme.StudentService.service.impl;

import com.sme.StudentService.model.Exam;
import com.sme.StudentService.repo.ExamRepository;
import com.sme.StudentService.service.ExamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

// Implementation of ExamService interface using ExamRepository
@Service
public class ExamServiceImpl implements ExamService {

    @Autowired
    private ExamRepository _examRepository; // Injecting ExamRepository

    @Override
    public Exam createExam(Exam exam) {
        return _examRepository.save(exam); // Save and return the exam
    }

    @Override
    public Optional<Exam> getExamById(int id) {
        return _examRepository.findById(id); // Find and return the exam by ID
    }

    @Override
    public List<Exam> getAllExams() {
        return (List<Exam>) _examRepository.findAll(); // Return all exams
    }

    @Override
    public Exam updateExam(int id, Exam updatedExam) {
        if (_examRepository.existsById(id)) {
            updatedExam.set_id(id); // Ensure the ID remains the same
            return _examRepository.save(updatedExam); // Save and return the updated exam
        }
        return null; // Return null if exam not found
    }

    @Override
    public void deleteExam(int id) {
        _examRepository.deleteById(id); // Delete the exam by ID
    }
}
