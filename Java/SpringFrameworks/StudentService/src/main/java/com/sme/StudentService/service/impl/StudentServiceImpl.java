package com.sme.StudentService.service.impl;

import com.sme.StudentService.model.Student;
import com.sme.StudentService.repo.StudentRepository;
import com.sme.StudentService.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

// Implementation of StudentService interface using StudentRepository
@Service
public class StudentServiceImpl implements StudentService {

    // Injecting StudentRepository
    @Autowired
    private StudentRepository _studentRepository;

    // Create a new student
    @Override
    public Student createStudent(Student student) {
        return _studentRepository.save(student); // Save and return the student
    }

    // Retrieve a student by ID
    @Override
    public Optional<Student> getStudentById(int id) {
        return _studentRepository.findById(id); // Find and return the student by ID
    }

    // Retrieve all students
    @Override
    public List<Student> getAllStudents() {
        return (List<Student>) _studentRepository.findAll(); // Return all students
    }

    // Update an existing student
    @Override
    public Student updateStudent(int id, Student updatedStudent) {
        if (_studentRepository.existsById(id)) {
            updatedStudent.setId(id); // Ensure the ID remains the same
            return _studentRepository.save(updatedStudent); // Save and return the updated student
        }
        return null; // Return null if student not found
    }

    // Delete a student by ID
    @Override
    public void deleteStudent(int id) {
        _studentRepository.deleteById(id); // Delete the student by ID
    }
}
