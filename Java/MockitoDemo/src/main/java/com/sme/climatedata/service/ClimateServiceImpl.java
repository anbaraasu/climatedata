package com.sme.climatedata.service;


//climate service implementation class
import com.sme.climatedata.model.ClimateData;
import com.sme.climatedata.repository.ClimateDataRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

/**
 * Implementation of the ClimateService interface.
 * This service provides methods to manage climate data.
 * It interacts with the ClimateDataRepository to perform CRUD operations.
 * 
 * @Service - Indicates that this class is a Spring service component.
 */
@Service
public class ClimateServiceImpl implements ClimateService {

    private static final Logger _logger = LoggerFactory.getLogger(ClimateServiceImpl.class);
    private final ClimateDataRepository climateDataRepository;

    /**
     * Service implementation for managing climate data.
     * 
     * This service provides methods to interact with the climate data repository.
     * It is annotated with {@code @Autowired} to automatically inject the 
     * {@link ClimateDataRepository} dependency.
     * 
     * @param climateDataRepository the repository used to access climate data
     */
    @Autowired
    public ClimateServiceImpl(ClimateDataRepository climateDataRepository) {
        _logger.info("Initializing ClimateServiceImpl");
        this.climateDataRepository = climateDataRepository;
    }

    @Override
    public List<ClimateData> getAllClimateData() {
        _logger.info("Fetching all climate data");
        List<ClimateData> climateDataList = climateDataRepository.findAll();
        _logger.debug("Fetched {} records", climateDataList.size());
        return climateDataList;
    }

    @Override
    public ClimateData getClimateDataById(Integer id) {
        _logger.info("Fetching climate data for ID: {}", id);
        ClimateData climateData = climateDataRepository.findById(id).orElse(null);
        if (climateData != null) {
            _logger.debug("Fetched climate data: {}", climateData);
        } else {
            _logger.warn("No climate data found for ID: {}", id);
        }
        return climateData;
    }

    @Override
    public ClimateData createClimateData(ClimateData climateData) {
        _logger.info("Creating new climate data: {}", climateData);
        ClimateData createdData = climateDataRepository.save(climateData);
        _logger.debug("Created climate data: {}", createdData);
        return createdData;
    }

    @Override
    public ClimateData updateClimateData(Integer id, ClimateData climateData) {
        _logger.info("Updating climate data for ID: {}", id);
        ClimateData existingClimateData = climateDataRepository.findById(id).orElse(null);
        if (existingClimateData != null) {
            _logger.debug("Existing climate data: {}", existingClimateData);
            existingClimateData.setCity(climateData.getCity());
            existingClimateData.setTemperature(climateData.getTemperature());
            existingClimateData.setHumidity(climateData.getHumidity());
            existingClimateData.setPrecipitation(climateData.getPrecipitation());
            ClimateData updatedData = climateDataRepository.save(existingClimateData);
            _logger.debug("Updated climate data: {}", updatedData);
            return updatedData;
        } else {
            _logger.warn("No climate data found to update for ID: {}", id);
        }
        return null;
    }

    @Override
    public void deleteClimateData(Integer id) {
        _logger.info("Deleting climate data for ID: {}", id);
        climateDataRepository.deleteById(id);
        _logger.debug("Deleted climate data for ID: {}", id);
    }

    @Override
    public List<ClimateData> getClimateDataByCity() {
        _logger.info("Fetching climate data by city");
        List<ClimateData> climateDataList = climateDataRepository.findAll();
        _logger.debug("Fetched {} records by city", climateDataList.size());
        return climateDataList;
    }
}
