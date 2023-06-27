<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<style type="text/css">
        * {
            margin: 0;
            padding: 0;
        }
        
        /* Set dark mode color scheme */
        body {
            background-color: #111;
            color: #fff;
            font-family: Arial, sans-serif;
        }
        
        /* Top menu container */
        .top-menu {
            background-color: #333;
            height: 50px;
            padding: 10px;
        }
        
        .top-menu a {
            color: #fff;
            text-decoration: none;
            padding: 5px 10px;
            margin-right: 10px;
        }
        
        /* Middle container */
        .middle-container {
            margin: 20px auto;
            width: 80%;
        }
        
        /* Bottom footer container */
        .bottom-footer {
            background-color: #333;
            height: 50px;
            padding: 10px;
            text-align: center;
        }
        
        .bottom-footer p {
            color: #fff;
            margin: 0;
        }	
		
	</style>
	<script type="text/javascript">
		$(document).ready( function () {
			$("#btnInicio").click(function() {
				$("#leftDiv").load("leftArea.jsp");
				$("#rightDiv").load("rightArea.jsp");
				$("#bottonDiv").load("bottonArea.jsp");
			});
		});
	</script>
</head>
<body>

	<div class="top-menu">
        <a href="#">Home</a>
        <a href="#">About</a>
        <a href="#">Services</a>
        <a href="#">Contact</a>
    </div>
    
    <div class="middle-container">
        <!-- Your content goes here -->
        <h1>Welcome to the Medical Application</h1>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc rhoncus ultricies efficitur.</p>
   		<div class="middle-container">
    <h1>Welcome to the Medical Application</h1>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc rhoncus ultricies efficitur.</p>
    
    <table class="table table-dark table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Age</th>
                <!-- Add more columns as per your requirements -->
            </tr>
        </thead>
        <tbody>
            <% for (Patient patient : patientList) { %>
            <tr>
                <td><%= patient.getId() %></td>
                <td><%= patient.getName() %></td>
                <td><%= patient.getAge() %></td>
                <!-- Add more columns as per your requirements -->
            </tr>
            <% } %>
        </tbody>
    </table>
</div>
   		
    </div>
    
    <div class="bottom-footer">
        <p>&copy; 2023 Medical Application. All rights reserved.</p>
    </div>
    
    
</body>
</html>