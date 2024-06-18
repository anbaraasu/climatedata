package com.preventivecare.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PatientDTO {
    private String patientName;
    private String doctorName;
    private String hospitalName;
    private String diagnosisDetails;
}