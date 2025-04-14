package com.sme.StudentService.controller;

import com.sme.StudentService.model.Student;
import com.sme.StudentService.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

//Base URL = http://localhost:1234/api/v1/students/

@RestController
@RequestMapping("/api/v1/students")
public class StudentController {

    @Autowired
    private StudentService _studentService;

    @GetMapping("/")
    public String welcome() {
        return "Welcome to Student Service API!"; // Welcome message for the API
    }

    @GetMapping("/all")
    public List<Student> getAllStudents() {
        return _studentService.getAllStudents(); // Retrieve and return all student records
    }
}