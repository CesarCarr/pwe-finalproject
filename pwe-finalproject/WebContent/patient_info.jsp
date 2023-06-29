<%@ page import="dao.PatientDAO" %>
<%@ page import="model.Patient" %>
<%@ page import="dao.AppointmentDAO" %>
<%@ page import="org.json.JSONObject" %>


<%
    // Get the patient ID from the AJAX request
    String patientIdParam = request.getParameter("patientId");
    int id = 0;

    if (patientIdParam != null && !patientIdParam.isEmpty()) {
        try {
            id = Integer.parseInt(patientIdParam);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    PatientDAO patientDAO = new PatientDAO();

    Patient patient = patientDAO.getPatientById(id);

    JSONObject patientData = new JSONObject();
    patientData.put("name", patient.getName());
    patientData.put("dateOfBirth", patient.getDateOfBirth());
    patientData.put("age", patient.getAge());
    patientData.put("height", patient.getHeight());
    patientData.put("weight", patient.getWeight());
    patientData.put("bloodType", patient.getBloodType());
    // Add more properties for additional patient information

    // Send the patient information as the response
    response.setContentType("application/json");
    response.getWriter().write(patientData.toString());
%>
