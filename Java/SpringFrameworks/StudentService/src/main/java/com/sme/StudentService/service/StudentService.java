package com.sme.StudentService.service;

import com.sme.StudentService.model.Student;
import java.util.List;
import java.util.Optional;

// Interface for CRUD operations on Student model
public interface StudentService {
    // Create a new student
    Student createStudent(Student student);

    // Retrieve a student by ID
    Optional<Student> getStudentById(int id);

    // Retrieve all students
    List<Student> getAllStudents();

    // Update an existing student
    Student updateStudent(int id, Student student);

    // Delete a student by ID
    void deleteStudent(int id);
}
