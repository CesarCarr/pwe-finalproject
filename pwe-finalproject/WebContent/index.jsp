<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.AppointmentDAO" %>
<%@ page import="model.Appointment" %>
<%@ page import="model.Patient" %>
<%@ page import="model.Doctor" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Comparator" %>

<!DOCTYPE html>
<html>
<head>
    <title>Appointments</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f2f2f2;
            color: #333333;
        }

        .navbar {
            background-color: #3f51b5;
            color: #ffffff;
        }

        .navbar-brand {
            color: #ffffff;
            font-weight: bold;
        }

        .navbar-nav .nav-link {
            color: #ffffff;
        }

        .navbar-nav .active .nav-link {
            color: #ff5722;
        }

        .container {
            margin-top: 50px;
        }

        .table {
            background-color: #ffffff;
            color: #333333;
        }

        .table th,
        .table td {
            border-color: #dddddd;
        }

        .table thead th {
            background-color: #f2f2f2;
            color: #333333;
            font-weight: bold;
        }

        .table tbody td a {
            color: #3f51b5;
            text-decoration: none;
        }

        .table tbody tr:hover {
            background-color: #f9f9f9;
        }

        .alert-info {
            background-color: #f2f2f2;
            color: #333333;
        }

        .btn-create,
        .btn-update {
            background-color: #ff5722;
            color: #ffffff;
            border: none;
            margin-right: 10px;
        }
        
        .btn-create:hover,
        .btn-update:hover {
            background-color: #f44336;
        }
        
        .btn-remove {
            background-color: #d32f2f;
            color: #ffffff;
            border: none;
            padding: 2px 10px;
        }
        
        .btn-remove:hover {
            background-color: #b71c1c;
        }
		.modal-header {
		    background-color: #f8f9fa;
		    border-bottom: 1px solid #dee2e6;
		}
		
		.modal-title {
		    color: #343a40;
		    font-size: 20px;
		}
		
		.modal-body {
		    background-color: #ffffff;
		}
		
		.modal-footer {
		    background-color: #f8f9fa;
		    border-top: none;
		}
		
		.info-row {
		    margin-bottom: 10px;
		}
		
		.info-label {
		    font-weight: bold;
		    margin-right: 5px;
		}
		
		.info-value {
		    font-weight: normal;
		}

    </style>
      <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	  <script>
		  $(document).ready(function() {
		    // Click event handler for patient names
		    $(".patient-name").click(function() {
		      var patientId = $(this).data("patient-id");
		
		      // AJAX request to fetch patient information
		      $.ajax({
		        url: "patient_info.jsp", 
		        type: "POST",
		        data: { patientId: patientId },
		        success: function(response) {
		          console.log("Response received:", response);
		
		          // Display the patient information in a modal or update a specific section of the page
		          $("#patientModal .modal-title").text("Patient Information - " + response.name);
		          var patientInfo =
		            "Name: " +
		            response.name +
		            "<br>" +
		            "Age: " +
		            response.age +
		            "<br>" +
		            "Date of Birth: " +
		            response.dateOfBirth +
		            "<br>" +
		            "Weight: " +
		            response.weight +
		            "<br>" +
		            "Blood Type: " +
		            response.bloodType +
		            "<br>" +
		            "Height: " +
		            response.height;
		          $("#patientModal .modal-body").html(patientInfo);
		          $("#patientModal").modal("show");
		        },
		        error: function(xhr, status, error) {
		          // Handle the error appropriately
		          console.log("Error: " + error);
		        },
		      });
		    });
		
		    $(".btn-remove").click(function() {
		      var appointmentId = $(this).data("appointment-id");
		      if (confirm("Are you sure you want to remove this appointment?")) {
		        $.ajax({
		          url: "remove_appointment.jsp",
		          type: "POST",
		          data: { appointmentId: appointmentId },
		          success: function(response) {
		            console.log("Appointment removed:", response);
		            location.reload();
		          },
		          error: function(xhr, status, error) {
		            console.log("Error: " + error);
		          },
		        });
		      }
		    });
		  });
		</script>

</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand mr-auto" href="#">
                MediViewer
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
  						<a class="nav-link" href="manage_patients.jsp">Manage Patients</a>
				    </li>

                </ul>
            </div>
        </div>
    </nav>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>Appointments</h1><br><br>
                <button class="btn btn-create" onclick="location.href='create_appointment.jsp'">Create Appointment</button><br><br>
                <table id="appointmentTable" class="table">
                    <thead>
                        <tr>
                            <th>Patient</th>
                            <th>Doctor</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        AppointmentDAO appointmentDAO = new AppointmentDAO();
                        List<Appointment> appointments = appointmentDAO.getAllAppointments();
                        if (appointments.isEmpty()) {
                        %>
                            <tr>
                                <td colspan="5">No appointments registered</td>
                            </tr>
                        <% } else {
                        	Collections.sort(appointments, Comparator.nullsLast(
                        	        Comparator.comparing(Appointment::getDate, Comparator.nullsLast(Comparator.naturalOrder()))
                        	                  .thenComparing(Appointment::getTime, Comparator.nullsLast(Comparator.naturalOrder()))
                        	    ));
                        	    for (Appointment appointment : appointments) {
                        %>
                            <tr>
                                <td><a class="patient-name" href="#" data-patient-id="<%= appointment.getPatient().getId() %>"><%= appointment.getPatient().getName() %></a></td>
                                <td><%= appointment.getDoctor().getName() %></td>
                                <td><%= appointment.getDate() %></td>
                                <td><%= appointment.getTime() %></td>
                                <td>
                                    <button class="btn btn-remove" data-appointment-id="<%= appointment.getId() %>">Remove</button>
                                    <a href="update_appointment.jsp?id=<%= appointment.getId() %>" class="btn btn-primary">Update</a>
                                </td>
                            </tr>
                        <% }
                        } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/popper.js/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <div id="patientModal" class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Patient Information</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="patient-info">
                    <div class="info-row">
                        <span class="info-label">Name:</span>
                        <span id="patientName" class="info-value"></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Date of Birth:</span>
                        <span id="patientDOB" class="info-value"></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Age:</span>
                        <span id="patientAge" class="info-value"></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Weight:</span>
                        <span id="patientWeight" class="info-value"></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Blood Type:</span>
                        <span id="patientBloodType" class="info-value"></span>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
