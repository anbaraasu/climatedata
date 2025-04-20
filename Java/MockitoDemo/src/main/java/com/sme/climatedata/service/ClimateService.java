package com.sme.climatedata.service;

//climate service interface
import com.sme.climatedata.model.ClimateData;
import java.util.List;

public interface ClimateService {
    List<ClimateData> getAllClimateData();
    ClimateData getClimateDataById(Integer id);
    ClimateData createClimateData(ClimateData climateData);
    ClimateData updateClimateData(Integer id, ClimateData climateData);
    void deleteClimateData(Integer id);
    List<ClimateData> getClimateDataByCity();
}