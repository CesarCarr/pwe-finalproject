<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="dao.AppointmentDAO" %>
<%@ page import="model.Appointment" %>
<%@ page import="model.Patient" %>
<%@ page import="model.Doctor" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
<head>
    <title>Appointments</title>
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

        .table tbody td a {
            color: #fca311;
            text-decoration: none;
        }

        .table tbody tr:hover {
            background-color: #3c3c3c;
        }

        .alert-info {
            background-color: #2c2c2c;
            color: #ffffff;
        }
    </style>
</head>
<body>
    <div class="container">
        <h3>Next Appointments</h3>
        <table id="appointmentTable" class="table">
            <thead>
                <tr>
                    <th>Patient</th>
                    <th>Doctor</th>
                    <th>Date</th>
                    <th>Time</th>
                </tr>
            </thead>
            <tbody>
                <% if (appointments.isEmpty()) { %>
                    <tr>
                        <td colspan="4">No appointments registered</td>
                    </tr>
                <% } else { %>
                    <c:forEach items="${appointments}" var="appointment">
                        <tr>
                            <td><a href="patient.jsp?id=${appointment.getPatient().getId()}">${appointment.getPatient().getName()}</a></td>
                            <td>${appointment.getDoctor().getName()}</td>
                            <td>${appointment.getDate()}</td>
                            <td>${appointment.getTime()}</td>
                        </tr>
                    </c:forEach>
                <% } %>
            </tbody>
        </table>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script>
        // ... (The rest of your JavaScript code)
    </script>
</body>
</html>
