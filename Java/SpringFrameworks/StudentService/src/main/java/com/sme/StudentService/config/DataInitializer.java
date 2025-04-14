package com.sme.StudentService.config;

import com.sme.StudentService.model.Student;
import com.sme.StudentService.repo.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.Date; 

// Class to initialize student records during application startup
@Component
public class DataInitializer implements CommandLineRunner {

    // Injecting StudentRepository
    @Autowired
    private StudentRepository _studentRepository;

    @Override
    public void run(String... args) throws Exception {
        // Adding sample student records
        _studentRepository.save(Student.builder()
                ._id(1)
                ._firstname("John")
                ._lastname("Doe")
                ._gender("Male")
                ._dob(new Date(2000 - 1900, 1, 15)) // Date(year, month, day)
                ._active(true)
                .build());

        _studentRepository.save(Student.builder()
                ._id(2)
                ._firstname("Jane")
                ._lastname("Smith")
                ._gender("Female")
                ._dob(new Date(1998 - 1900, 5, 20))
                ._active(true)
                .build());

        _studentRepository.save(Student.builder()
                ._id(3)
                ._firstname("Alice")
                ._lastname("Johnson")
                ._gender("Female")
                ._dob(new Date(2001 - 1900, 10, 5))
                ._active(false)
                .build());

        System.out.println("Sample student records added to the database.");
    }
}
