<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.PatientDAO" %>
<%@ page import="model.Appointment" %>
<%@ page import="model.Patient" %>
<%@ page import="model.Doctor" %>
<%@ page import="java.util.List" %>

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
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
		<script>
		    $(document).ready(function() {
		        // Add click event listener to patient names
		        $("body").on("click", ".patient-link", function(e) {
		            e.preventDefault();
		            var patientId = $(this).data("patient-id");
		            var url = "patient_info.jsp?id=" + patientId;
		
		            // AJAX request to load patient information
		            $.ajax({
		                url: url,
		                type: "GET",
		                success: function(response) {
		                    $("#patientInfoModal .modal-body").html(response);
		                    $("#patientInfoModal").modal("show");
		                },
		                error: function(xhr, status, error) {
		                    console.log("Error loading patient information:", error);
		                }
		            });
		        });
		
		        // Clear modal content when it is closed
		        $("#patientInfoModal").on("hidden.bs.modal", function() {
		            $("#patientInfoModal .modal-body").html("");
		        });
		    });
		</script>
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
                PatientDAO patientDAO = new PatientDAO();
                List<Appointment> appointments = patientDAO.getAllAppointments();
                if (appointments.isEmpty()) { 
                %>
                    <tr>
                        <td colspan="6">No patient information available</td>
                    </tr>
                <% 
                } else {
                    for (Appointment appointment : appointments) {
                        Patient patient = appointment.getPatient();
                %>
                    <tr>
                        <td><a href="#" class="patient-link" data-patient-id="<%= patient.getId() %>"><%= patient.getName() %></a></td>
                        <td><%= patient.getDateOfBirth() %></td>
                        <td><%= patient.getAge() %></td>
                        <td><%= patient.getHeight() %></td>
                        <td><%= patient.getWeight() %></td>
                        <td><%= patient.getBloodType() %></td>
                    </tr>
                <% 
                    }
                }
                %>
            </tbody>
        </table>
    </div>

    <!-- Patient Information Modal -->
    <div class="modal fade" id="patientInfoModal" tabindex="-1" role="dialog" aria-labelledby="patientInfoModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="patientInfoModalLabel">Patient Information</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Patient information will be loaded dynamically here -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>