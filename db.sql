-- Drop tables if they exist
DROP TABLE IF EXISTS Prescription, Appointment_Treatment, Appointment, Treatment, Patient, Doctor;

-- Doctor Table
CREATE TABLE Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Patient Table
CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Appointment Table
CREATE TABLE Appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    patient_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Scheduled',
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

-- Treatment Table
CREATE TABLE Treatment (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    cost DECIMAL(10, 2) NOT NULL
);

-- Many-to-Many: Appointment_Treatment Table
CREATE TABLE Appointment_Treatment (
    appointment_id INT,
    treatment_id INT,
    PRIMARY KEY (appointment_id, treatment_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id),
    FOREIGN KEY (treatment_id) REFERENCES Treatment(treatment_id)
);

-- One-to-One: Prescription Table
CREATE TABLE Prescription (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT UNIQUE,
    notes TEXT,
    prescribed_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);

-- Sample Data for Doctors
INSERT INTO Doctor (name, specialty, phone, email)
VALUES 
('Dr. Alice Smith', 'Cardiology', '123-456-7890', 'alice@example.com'),
('Dr. Bob Jones', 'Dermatology', '987-654-3210', 'bob@example.com');

-- Sample Data for Patients
INSERT INTO Patient (name, date_of_birth, phone, email)
VALUES 
('John Doe', '1990-05-14', '555-123-4567', 'johndoe@example.com'),
('Jane Roe', '1985-10-22', '555-987-6543', 'janeroe@example.com');

-- Sample Data for Treatments
INSERT INTO Treatment (name, cost)
VALUES 
('X-ray', 100.00),
('Blood Test', 50.00),
('Skin Biopsy', 150.00);

-- Sample Appointments
INSERT INTO Appointment (doctor_id, patient_id, appointment_date, status)
VALUES 
(1, 1, '2025-05-10 10:00:00', 'Scheduled'),
(2, 2, '2025-05-11 11:30:00', 'Completed');

-- Sample Appointment_Treatment
INSERT INTO Appointment_Treatment (appointment_id, treatment_id)
VALUES 
(1, 1),  -- John Doe gets an X-ray
(2, 2),  -- Jane Roe gets a Blood Test
(2, 3);  -- Jane Roe also gets a Skin Biopsy

-- Sample Prescription
INSERT INTO Prescription (appointment_id, notes)
VALUES 
(2, 'Apply ointment twice a day and avoid sun exposure.');

