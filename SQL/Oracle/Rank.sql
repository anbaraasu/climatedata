-- World Population table 
CREATE TABLE world_population (
    country VARCHAR2(50),
    year NUMBER,
    population NUMBER
);

-- Insert sample data
INSERT INTO world_population (country, year, population) VALUES ('China', 2020, 1439323776);
INSERT INTO world_population (country, year, population) VALUES ('India', 2020, 1439323776);
INSERT INTO world_population (country, year, population) VALUES ('United States', 2020, 331002651);
INSERT INTO world_population (country, year, population) VALUES ('Indonesia', 2020, 273523615);
INSERT INTO world_population (country, year, population) VALUES ('Pakistan', 2020, 220892340);
INSERT INTO world_population (country, year, population) VALUES ('Brazil', 2020, 212559417);
INSERT INTO world_population (country, year, population) VALUES ('Nigeria', 2020, 206139589);

-- RANK AND ROW_NUMBER
SELECT 
    country, 
    year, 
    population, 
    RANK() OVER (ORDER BY population DESC) AS rank,
    ROW_NUMBER() OVER (ORDER BY population DESC) AS row_number
FROM world_population;
