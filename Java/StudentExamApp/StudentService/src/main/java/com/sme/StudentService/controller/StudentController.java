package com.sme.StudentService.controller;

import com.sme.StudentService.model.Student;
import com.sme.StudentService.service.StudentService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

//Base URL = http://localhost:1234/api/v1/students/

@Tag(name = "Student Controller", description = "APIs for managing students")
@RestController
@RequestMapping("/api/v1/students")
public class StudentController {

    @Autowired
    private StudentService _studentService;

    @Operation(summary = "Welcome message", description = "Returns a welcome message for the API")
    @GetMapping("/")
    public String welcome() {
        return "Welcome to Student Service API!"; // Welcome message for the API
    }

    @Operation(summary = "Get all students", description = "Retrieve all student records")
    @GetMapping("/all")
    public List<Student> getAllStudents() {
        return _studentService.getAllStudents(); // Retrieve and return all student records
    }

    @Operation(summary = "Get student by ID", description = "Retrieve a student record by its ID")
    @GetMapping("/{id}")
    public Student getStudentById(@PathVariable int id) {
        return _studentService.getStudentById(id).orElse(null); // Retrieve and return the student by ID
    }

    @Operation(summary = "Create a student", description = "Create a new student record")
    @PostMapping("/")
    public Student createStudent(@RequestBody Student student) {
        return _studentService.createStudent(student); // Create and return the new student
    }

    @Operation(summary = "Update a student", description = "Update an existing student record")
    @PutMapping("/{id}")
    public Student updateStudent(@PathVariable int id, @RequestBody Student student) {
        return _studentService.updateStudent(id, student); // Update and return the student
    }

    @Operation(summary = "Delete a student", description = "Delete a student record by its ID")
    @DeleteMapping("/{id}")
    public void deleteStudent(@PathVariable int id) {
        _studentService.deleteStudent(id); // Delete the student by ID
    }
}