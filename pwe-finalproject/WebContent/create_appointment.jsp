<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.PatientDAO" %>
<%@ page import="dao.DoctorDAO" %>
<%@ page import="dao.AppointmentDAO" %>
<%@ page import="model.Patient" %>
<%@ page import="model.Doctor" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Appointment</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h1 class="text-center mt-5">Create Appointment</h1>
        <form action="appointments" method="post">
            <div class="form-group">
                <label for="patient">Patient:</label>
                <select class="form-control" id="patient" name="patient" required>
                    <option value="" disabled selected>Select a patient</option>
                    <% 
                        PatientDAO patientDAO = new PatientDAO();
                        List<Patient> patients = patientDAO.getAllPatients();
                        for (Patient patient : patients) {
                    %>
                        <option value="<%= patient.getId() %>"><%= patient.getName() %></option>
                    <% } %>
                </select>
            </div>
            <div class="form-group">
                <label for="doctor">Doctor:</label>
                <select class="form-control" id="doctor" name="doctor" required>
                    <option value="" disabled selected>Select a doctor</option>
                    <% 
                        DoctorDAO doctorDAO = new DoctorDAO();
                        List<Doctor> doctors = doctorDAO.getAllDoctors();
                        for (Doctor doctor : doctors) {
                    %>
                        <option value="<%= doctor.getId() %>"><%= doctor.getName() %></option>
                    <% } %>
                </select>
            </div>
            <div class="form-group">
                <label for="appointmentDate">Appointment Date:</label>
                <input type="date" class="form-control" id="appointmentDate" name="appointmentDate" min="<%= java.time.LocalDate.now() %>" required>
            </div>
            <div class="form-group">
                <label for="appointmentTime">Appointment Time:</label>
                <input type="time" class="form-control" id="appointmentTime" name="appointmentTime" required>
            </div>
            <button type="submit" class="btn btn-primary">Create Appointment</button>
            <a href="index.jsp" class="btn btn-secondary">Cancel</a>
        </form>
        <div class="alert alert-warning mt-3" role="alert" id="successAlert" style="display:none;">
            Appointment created successfully!
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
