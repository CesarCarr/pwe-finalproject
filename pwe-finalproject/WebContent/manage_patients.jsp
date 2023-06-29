<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.PatientDAO" %>
<%@ page import="model.Patient" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Patients</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h1 class="text-center mt-5">Manage Patients</h1>
    <form action="manage-patients" method="post">
        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" class="form-control" id="name" name="name" required>
        </div>
        <div class="form-group">
            <label for="dateOfBirth">Date of Birth:</label>
            <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" max="<%= java.time.LocalDate.now() %>" onchange="calculateAge()" required>
        </div>
        <div class="form-group">
            <label for="age">Age:</label>
            <input type="number" class="form-control" id="age" name="age" min="1" readonly>
        </div>
        <div class="form-group">
            <label for="height">Height:</label>
            <input type="number" class="form-control" id="height" name="height" min="1" required>
        </div>
        <div class="form-group">
            <label for="weight">Weight:</label>
            <input type="number" class="form-control" id="weight" name="weight" min="1" required>
        </div>
        <div class="form-group">
            <label for="bloodType">Blood Type:</label>
            <input type="text" class="form-control" id="bloodType" name="bloodType" required>
        </div>
        <button type="submit" class="btn btn-primary">Create Patient</button>
        <a href="index.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>

<script>
    function calculateAge() {
        var dateOfBirth = document.getElementById("dateOfBirth").value;
        var today = new Date();
        var birthDate = new Date(dateOfBirth);
        var age = today.getFullYear() - birthDate.getFullYear();
        var monthDiff = today.getMonth() - birthDate.getMonth();
        if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
            age--;
        }
        document.getElementById("age").value = age;
    }
</script>



    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
