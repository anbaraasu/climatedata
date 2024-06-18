package com.sme.climatedata.service;


//climate service implementation class
import com.sme.climatedata.model.ClimateData;
import com.sme.climatedata.repository.ClimateDataRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClimateServiceImpl implements ClimateService {
    private final ClimateDataRepository climateDataRepository;

    @Autowired
    public ClimateServiceImpl(ClimateDataRepository climateDataRepository) {
        this.climateDataRepository = climateDataRepository;
    }

    @Override
    public List<ClimateData> getAllClimateData() {
        return climateDataRepository.findAll();
    }

    @Override
    public ClimateData getClimateDataById(Long id) {
        return climateDataRepository.findById(id).orElse(null);
    }

    @Override
    public ClimateData createClimateData(ClimateData climateData) {
        return climateDataRepository.save(climateData);
    }

    @Override
    public ClimateData updateClimateData(Long id, ClimateData climateData) {
        ClimateData existingClimateData = climateDataRepository.findById(id).orElse(null);
        if (existingClimateData != null) {
            existingClimateData.setCity(climateData.getCity());
            existingClimateData.setTemperature(climateData.getTemperature());
            existingClimateData.setHumidity(climateData.getHumidity());
            existingClimateData.setPrecipitation(climateData.getPrecipitation());
            return climateDataRepository.save(existingClimateData);
        }
        return null;
    }

    @Override
    public void deleteClimateData(Long id) {
        climateDataRepository.deleteById(id);
    }

    @Override
    public List<ClimateData> getClimateDataByCity() {
        return climateDataRepository.findAll();
    }
}
