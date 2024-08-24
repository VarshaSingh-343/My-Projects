<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student | Admission Form</title>
<link rel="stylesheet" href="css/AdmissionForm.css">
</head>
<body>
	<div class="container">
		<h1>ADMISSION FORM</h1>
		<div class="form-wrapper">
			<form action="AdmissionVerify.jsp" method="post">
				<label class="recog">Personal Information</label>
				<div class="form-item">
					<label for="firstname">First Name:</label> <input type="text"
						name="firstname" id="firstname" placeholder="First Name"
						pattern="[A-Za-z]+" required>
				</div>
				<div class="form-item">
					<label for="lastname">Last Name:</label> <input type="text"
						name="lastname" id="lastname" placeholder="Last Name"
						pattern="[A-Za-z]+" required>
				</div>
				<div class="form-item">
					<label for="gender">Gender:</label> <select id="gender"
						name="gender">
						<option value="">Select your gender</option>
						<option value="Male">Male</option>
						<option value="Female">Female</option>
						<option value="Other">Other</option>
					</select>
				</div>
				<div class="form-item">
					<label for="dob">Date of Birth:</label> <input type="date"
						name="dob" id="dob" required>
				</div>
				<div class="form-item">
					<label for="email">Email:</label> <input type="email" name="email"
						id="email" placeholder="Enter Valid email-id ex. email@xyz.com"
						pattern="[^\s@]+@[^\s@]+\.[^\s@]+" required>
				</div>
				<div class="form-item">
					<label for="contact">Contact No:</label> <input type="tel"
						name="contact" id="contact"
						placeholder="Enter 10-Digit Contact Number" pattern="[0-9]{10}"
						required>
				</div>
				<div class="form-item">
					<label for="address">Address:</label>
					<textarea id="address" name="address" rows="2" cols="50"
						placeholder="Address" required></textarea>
				</div>
				<hr>
				<label class="recog">Guardian's Information</label>
				<div class="form-item">
					<label for="fathername">Father's Name:</label> <input type="text"
						name="fathername" id="fathername" placeholder="Father's Full Name"
						pattern="[A-Za-z ]+" required>
				</div>
				<div class="form-item">
					<label for="mothername">Mother's Name:</label> <input type="text"
						name="mothername" id="mothername" placeholder="Mother's Full Name"
						pattern="[A-Za-z ]+" required>
				</div>
				<div class="form-item">
					<label for="contact">Contact No:</label> <input type="tel"
						name="guardiancontact" id="guardiancontact"
						placeholder="Enter 10-Digit Contact Number" pattern="[0-9]{10}"
						required>
				</div>
				<hr>
				<label class="recog">Educational Qualifications</label>
				<div class="form-item">
					<label for="tenth">10th Percentage:</label> <input type="number"
						step="0.01" name="tenth" id="tenth"
						placeholder="Enter 10th Percentage" required min="0" max="100">
				</div>
				<div class="form-item">
					<label for="twelth">12th Percentage:</label> <input type="number"
						step="0.01" name="twelth" id="twelth"
						placeholder="Enter 12th Percentage" required min="0" max="100">
				</div>
				<div class="form-item">
					<label for="graduation">If, Graduated:</label> <input type="number"
						step="0.01" name="graduation" id="graduation"
						placeholder="Enter Graduation CGPA" min="0" max="10">
				</div>
				<hr>
				<div class="form-item">
					<label for="course">Choose Course:</label> <select name="course"
						id="course" required>
						<option value="" selected disabled>Select Course</option>
						<%
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/smsproject", "root", "varsha");

						String query = "SELECT course_name FROM courses";
						Statement stmt = conn.createStatement();
						ResultSet rs = stmt.executeQuery(query);

						// Loop through the query results and display each option
						while (rs.next()) {
							String field_name = rs.getString("course_name");
							out.println("<option value='" + field_name + "'>" + field_name + "</option>");
						}

						rs.close();
						stmt.close();
						conn.close();
						%>
					</select>
				</div>
				<hr>
				<div id="verify">
					<button class="submit" type="submit">Proceed to Verify</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>