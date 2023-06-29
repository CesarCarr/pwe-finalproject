package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;
import model.Doctor;
import model.Appointment;
import model.Patient;

public class PatientDAO {
    private static final String JDBC_URL = "jdbc:mysql://127.0.0.1:3306/mediviewerdb";
    private static final String JDBC_USERNAME = "mediviewer";
    private static final String JDBC_PASSWORD = "123456";
    
    public List<Patient> getAllPatients() {
        List<Patient> patients = new ArrayList<>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            // Establish the database connection
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // Create the SQL statement
            String sql = "SELECT * FROM patients";
            statement = connection.createStatement();

            // Execute the query
            resultSet = statement.executeQuery(sql);

            // Iterate over the result set and create Patient objects
            while (resultSet.next()) {
                int patientId = resultSet.getInt("id");
                String name = resultSet.getString("name");
                Date dateOfBirth = resultSet.getDate("date_of_birth");
                int age = resultSet.getInt("age");
                double height = resultSet.getDouble("height");
                double weight = resultSet.getDouble("weight");
                String bloodType = resultSet.getString("blood_type");

                // Create a new Patient object
                Patient patient = new Patient(patientId, name, dateOfBirth, age, height, weight, bloodType);
                patients.add(patient);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close the resources
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return patients;
    }

    public List<Appointment> getAllAppointments() {
        List<Appointment> appointments = new ArrayList<>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            // Establish the database connection
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // Create the SQL statement
            String sql = "SELECT p.id AS patient_id, p.name AS patient_name, p.date_of_birth, p.age, " +
                    "p.height, p.weight, p.blood_type, " +
                    "d.id AS doctor_id, d.name AS doctor_name, " +
                    "a.appointment_date, a.appointment_time " +
                    "FROM patients p " +
                    "JOIN appointments a ON p.id = a.patient_id " +
                    "JOIN doctors d ON a.doctor_id = d.id " +
                    "ORDER BY a.appointment_date, a.appointment_time " +
                    "LIMIT 5";
            statement = connection.createStatement();

            // Execute the query
            resultSet = statement.executeQuery(sql);

            // Iterate over the result set and create Appointment objects
            while (resultSet.next()) {
                int patientId = resultSet.getInt("patient_id");
                String patientName = resultSet.getString("patient_name");
                Date dateOfBirth = resultSet.getDate("date_of_birth");
                int age = resultSet.getInt("age");
                double height = resultSet.getDouble("height");
                double weight = resultSet.getDouble("weight");
                String bloodType = resultSet.getString("blood_type");
                int doctorId = resultSet.getInt("doctor_id");
                String doctorName = resultSet.getString("doctor_name");
                Date appointmentDate = resultSet.getDate("appointment_date");
                String appointmentTime = resultSet.getString("appointment_time");

                // Create a new Patient object
                Patient patient = new Patient(patientId, patientName, dateOfBirth, age, height, weight, bloodType);
                Doctor doctor = new Doctor(doctorId, doctorName);
                Appointment appointment = new Appointment(patientId, patient, doctor, appointmentDate, appointmentTime);
                appointments.add(appointment);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close the resources
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return appointments;
    }

    
    public Patient getPatientById(int id) {
        String patientId = String.valueOf(id);
        Patient patient = null;
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // Establish the database connection
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // Create the SQL statement
            String sql = "SELECT * FROM patients WHERE id = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, patientId);

            // Execute the query
            resultSet = statement.executeQuery();

            // Retrieve the patient information
            if (resultSet.next()) {
                String name = resultSet.getString("name");
                Date dateOfBirth = resultSet.getDate("date_of_birth");
                int age = resultSet.getInt("age");
                double height = resultSet.getDouble("height");
                double weight = resultSet.getDouble("weight");
                String bloodType = resultSet.getString("blood_type");

                // Create a new Patient object
                patient = new Patient(Integer.parseInt(patientId), name, dateOfBirth, age, height, weight, bloodType);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close the resources
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return patient;
    }
    public void createPatient(Patient patient) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            // Establish the database connection
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // Create the SQL statement with a parameterized query
            String sql = "INSERT INTO patients (name, date_of_birth, age, height, weight, blood_type) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(sql);

            // Set the parameter values
            statement.setString(1, patient.getName());
            statement.setDate(2, new java.sql.Date(patient.getDateOfBirth().getTime()));
            statement.setInt(3, patient.getAge());
            statement.setDouble(4, patient.getHeight());
            statement.setDouble(5, patient.getWeight());
            statement.setString(6, patient.getBloodType());

            // Execute the query
            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close the resources
            try {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void updatePatient(Patient patient) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            // Establish the database connection
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // Create the SQL statement with a parameterized query
            String sql = "UPDATE patients SET name = ?, date_of_birth = ?, age = ?, height = ?, weight = ?, blood_type = ? WHERE id = ?";
            statement = connection.prepareStatement(sql);

            // Set the parameter values
            statement.setString(1, patient.getName());
            statement.setDate(2, new java.sql.Date(patient.getDateOfBirth().getTime()));
            statement.setInt(3, patient.getAge());
            statement.setDouble(4, patient.getHeight());
            statement.setDouble(5, patient.getWeight());
            statement.setString(6, patient.getBloodType());
            statement.setInt(7, patient.getId());

            // Execute the query
            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close the resources
            try {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}


