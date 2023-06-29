package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.HealthWorker;

public class HealthWorkerDAO {
    private static final String JDBC_URL = "jdbc:mysql://127.0.0.1:3306/mediviewerdb";
    private static final String JDBC_USERNAME = "mediviewer";
    private static final String JDBC_PASSWORD = "123456";
    public HealthWorker getAdminByUsername(String username) {
        HealthWorker admin = null;
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            String sql = "SELECT * FROM health_workers WHERE username = ? AND is_admin = 1";
            statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String password = resultSet.getString("password");

                // Create the HealthWorker object
                admin = new HealthWorker();
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

        return admin;
    }
}
