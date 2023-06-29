-- Create the doctors table
CREATE TABLE doctors (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL
);

-- Create the patients table
CREATE TABLE patients (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  date_of_birth DATE,
  age INT,
  height DECIMAL(5,2),
  weight DECIMAL(5,2),
  blood_type VARCHAR(10)
);

-- Create the appointments table
CREATE TABLE appointments (
  id INT PRIMARY KEY AUTO_INCREMENT,
  patient_id INT,
  doctor_id INT,
  appointment_date DATE,
  appointment_time VARCHAR(10),
  FOREIGN KEY (patient_id) REFERENCES patients(id),
  FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);
