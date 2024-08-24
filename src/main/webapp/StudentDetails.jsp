<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<%
if (session.getAttribute("user") == null) {
	response.sendRedirect("LoginPage.jsp");
}
%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Student Details</title>
	<link rel="stylesheet" type="text/css" href="css/StudentDetails.css">
</head>
<body>
	<%@ include file="AdminSidebar.jsp"%>
	<div class="maincon">
		<h1>Student Details</h1>
		<div class="form-wrapper">
			<div class="form-item">
				<form method="post" action="StudentDetails.jsp">
					<label id="choosecourse">Choose Course:</label> 
					<select name="course" id="course" required>
						<option value="" selected disabled>Select Course</option>
						<%
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/smsproject", "root", "varsha");

						String query = "SELECT course_name FROM courses";
						Statement stmt = conn.createStatement();
						ResultSet rs = stmt.executeQuery(query);
						while (rs.next()) {
							String field_name = rs.getString("course_name");
							out.println("<option value='" + field_name + "'>" + field_name + "</option>");
						}
						rs.close();
						stmt.close();
						%>
					</select>
					<button type="submit" name="submit" id="searchbut">Search</button>
				</form>
			</div>

			<div class="tablecontent">
				<table>
					<%
					if (request.getParameter("submit") != null) {
						try {
							out.print(
							"<tr><th>Student Name</th><th>Gender</th><th>DOB</th><th>Email</th><th>Contact No.</th><th>Father Name</th><th>Mother Name</th><th>Guardian Contact</th><th>Tenth</th><th>Twelth</th><th>Graduation</th></tr>");

							String course = request.getParameter("course");
							String squery = "SELECT * FROM admittedstudents WHERE course = ?";
							PreparedStatement stmt1 = conn.prepareStatement(squery);
							stmt1.setString(1, course);

							ResultSet rs1 = stmt1.executeQuery();

							while (rs1.next()) {
						String name = rs1.getString("studentname");
						String gender = rs1.getString("gender");
						String dob = rs1.getString("dob");
						String email = rs1.getString("email");
						String contact = rs1.getString("contact");
						String graduation = rs1.getString("graduation");
						if (graduation.equals("null")) {
							graduation = "Not Applicable";
						}
						String fathername = rs1.getString("fathername");
						String mothername = rs1.getString("mothername");
						String guardiancontact = rs1.getString("guardiancontact");
						String tenth = rs1.getString("tenth");
						String twelth = rs1.getString("twelth");
						out.println("<tr><td> " + name + " </td><td> " + gender + " </td><td> " + dob + " </td><td>" + email
								+ " </td><td> " + contact + " </td><td> " + fathername + " </td><td> " + mothername + " </td><td> "
								+ guardiancontact + " </td><td> " + tenth + " </td><td> " + twelth + " </td><td> " + graduation
								+ " </td></tr>");
							}

							rs.close();
							rs1.close();
							stmt.close();
							stmt1.close();
							conn.close();
						} catch (Exception e) {
							out.println("Error: " + e.getMessage());
						}
					}
					%>
				</table>
			</div>
		</div>
	</div>
</body>
</html>