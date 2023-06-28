<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.PatientDAO" %>
<%@ page import="model.Patient" %>

<!DOCTYPE html>
<html>
<head>
    <title>Patient Information</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <style>
        body {
            background-color: #1e1e1e;
            color: #ffffff;
        }

        .container {
            margin-top: 50px;
        }

        .table {
            background-color: #2c2c2c;
            color: #ffffff;
        }

        .table th,
        .table td {
            border-color: #ffffff;
        }

        .table thead th {
            background-color: #2c2c2c;
            color: #ffffff;
            font-weight: bold;
        }

        .table tbody td {
            vertical-align: middle;
        }

        .alert-info {
            background-color: #2c2c2c;
            color: #ffffff;
        }
    </style>
</head>
<body>
    <div class="container">
        <h3>Patient Information</h3>
        <table id="patientTable" class="table">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Date of Birth</th>
                    <th>Age</th>
                    <th>Height</th>
                    <th>Weight</th>
                    <th>Blood Type</th>
                </tr>
            </thead>
            <tbody>
                <% 
                // Get the patient ID from the request parameter
                String patientId = request.getParameter("id");
                
                // Retrieve the patient information using the patient ID
                PatientDAO patientDAO = new PatientDAO();
                Patient patient = patientDAO.getPatientById(patientId);
                
                if (patient == null) { 
                %>
                    <tr>
                        <td colspan="6">Patient not found</td>
                    </tr>
                <% 
                } else {
                %>
                    <tr>
                        <td><%= patient.getName() %></td>
                        <td><%= patient.getDateOfBirth() %></td>
                        <td><%= patient.getAge() %></td>
                        <td><%= patient.getHeight() %></td>
                        <td><%= patient.getWeight() %></td>
                        <td><%= patient.getBloodType() %></td>
                    </tr>
                <% 
                }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
