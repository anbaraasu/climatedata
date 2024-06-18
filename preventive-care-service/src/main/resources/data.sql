-- Insert sample data for Patient
INSERT INTO Patient (id, name, age, gender) VALUES
(1, 'John Doe', 30, 'Male'),
(2, 'Jane Smith', 25, 'Female'),
(3, 'Michael Johnson', 40, 'Male');

-- Insert sample data for Doctor
INSERT INTO Doctor (id, name, specialization) VALUES
(1, 'Dr. Emily Brown', 'Cardiology'),
(2, 'Dr. David Wilson', 'Dermatology'),
(3, 'Dr. Sarah Thompson', 'Pediatrics');

-- Insert sample data for MedicalRecord
INSERT INTO MedicalRecord (id, patient_id, doctor_id, diagnosis_id, date) VALUES
(1, 1, 1, 1, '2022-01-01'),
(2, 2, 2, 2, '2022-02-01'),
(3, 3, 3, 3, '2022-03-01');

-- Insert sample data for Hospital
INSERT INTO Hospital (id, name, location) VALUES
(1, 'ABC Hospital', 'New York'),
(2, 'XYZ Hospital', 'Los Angeles'),
(3, 'PQR Hospital', 'Chicago');

-- Insert sample data for Diagnosis
INSERT INTO Diagnosis (id, name, description) VALUES
(1, 'Heart Disease', 'A condition that affects the heart'),
(2, 'Skin Infection', 'An infection that affects the skin'),
(3, 'Common Cold', 'A viral infection that affects the respiratory system');