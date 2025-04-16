package com.sme.StudentService.controller;

import com.sme.StudentService.model.Exam;
import com.sme.StudentService.service.ExamService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

// Base URL = http://localhost:1234/api/v1/exams/
@Tag(name = "Exam Controller", description = "APIs for managing exams")
@RestController
@RequestMapping("/api/v1/exams")
public class ExamController {

    @Autowired
    private ExamService _examService;

    @Operation(summary = "Create an exam", description = "Create a new exam record")
    @PostMapping("/")
    public Exam createExam(@RequestBody Exam exam) {
        return _examService.createExam(exam); // Create and return the new exam
    }

    @Operation(summary = "Get exam by ID", description = "Retrieve an exam record by its ID")
    @GetMapping("/{id}")
    public Optional<Exam> getExamById(@PathVariable int id) {
        return _examService.getExamById(id); // Retrieve and return the exam by ID
    }

    @Operation(summary = "Get all exams", description = "Retrieve all exam records")
    @GetMapping("/all")
    public List<Exam> getAllExams() {
        return _examService.getAllExams(); // Retrieve and return all exams
    }

    @Operation(summary = "Update an exam", description = "Update an existing exam record")
    @PutMapping("/{id}")
    public Exam updateExam(@PathVariable int id, @RequestBody Exam exam) {
        return _examService.updateExam(id, exam); // Update and return the exam
    }

    @Operation(summary = "Delete an exam", description = "Delete an exam record by its ID")
    @DeleteMapping("/{id}")
    public void deleteExam(@PathVariable int id) {
        _examService.deleteExam(id); // Delete the exam by ID
    }
}
