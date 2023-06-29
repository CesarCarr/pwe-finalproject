package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Doctor;

public class DoctorDAO {
    private static final String JDBC_URL = "jdbc:mysql://127.0.0.1:3306/mediviewerdb";
    private static final String JDBC_USERNAME = "mediviewer";
    private static final String JDBC_PASSWORD = "123456";

    public Doctor getDoctorById(int id) {
        Doctor doctor = null;
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // Establish the database connection
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // Create the SQL statement with a parameter for id
            String sql = "SELECT * FROM doctors WHERE id = ?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);

            // Execute the query
            resultSet = statement.executeQuery();

            // Check if a doctor was found
            if (resultSet.next()) {
                String name = resultSet.getString("name");
                doctor = new Doctor(id, name);
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

        return doctor;
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
                String name = resultSet.getString("name");

                // Create a new Doctor object
                Doctor doctor = new Doctor(doctorId, name);
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
}
