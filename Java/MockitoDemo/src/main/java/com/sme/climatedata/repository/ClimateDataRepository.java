package com.sme.climatedata.repository;

//climate jpa repository
import com.sme.climatedata.model.ClimateData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ClimateDataRepository extends JpaRepository<ClimateData, Integer> {
}
