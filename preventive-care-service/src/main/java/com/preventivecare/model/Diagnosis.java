package com.preventivecare.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Diagnosis {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private Date date;
    private String description;

    // one to one with hospital
    @OneToOne
    private Hospital hospital;

    // one to many rel with doctor
    @OneToOne
    private Doctor doctor;

    // Many Diagnosis to one Patient
    @ManyToOne
    @JoinColumn(name = "patient_id")
    private Patient patient;
    
    
}