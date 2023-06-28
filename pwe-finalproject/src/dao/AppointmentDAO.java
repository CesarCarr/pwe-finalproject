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
        	DriverManager.registerDriver(new com.mysql.jdbc.Driver ());
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // Create the SQL statement
            String sql = "SELECT p.id AS patient_id, p.name AS patient_name, p.age AS patient_age, " +
                    "d.id AS doctor_id, d.name AS doctor_name " +
                    "FROM patients p " +
                    "JOIN appointments a ON p.id = a.patient_id " +
                    "JOIN doctors d ON a.doctor_id = d.id";
            statement = connection.createStatement();

            // Execute the query
            resultSet = statement.executeQuery(sql);

            // Iterate over the result set and create Appointment objects
            while (resultSet.next()) {
                int patientId = resultSet.getInt("patient_id");
                String patientName = resultSet.getString("patient_name");
                int patientAge = resultSet.getInt("patient_age");
                int doctorId = resultSet.getInt("doctor_id");
                String doctorName = resultSet.getString("doctor_name");

                // Create a new Patient object and add it to the list
                Patient patient = new Patient(patientId, patientName, null, patientAge, 0, 0, null);
                Doctor doctor = new Doctor(doctorId, doctorName);
                Appointment appointment = new Appointment(patient, doctor, null, doctorName);
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
}
