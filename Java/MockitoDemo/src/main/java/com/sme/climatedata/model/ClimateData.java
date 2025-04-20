package com.sme.climatedata.model;

//climate data model
//include allargs, no-args, data and entity annotations from lombok

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

//jakarta persistence annotations
@Data
@AllArgsConstructor
@Entity
@NoArgsConstructor
public class ClimateData {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String city;
    private String country;
    private String monthData;
    private Float temperature;
    private Float humidity;
    private Float precipitation;
} 