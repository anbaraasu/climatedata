-- Crete patient table
CREATE TABLE Patient (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    address VARCHAR(100) NOT NULL,
    UNIQUE(name)
);

-- Create doctor table
CREATE TABLE Doctor (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    specialization VARCHAR(255) NOT NULL,
    UNIQUE(name)
);

-- Create medical record table
CREATE TABLE Diagnosis (
    id INT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    description TEXT,
    date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patient(id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(id)
);

-- Create hospital table
CREATE TABLE Hospital (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    UNIQUE(name)
);

-- insert patient records
INSERT INTO Patient (id, name, age, address) VALUES (1, 'John Doe', 25, '123 Main St, New York, NY');
INSERT INTO Patient (id, name, age, address) VALUES (2, 'Jane Doe', 30, '456 Main St, New York, NY');
INSERT INTO Patient (id, name, age, address) VALUES (3, 'Alice', 35, '789 Main St, New York, NY');

-- insert doctor records
INSERT INTO Doctor (id, name, specialization) VALUES (1, 'Dr. Smith', 'Cardiologist');
INSERT INTO Doctor (id, name, specialization) VALUES (2, 'Dr. Brown', 'Dermatologist');
INSERT INTO Doctor (id, name, specialization) VALUES (3, 'Dr. White', 'Gynecologist');

-- insert hospital records
INSERT INTO Hospital (id, name, address) VALUES (1, 'New York Hospital', '123 Main St, New York, NY');
INSERT INTO Hospital (id, name, address) VALUES (2, 'New York Presbyterian Hospital', '456 Main St, New York, NY');
INSERT INTO Hospital (id, name, address) VALUES (3, 'Mount Sinai Hospital', '789 Main St, New York, NY');

-- insert diagnosis records
INSERT INTO Diagnosis (id, patient_id, doctor_id, description, date) VALUES (1, 1, 1, 'Heart attack', '2021-01-01');
INSERT INTO Diagnosis (id, patient_id, doctor_id, description, date) VALUES (2, 2, 2, 'Skin cancer', '2021-02-01');
INSERT INTO Diagnosis (id, patient_id, doctor_id, description, date) VALUES (3, 3, 3, 'Pregnancy', '2021-03-01');

