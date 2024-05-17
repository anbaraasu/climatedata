package com.sme.model;

//climate data model
//include allargs, no-args, data and entity annotations from lombok

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


//jakarta persistence annotations
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ClimateData {
    private Integer id;
    private String city;
    private String country;
    private String monthData;
    private Float temperature;
    private Float humidity;
    private Float precipitation;
} 