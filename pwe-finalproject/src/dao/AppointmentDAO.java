package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Appointment;
import model.Doctor;
import model.Patient;

public class AppointmentDAO {
    private static final String JDBC_URL = "jdbc:mysql://127.0.0.1:3306/mediviewerdb";
    private static final String JDBC_USERNAME = "mediviewer";
    private static final String JDBC_PASSWORD = "123456";

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
                Appointment appointment = new Appointment(0, patient, doctor, appointmentDate, appointmentTime);
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
    public List<Doctor> getAllDoctors() {
        List<Doctor> doctors = new ArrayList<>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            // Establish the database connection
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // Create the SQL statement
            String sql = "SELECT * FROM doctors";
            statement = connection.createStatement();

            // Execute the query
            resultSet = statement.executeQuery(sql);

            // Iterate over the result set and create Doctor objects
            while (resultSet.next()) {
                int doctorId = resultSet.getInt("id");
                String doctorName = resultSet.getString("name");

                // Create a new Doctor object
                Doctor doctor = new Doctor(doctorId, doctorName);
                doctors.add(doctor);
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

        return doctors;
    }

    public void createAppointment(Appointment appointment) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            String sql = "INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time) " +
                         "VALUES (?, ?, ?, ?)";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, appointment.getPatient().getId());
            statement.setInt(2, appointment.getDoctor().getId());
            statement.setDate(3, new java.sql.Date(appointment.getDate().getTime()));
            statement.setString(4, appointment.getTime());

            // Execute the statement
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
    public Appointment getAppointmentById(int appointmentId) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        Appointment appointment = null;

        try {
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
            String query = "SELECT * FROM appointments WHERE id = ?";
            statement = connection.prepareStatement(query);
            statement.setInt(1, appointmentId);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                appointment = new Appointment();
                appointment.setId(resultSet.getInt("id"));
                appointment.setDate(resultSet.getString("appointment_date"));
                appointment.setTime(resultSet.getString("appointment_time"));
                // Set other appointment properties from the result set
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        	try {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return appointment;
    }

    public void removeAppointmentById(int appointmentId) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            String sql = "DELETE FROM appointments WHERE id = ?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, appointmentId);

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    public void updateAppointment(Appointment appointment) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            String sql = "UPDATE appointments SET appointment_date = ?, appointment_time = ?, doctor_id = ? " +
                    "WHERE id = ?";
            statement = connection.prepareStatement(sql);
            statement.setDate(1, new java.sql.Date(appointment.getDate().getTime()));
            statement.setString(2, appointment.getTime());
            statement.setInt(3, appointment.getDoctor().getId());
            statement.setInt(4, appointment.getId());

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
