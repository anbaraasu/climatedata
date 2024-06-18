package com.sme.climatedata.service;

//climate service interface
import com.sme.climatedata.model.ClimateData;
import java.util.List;

public interface ClimateService {
    List<ClimateData> getAllClimateData();
    ClimateData getClimateDataById(Long id);
    ClimateData createClimateData(ClimateData climateData);
    ClimateData updateClimateData(Long id, ClimateData climateData);
    void deleteClimateData(Long id);
    List<ClimateData> getClimateDataByCity();
}