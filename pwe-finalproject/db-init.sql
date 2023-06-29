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

--Populate Pacientes table 
INSERT INTO Pacientes (name, date_of_birth, age, height, weight, blood_type)
VALUES

    ('João da Silva', 'Joana', '123.456.789-10', 35, 'A+', 'M'),
    ('Maria Souza', NULL, '987.654.321-98', 28, 'O-', 'F'),
    ('Pedro Oliveira', NULL, '456.789.123-54', 42, 'B+', 'M'),
    ('Ana Santos', 'André', '789.123.456-32', 19, 'AB-', 'F'),
    ('Lucas Pereira', NULL, '321.654.987-76', 51, 'A-', 'M'),
    ('Carla Costa', NULL, '654.987.321-45', 36, 'O+', 'F'),
    ('Fernando Mendes', 'Fernanda', '987.654.321-01', 43, 'B-', 'M'),
    ('Laura Silva', NULL, '159.753.852-96', 30, 'AB+', 'F'),
    ('Mariana Almeida', NULL, '753.951.852-46', 24, 'O+', 'F'),
    ('Rafaela Santos', 'Rafa', '852.753.951-74', 29, 'A+', 'F'),
	('Carolina Santos', NULL, '258.147.369-01', 27, 'A-', 'F'),
    ('Gustavo Costa', NULL, '369.258.147-02', 33, 'O+', 'M'),
    ('Fernanda Oliveira', 'Fer', '147.369.258-03', 45, 'AB+', 'F'),
    ('Ricardo Almeida', NULL, '369.147.258-04', 22, 'B-', 'M'),
    ('Isabela Mendes', NULL, '147.258.369-05', 31, 'O-', 'F'),
    ('Marcelo Silva', 'Marcela', '258.369.147-06', 38, 'A+', 'M'),
    ('Camila Souza', NULL, '369.147.258-07', 26, 'B+', 'F'),
    ('Raul Pereira', NULL, '147.258.369-08', 49, 'AB-', 'M'),
    ('Beatriz Costa', 'Bia', '258.369.147-09', 33, 'O+', 'F'),
    ('Gabriel Santos', NULL, '369.147.258-10', 29, 'A-', 'M');


  INSERT INTO doctors (name)
VALUES
    ('Dr. Carlos Mendes', 'Cardiologia'),
    ('Dra. Ana Oliveira', 'Ginecologia'),
    ('Dr. Lucas Almeida', 'Ortopedia'),
    ('Dra. Sofia Santos', 'Dermatologia'),
    ('Dr. Rafael Costa', 'Oftalmologia'),
    ('Dra. Juliana Pereira', 'Pediatria'),
    ('Dr. André Silva', 'Psiquiatria'),
    ('Dra. Fernanda Souza', 'Clínica Geral'),
    ('Dr. Marcos Fernandes', 'Endocrinologia'),
    ('Dra. Laura Rodrigues', 'Neurologia'),
    ('Dr. Ricardo Nunes', 'Urologia'),
    ('Dra. Beatriz Lima', 'Oncologia'),
    ('Dr. Gustavo Mendonça', 'Cirurgia Geral'),
    ('Dra. Paula Carvalho', 'Otorrinolaringologia'),
    ('Dr. Pedro Castro', 'Cardiologia'),
    ('Dra. Mariana Costa', 'Ginecologia'),
    ('Dr. André Santos', 'Ortopedia'),
    ('Dra. Carolina Oliveira', 'Dermatologia'),
    ('Dr. Lucas Mendes', 'Oftalmologia'),
    ('Dra. Camila Sousa', 'Pediatria');


-- Populate Agendamentos table
INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time)
VALUES
    (2, 3, 9, '2023-07-02', '09:30'),
	(8, 11, 7, '2023-07-11', '15:45'),
	(5, 10, 12, '2023-07-09', '11:15'),
	(17, 14, 2, '2023-06-30', '14:00'),
	(9, 19, 4, '2023-06-29', '10:45'),
	(14, 1, 4, '2023-07-03', '16:30'),
	(18, 3, 4, '2023-07-06', '13:45'),
	(3, 12, 7, '2023-07-07', '14:30'),
	(7, 12, 10, '2023-06-30', '09:15'),
	(2, 13, 3, '2023-07-11', '15:15'),
	(10, 19, 3, '2023-07-09', '10:30'),
	(6, 1, 17, '2023-07-01', '16:00'),
	(6, 5, 4, '2023-07-06', '11:45'),
	(10, 8, 3, '2023-07-06', '10:30'),
	(6, 20, 19, '2023-07-04', '09:30'),
	(7, 13, 7, '2023-07-06', '14:00'),
	(8, 6, 7, '2023-07-05', '12:15'),
	(3, 14, 1, '2023-07-01', '13:45'),
	(12, 10, 1, '2023-07-08', '14:30'),
	(5, 7, 5, '2023-06-30', '09:45'),
	(15, 12, 7, '2023-07-09', '15:30'),
	(1, 12, 7, '2023-07-03', '15:45'),
	(14, 11, 20, '2023-07-02', '16:30'),
	(11, 4, 7, '2023-07-06', '13:15'),
	(1, 4, 13, '2023-07-09', '12:30'),
	(9, 9, 20, '2023-07-03', '17:15'),
	(15, 9, 2, '2023-07-11', '11:30'),
	(6, 12, 11, '2023-06-28', '16:15'),
	(12, 19, 4, '2023-06-30', '10:00'),
	(11, 11, 6, '2023-07-09', '14:15'),
	(17, 11, 10, '2023-07-05', '12:45'),
	(10, 5, 3, '2023-07-08', '13:30'),
	(20, 4, 7, '2023-07-04', '12:15');
