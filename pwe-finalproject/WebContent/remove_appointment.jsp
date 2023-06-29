<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="dao.AppointmentDAO" %>
<%@ page import="java.util.Optional" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<%
    String appointmentId = request.getParameter("appointmentId");
	int id = 0;
    if (appointmentId != null && !appointmentId.isEmpty()) {
        try {
            id = Integer.parseInt(appointmentId);
            AppointmentDAO appointmentDAO = new AppointmentDAO();
            appointmentDAO.removeAppointmentById(id);
            out.println("Appointment removed successfully");
        } catch (NumberFormatException e) {
            out.println("Invalid appointment ID");
        }
    } else {
        out.println("Appointment ID is required");
    }
%>
