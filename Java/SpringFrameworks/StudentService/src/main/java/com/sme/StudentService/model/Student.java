package com.sme.StudentService.model;

import java.util.Date;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Builder;
import lombok.Data;

// Student Entity class with id, firstname, lastname, gender, dob, active(true or false)
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Student {
    // Private fields
    @Id
    private int _id; // Unique identifier for the student
    private String _firstname; // First name of the student
    private String _lastname; // Last name of the student
    private String _gender; // Gender of the student
    private Date _dob; // Date of birth of the student
    private boolean _active; // Active status of the student

    //setid method
    public void setId(int id) {
        this._id = id; // Set the student ID
    }
}