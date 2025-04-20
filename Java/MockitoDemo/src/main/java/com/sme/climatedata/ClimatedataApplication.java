package com.sme.climatedata;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@SpringBootApplication
public class ClimatedataApplication {

    private static final Logger _logger = LoggerFactory.getLogger(ClimatedataApplication.class);

    public static void main(String[] args) {
        _logger.info("Starting ClimatedataApplication");
        SpringApplication.run(ClimatedataApplication.class, args);
        _logger.info("ClimatedataApplication started successfully");
    }
}
