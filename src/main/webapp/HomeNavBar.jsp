<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="css/NavBar.css">
</head>
<body>
	<div class="section-container">
		  <div class="logo">
			<img src="images/Logo.jpg" width="50%" height="90%"></img>
		</div>
		<div class="nameimage">
			STUDENT<br>MANAGEMENT<br>SYSTEM
		</div>
		<div class="loginbutton">
			<a href="LoginPage.jsp"><button class="login-button">Login</button></a>
		</div>
	</div>
	<nav>
		<ul>
			<li><a href="HomePage.jsp">Home</a></li>
			<li><a href="AboutUs.jsp">About</a></li>
			<li><a href="Admission.jsp">Admission</a></li>
			<li><a href="HomeCourses.jsp">Courses</a></li>
			<li><a href="ContactUs.jsp">Contact Us</a></li>
			<li id="open">Admissions Open (2023-2024)</li>
			
		</ul>
	</nav>
</body>
</html>