<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.AppointmentDAO" %>
<%@ page import="model.Appointment" %>
<%@ page import="model.Patient" %>
<%@ page import="model.Doctor" %>
<%@ page import="java.util.List" %>

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
        <h1 class="text-center">MediViewer</h1>
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
                <%
                List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
                if (appointments == null || appointments.isEmpty()) {
                %>
                    <tr>
                        <td colspan="4">No appointments registered</td>
                    </tr>
                <%
                } else {
                    for (Appointment appointment : appointments) {
                %>
                    <tr>
                        <td data-patient-id="<%= appointment.getPatient().getId() %>"><%= appointment.getPatient().getName() %></td>
                        <td><%= appointment.getDoctor().getName() %></td>
                        <td><%= appointment.getDate() %></td>
                        <td><%= appointment.getTime() %></td>
                    </tr>
                <%
                    }
                }
                %>
            </tbody>
        </table>
    </div>

    <div class="modal fade" id="patientModal" tabindex="-1" role="dialog" aria-labelledby="patientModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="patientModalLabel">Patient Information</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Patient information will be dynamically inserted here -->
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <script>
    $(document).ready(function() {
        // Event delegation to handle click on dynamically added elements
        $('#appointmentTable').on('click', 'tbody tr', function() {
            var patientId = $(this).data('patient-id');
            $.ajax({
                url: 'patient.jsp',
                type: 'GET',
                data: { id: patientId },
                success: function(response) {
                    $('#patientModal .modal-body').html(response);
                    $('#patientModal').modal('show');
                },
                error: function() {
                    console.log('An error occurred while fetching patient information.');
                }
            });
        });
    });

    </script>
</body>
</html>

