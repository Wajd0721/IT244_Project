-- Smart Clinic Database System
-- Complete MySQL Script

DROP DATABASE IF EXISTS Smart_Clinic_DB;
CREATE DATABASE Smart_Clinic_DB;
USE Smart_Clinic_DB;

-- =========================================================
-- TABLES
-- =========================================================

CREATE TABLE Patient (
    Patient_ID INT AUTO_INCREMENT,
    National_ID CHAR(10) NOT NULL,
    Full_Name VARCHAR(100) NOT NULL,
    Date_of_Birth DATE NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Email VARCHAR(100),
    Address VARCHAR(200),

    PRIMARY KEY (Patient_ID),
    UNIQUE (National_ID),
    UNIQUE (Phone),
    UNIQUE (Email)
);

CREATE TABLE Doctor (
    Doctor_ID INT AUTO_INCREMENT,
    Full_Name VARCHAR(100) NOT NULL,
    Specialty VARCHAR(100) NOT NULL,
    License_No VARCHAR(30) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Doctor_Type VARCHAR(20) NOT NULL,

    PRIMARY KEY (Doctor_ID),
    UNIQUE (License_No),
    UNIQUE (Phone),
    UNIQUE (Email)
);

CREATE TABLE Consultant_Doctor (
    Doctor_ID INT,
    Years_of_Experience INT NOT NULL,

    PRIMARY KEY (Doctor_ID),

    FOREIGN KEY (Doctor_ID)
        REFERENCES Doctor(Doctor_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Resident_Doctor (
    Doctor_ID INT,
    Residency_Year INT NOT NULL,

    PRIMARY KEY (Doctor_ID),

    FOREIGN KEY (Doctor_ID)
        REFERENCES Doctor(Doctor_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Appointment (
    Appointment_ID INT AUTO_INCREMENT,
    Patient_ID INT NOT NULL,
    Doctor_ID INT NOT NULL,
    Appointment_Date DATE NOT NULL,
    Appointment_Time TIME NOT NULL,
    Visit_Reason VARCHAR(255) NOT NULL,
    Status VARCHAR(20) NOT NULL,

    PRIMARY KEY (Appointment_ID),

    FOREIGN KEY (Patient_ID)
        REFERENCES Patient(Patient_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (Doctor_ID)
        REFERENCES Doctor(Doctor_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    UNIQUE (Doctor_ID, Appointment_Date, Appointment_Time)
);

CREATE TABLE Medicine (
    Medicine_ID INT AUTO_INCREMENT,
    Medicine_Name VARCHAR(100) NOT NULL,
    Description VARCHAR(255),
    Unit_Price DECIMAL(8,2) NOT NULL,
    Stock_Quantity INT NOT NULL,

    PRIMARY KEY (Medicine_ID),
    UNIQUE (Medicine_Name)
);

CREATE TABLE Treatment (
    Treatment_ID INT AUTO_INCREMENT,
    Appointment_ID INT NOT NULL,
    Medicine_ID INT,
    Diagnosis VARCHAR(255) NOT NULL,
    Procedure_Name VARCHAR(150) NOT NULL,
    Notes VARCHAR(500),
    Cost DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (Treatment_ID),

    FOREIGN KEY (Appointment_ID)
        REFERENCES Appointment(Appointment_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (Medicine_ID)
        REFERENCES Medicine(Medicine_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Payment (
    Payment_ID INT AUTO_INCREMENT,
    Appointment_ID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    Payment_Date DATE NOT NULL,
    Payment_Method VARCHAR(30) NOT NULL,
    Payment_Status VARCHAR(20) NOT NULL,
    Payment_Type VARCHAR(30) NOT NULL,

    PRIMARY KEY (Payment_ID),

    FOREIGN KEY (Appointment_ID)
        REFERENCES Appointment(Appointment_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- =========================================================
-- SAMPLE DATA
-- =========================================================

INSERT INTO Patient
    (National_ID, Full_Name, Date_of_Birth, Gender, Phone, Email, Address)
VALUES
    ('1023456789', 'Abdullah Alzahrani', '1992-04-16',
     'Male', '0509876543',
     'abdullah.alzahrani@example.sa',
     'Al Malqa District, Riyadh'),

    ('1098765432', 'Sara Alharbi', '1988-11-03',
     'Female', '0518765432',
     'sara.alharbi@example.sa',
     'Al Rawdah District, Jeddah'),

    ('1122334455', 'Mohammed Alqahtani', '2001-07-22',
     'Male', '0527654321',
     'mohammed.alqahtani@example.sa',
     'Al Faisaliyah District, Dammam'),

    ('1234567890', 'Norah Alotaibi', '1996-02-10',
     'Female', '0536543210',
     'norah.alotaibi@example.sa',
     'Al Aziziyah District, Makkah'),

    ('1987654321', 'Fahad Alshammari', '1979-09-28',
     'Male', '0545432109',
     'fahad.alshammari@example.sa',
     'Qurban District, Madinah');

INSERT INTO Doctor
    (Full_Name, Specialty, License_No, Phone, Email, Doctor_Type)
VALUES
    ('Khalid Alqahtani', 'Family Medicine',
     'SCFHS-D-10001', '0501234567',
     'k.alqahtani@smartclinic.sa', 'Consultant'),

    ('Noura Alharbi', 'Pediatrics',
     'SCFHS-D-10002', '0512345678',
     'n.alharbi@smartclinic.sa', 'Consultant'),

    ('Faisal Alotaibi', 'Dermatology',
     'SCFHS-D-10003', '0523456789',
     'f.alotaibi@smartclinic.sa', 'Consultant'),

    ('Reem Alghamdi', 'Internal Medicine',
     'SCFHS-D-10004', '0534567890',
     'r.alghamdi@smartclinic.sa', 'Consultant'),

    ('Saad Alshammari', 'Orthopedics',
     'SCFHS-D-10005', '0545678901',
     's.alshammari@smartclinic.sa', 'Consultant'),

    ('Ahmed Aldossari', 'Family Medicine',
     'SCFHS-D-10006', '0556789012',
     'a.aldossari@smartclinic.sa', 'Resident'),

    ('Huda Alzahrani', 'Pediatrics',
     'SCFHS-D-10007', '0567890123',
     'h.alzahrani@smartclinic.sa', 'Resident'),

    ('Majed Almutairi', 'Dermatology',
     'SCFHS-D-10008', '0578901234',
     'm.almutairi@smartclinic.sa', 'Resident'),

    ('Lama Alsubaie', 'Internal Medicine',
     'SCFHS-D-10009', '0589012345',
     'l.alsubaie@smartclinic.sa', 'Resident'),

    ('Omar Alanazi', 'Orthopedics',
     'SCFHS-D-10010', '0590123456',
     'o.alanazi@smartclinic.sa', 'Resident');

INSERT INTO Consultant_Doctor
    (Doctor_ID, Years_of_Experience)
VALUES
    (1, 14),
    (2, 12),
    (3, 10),
    (4, 15),
    (5, 11);

INSERT INTO Resident_Doctor
    (Doctor_ID, Residency_Year)
VALUES
    (6, 1),
    (7, 2),
    (8, 3),
    (9, 2),
    (10, 4);

INSERT INTO Appointment
    (Patient_ID, Doctor_ID, Appointment_Date,
     Appointment_Time, Visit_Reason, Status)
VALUES
    (1, 1, '2026-07-05', '09:00:00',
     'Routine health examination', 'Completed'),

    (2, 2, '2026-07-06', '10:30:00',
     'Child fever and sore throat', 'Completed'),

    (3, 3, '2026-07-07', '12:00:00',
     'Persistent skin rash', 'Completed'),

    (4, 4, '2026-07-08', '14:00:00',
     'Fatigue and high blood pressure', 'Completed'),

    (5, 5, '2026-07-09', '16:30:00',
     'Knee pain after exercise', 'Completed');

INSERT INTO Medicine
    (Medicine_Name, Description, Unit_Price, Stock_Quantity)
VALUES
    ('Vitamin D3 1000 IU',
     'Vitamin D supplement',
     25.00, 100),

    ('Paracetamol 500 mg',
     'Pain and fever relief tablets',
     15.00, 200),

    ('Hydrocortisone Cream',
     'Topical cream for skin inflammation',
     22.50, 80),

    ('Amlodipine 5 mg',
     'Medicine used for high blood pressure',
     35.00, 120),

    ('Diclofenac Gel',
     'Topical gel used for muscle and joint pain',
     28.00, 90);

INSERT INTO Treatment
    (Appointment_ID, Medicine_ID, Diagnosis,
     Procedure_Name, Notes, Cost)
VALUES
    (1, 1,
     'Vitamin D deficiency',
     'Clinical examination',
     'Follow-up test recommended after eight weeks',
     250.00),

    (2, 2,
     'Viral upper respiratory infection',
     'Pediatric examination',
     'Rest and adequate fluid intake recommended',
     300.00),

    (3, 3,
     'Contact dermatitis',
     'Skin examination',
     'Avoid suspected skin irritants',
     350.00),

    (4, 4,
     'Hypertension',
     'Blood pressure assessment',
     'Blood pressure should be monitored regularly',
     320.00),

    (5, 5,
     'Knee muscle strain',
     'Orthopedic examination',
     'Reduce strenuous physical activity temporarily',
     400.00);

INSERT INTO Payment
    (Appointment_ID, Amount, Payment_Date,
     Payment_Method, Payment_Status, Payment_Type)
VALUES
    (1, 250.00, '2026-07-05',
     'Mada', 'Paid', 'Self-Payment'),

    (2, 300.00, '2026-07-06',
     'Insurance', 'Paid', 'Insurance'),

    (3, 350.00, '2026-07-07',
     'Credit Card', 'Paid', 'Self-Payment'),

    (4, 320.00, '2026-07-08',
     'Insurance', 'Paid', 'Insurance'),

    (5, 400.00, '2026-07-09',
     'Mada', 'Paid', 'Self-Payment');

-- =========================================================
-- TASK 3 SQL OPERATIONS
-- =========================================================

-- 1. SELECT
SELECT
    Appointment_ID,
    Appointment_Date,
    Appointment_Time,
    Visit_Reason,
    Status
FROM Appointment
WHERE Status = 'Completed'
ORDER BY Appointment_Date, Appointment_Time;

-- 2. JOIN
SELECT
    a.Appointment_ID,
    p.Full_Name AS Patient_Name,
    d.Full_Name AS Doctor_Name,
    d.Specialty,
    a.Appointment_Date,
    a.Appointment_Time,
    a.Status
FROM Appointment AS a
INNER JOIN Patient AS p
    ON a.Patient_ID = p.Patient_ID
INNER JOIN Doctor AS d
    ON a.Doctor_ID = d.Doctor_ID
ORDER BY a.Appointment_Date;

-- 3. NESTED QUERY
SELECT
    Treatment_ID,
    Appointment_ID,
    Diagnosis,
    Procedure_Name,
    Cost
FROM Treatment
WHERE Cost > (
    SELECT AVG(Cost)
    FROM Treatment
)
ORDER BY Cost DESC;

-- 4. AGGREGATE FUNCTION WITH GROUP BY
SELECT
    d.Doctor_ID,
    d.Full_Name AS Doctor_Name,
    d.Specialty,
    COUNT(a.Appointment_ID) AS Total_Appointments
FROM Doctor AS d
LEFT JOIN Appointment AS a
    ON d.Doctor_ID = a.Doctor_ID
GROUP BY
    d.Doctor_ID,
    d.Full_Name,
    d.Specialty
ORDER BY Total_Appointments DESC;

-- 5. UPDATE
UPDATE Appointment
SET Status = 'Cancelled'
WHERE Appointment_ID = 5;

-- 6. DELETE
DELETE FROM Payment
WHERE Payment_ID = 5;

-- 7. VIEW
DROP VIEW IF EXISTS Appointment_Details;

CREATE VIEW Appointment_Details AS
SELECT
    a.Appointment_ID,
    p.Full_Name AS Patient_Name,
    d.Full_Name AS Doctor_Name,
    d.Specialty,
    a.Appointment_Date,
    a.Appointment_Time,
    a.Visit_Reason,
    a.Status
FROM Appointment AS a
INNER JOIN Patient AS p
    ON a.Patient_ID = p.Patient_ID
INNER JOIN Doctor AS d
    ON a.Doctor_ID = d.Doctor_ID;

SELECT *
FROM Appointment_Details;

-- 8. TRIGGER
DROP TRIGGER IF EXISTS Check_Appointment_Date;

DELIMITER $$

CREATE TRIGGER Check_Appointment_Date
BEFORE INSERT ON Appointment
FOR EACH ROW
BEGIN
    IF NEW.Appointment_Date < CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Appointment date cannot be in the past';
    END IF;
END$$

DELIMITER ;
