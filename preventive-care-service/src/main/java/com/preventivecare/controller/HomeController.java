package com.preventivecare.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping; // Import the RequestMapping class
import org.springframework.web.bind.annotation.RestController;

import com.preventivecare.dto.PatientDTO;
import com.preventivecare.service.PatientService;

//Rest Controller - get all patient dto from service
@RestController
public class HomeController {

    @Autowired
    private PatientService patientService;

    @RequestMapping("/patients")
    public List<PatientDTO> getAllPatients() {
        return patientService.getAllPatients();
    }
}