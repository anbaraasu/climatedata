package com.sme.StudentService.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

// Exam Entity class with id, examName, examDate, and examScore
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Exam {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int _id; // Unique identifier for the exam

    private String _examName; // Name of the exam

    private Date _examDate; // Date of the exam

    private double _examScore; // Score of the exam

    @ManyToOne
    @JoinColumn(name = "student_id", nullable = false)
    private Student _student; // Associated student
}
