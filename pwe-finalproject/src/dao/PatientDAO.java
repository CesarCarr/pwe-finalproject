package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;
import model.Doctor;
import model.Appointment;
import model.Patient;

public class PatientDAO {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/your_database_name";
    private static final String JDBC_USERNAME = "your_username";
    private static final String JDBC_PASSWORD = "your_password";

    public List<Appointment> getAllAppointments() {
        List<Appointment> appointments = new ArrayList<>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            // Establish the database connection
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // Create the SQL statement
            String sql = "SELECT p.id AS patient_id, p.name AS patient_name, p.date_of_birth, p.age, " +
                    "p.height, p.weight, p.blood_type, " +
                    "d.id AS doctor_id, d.name AS doctor_name " +
                    "FROM patients p " +
                    "JOIN appointments a ON p.id = a.patient_id " +
                    "JOIN doctors d ON a.doctor_id = d.id " +
                    "ORDER BY a.appointment_date, a.appointment_time " +
                    "LIMIT 5";
            statement = connection.createStatement();

            // Execute the query
            resultSet = statement.executeQuery(sql);

            // Iterate over the result set and create Patient objects
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

                // Create a new Patient object and add it to the list
                Patient patient = new Patient(patientId, patientName, dateOfBirth, age, height, weight, bloodType);
                Doctor doctor = new Doctor(doctorId, doctorName);
                Appointment appointment = new Appointment(patient, doctor);
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
