package com.sme.climatedata;

import com.sme.climatedata.model.ClimateData;
import com.sme.climatedata.repository.ClimateDataRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@DataJpaTest
class ClimateDataRepositoryTest {

    @Autowired
    private ClimateDataRepository climateDataRepository;

    @Test
    void testFindAll() {
        ClimateData data1 = new ClimateData(null, "City1", "Country1", "January", 25.0f, 60.0f, 10.0f);
        ClimateData data2 = new ClimateData(null, "City2", "Country2", "February", 30.0f, 70.0f, 20.0f);
        climateDataRepository.save(data1);
        climateDataRepository.save(data2);

        List<ClimateData> result = climateDataRepository.findAll();

        //assertEquals(2, result.size());
        assertTrue(null != result && result.size() >= 2);
    }

    @Test
    void testSave() {
        ClimateData data = new ClimateData(null, "City1", "Country1", "January", 25.0f, 60.0f, 10.0f);

        ClimateData savedData = climateDataRepository.save(data);

        assertNotNull(savedData.getId());
        assertEquals("City1", savedData.getCity());
    }

    @Test
    void testDeleteById() {
        ClimateData data = new ClimateData(null, "City1", "Country", "January", 25.0f, 60.0f, 10.0f);
        ClimateData savedData = climateDataRepository.save(data);

        climateDataRepository.deleteById(savedData.getId());

        assertTrue(climateDataRepository.findById(savedData.getId()).isEmpty());
    }
}
