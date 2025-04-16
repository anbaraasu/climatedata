package com.sme.StudentService.config;

import com.sme.StudentService.model.Student;
import com.sme.StudentService.repo.StudentRepository;
import com.sme.StudentService.model.Exam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

// Class to initialize student records during application startup
@Component
public class DataInitializer implements CommandLineRunner {

    // Injecting StudentRepository
    @Autowired
    private StudentRepository _studentRepository;

    @Override
    public void run(String... args) throws Exception {
        // Adding sample student records
        Student student1 = _studentRepository.save(Student.builder()
                ._id(1)
                ._firstname("John")
                ._lastname("Doe")
                ._gender("Male")
                ._dob(new Date(2000 - 1900, 1, 15)) // Date(year, month, day)
                ._active(true)
                .build());

        Student student2 = _studentRepository.save(Student.builder()
                ._id(2)
                ._firstname("Jane")
                ._lastname("Smith")
                ._gender("Female")
                ._dob(new Date(1998 - 1900, 5, 20))
                ._active(true)
                .build());

        Student student3 = _studentRepository.save(Student.builder()
                ._id(3)
                ._firstname("Alice")
                ._lastname("Johnson")
                ._gender("Female")
                ._dob(new Date(2001 - 1900, 10, 5))
                ._active(false)
                .build());

        // Adding sample exam records for each student
        student1.set_exams(List.of(
                Exam.builder()._examName("Math")._examDate(new Date())._examScore(85.5)._student(student1).build(),
                Exam.builder()._examName("Science")._examDate(new Date())._examScore(90.0)._student(student1).build()
        ));

        student2.set_exams(List.of(
                Exam.builder()._examName("Math")._examDate(new Date())._examScore(78.0)._student(student2).build(),
                Exam.builder()._examName("English")._examDate(new Date())._examScore(88.5)._student(student2).build()
        ));

        student3.set_exams(List.of(
                Exam.builder()._examName("History")._examDate(new Date())._examScore(92.0)._student(student3).build(),
                Exam.builder()._examName("Geography")._examDate(new Date())._examScore(81.0)._student(student3).build()
        ));

        _studentRepository.save(student1);
        _studentRepository.save(student2);
        _studentRepository.save(student3);

        System.out.println("Sample student and exam records added to the database.");
    }
}
