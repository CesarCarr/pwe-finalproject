<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.AppointmentDAO" %>
<%@ page import="model.Appointment" %>
<%@ page import="model.Doctor" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Comparator" %>

<%
    AppointmentDAO appointmentDAO = new AppointmentDAO();
%>


<!DOCTYPE html>
<html>
<head>
    <title>Update Appointment</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h1 class="text-center mt-5">Update Appointment</h1>
        <form action="updateAppointment" method="POST">
            <input type="hidden" name="id" value="<%= request.getParameter("id") %>">
            <div class="form-group">
                <label for="date">Date:</label>
                <input type="date" class="form-control" id="date" name="date" required>
            </div>
            <div class="form-group">
                <label for="time">Time:</label>
                <input type="time" class="form-control" id="time" name="time" required>
            </div>
            <div class="form-group">
                <label for="doctor">Doctor:</label>
                <select class="form-control" id="doctor" name="doctor" required>
                    <option value="">Select a doctor</option>
                    <% 
                        List<Doctor> doctors = appointmentDAO.getAllDoctors();
                        for (Doctor doctor : doctors) {
                    %>
                    <option value="<%= doctor.getId() %>"><%= doctor.getName() %></option>
                    <% } %>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Update Appointment</button>
        </form>
    </div>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</body>
</html>
