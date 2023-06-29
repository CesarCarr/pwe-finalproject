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

CREATE USER 'mediviewer'@'localhost' IDENTIFIED BY '123456';
GRANT ALL PRIVILEGES ON * . * TO 'mediviewer'@'localhost';
FLUSH PRIVILEGES;

INSERT INTO patients (name, date_of_birth, age, height, weight, blood_type)
VALUES
    ('João Silva', 1985-03-10, 36, 170, 70, 'A+'),
    ('Maria Santos', 1992-06-15, 31, 165, 55, 'O-'),
    ('Pedro Souza', 1980-11-28, 41, 175, 80, 'AB+'),
    ('Ana Costa', 1998-02-05, 23, 160, 50, 'B+'),
    ('Luiz Oliveira', 1977-07-20, 46, 180, 90, 'O+'),
    ('Juliana Pereira', 1990-09-12, 33, 167, 60, 'A-'),
    ('Marcelo Fernandes', 1988-04-02, 35, 172, 75, 'AB-'),
    ('Camila Almeida', 1983-12-19, 38, 163, 55, 'B-'),
    ('Gabriel Ribeiro', 1995-08-25, 28, 178, 72, 'O+'),
    ('Amanda Barbosa', 1987-01-08, 36, 168, 60, 'A+'),
    ('Rafael Santos', 1975-05-14, 48, 175, 80, 'O-');


  INSERT INTO doctors (name)
VALUES
    ('Dr. Carlos Mendes'),
    ('Dra. Ana Oliveira'),
    ('Dr. Lucas Almeida'),
    ('Dra. Sofia Santos'),
    ('Dr. Rafael Costa'),
    ('Dra. Juliana Pereira'),
    ('Dr. André Silva'),
    ('Dra. Fernanda Souza'),
    ('Dr. Marcos Fernandes'),
    ('Dra. Laura Rodrigues'),
    ('Dr. Ricardo Nunes'),
    ('Dra. Beatriz Lima'),
    ('Dr. Gustavo Mendonça'),
    ('Dra. Paula Carvalho'),
    ('Dr. Pedro Castro'),
    ('Dra. Mariana Costa'),
    ('Dr. André Santos'),
    ('Dra. Carolina Oliveira'),
    ('Dr. Lucas Mendes'),
    ('Dra. Camila Sousa');
