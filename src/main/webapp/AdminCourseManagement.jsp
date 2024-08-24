<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
	 if(session.getAttribute("user") == null){
		response.sendRedirect("LoginPage.jsp");
	 }
%>

<!DOCTYPE html>
<html>
<head>
	<title>Course Management</title>
	<link rel="stylesheet" type="text/css" href="css/AdminCourseManagement.css">
</head>
<body>
	<%@ include file="AdminSidebar.jsp" %>
	<div class="maincon"> 
		<h1>List Of Courses</h1>
	<table>
		<tr>
			<th>Course Code</th>
			<th>Course Name</th>
			<th>Semester Fee(in Rs)</th>
			<th>Duration(Years)</th>
			<th>Description</th>
			<th>Edit</th>
			<th>Delete</th>
		</tr>
		<%
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/smsproject", "root", "varsha");
		
		if (request.getParameter("delete") != null) {
			String courseCode = request.getParameter("delete");
			
			PreparedStatement deleteStmt = conn.prepareStatement("DELETE FROM courses WHERE course_code = ?");
			deleteStmt.setString(1, courseCode);
			int rows = deleteStmt.executeUpdate();
			
			deleteStmt.close();
		}
		
		PreparedStatement countStmt = conn.prepareStatement("SELECT COUNT(*) FROM courses");
		ResultSet countResult = countStmt.executeQuery();
		countResult.next();
		int count = countResult.getInt(1);
		
		PreparedStatement stmt = conn.prepareStatement("SELECT * FROM courses");
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			String courseCode = rs.getString("course_code");
			String courseName = rs.getString("course_name");
			String fee = rs.getString("fee");
			String duration = rs.getString("duration");
			String description = rs.getString("about");
			
			out.println("<tr>");
			out.println("<td>" + courseCode + "</td>");
			out.println("<td>" + courseName + "</td>");
			out.println("<td>" + fee + "</td>");
			out.println("<td>" + duration + "</td>");
			out.println("<td>" + description + "</td>");
			out.println("<td><form action='UpdateCourse.jsp' method='post'><button type='submit' id='edit' name='edit' value='" + courseCode + "'>Edit Details</button></form></td>");
			out.println("<td><form action='AdminCourseManagement.jsp' method='post'><button type='submit' id='delete' name='delete' value='" + courseCode + "'>Delete Record</button></form></td>");
			out.println("</tr>");
		}
		
		
		out.println("<p id ='totalcourses'>Total Registered Courses: " + count + "</p>");
		
		// Close the JDBC connection
		rs.close();
		stmt.close();
		countResult.close();
		countStmt.close();
		conn.close();
		%>
	
	</table>
	<br>
			<a href="AddCourse.jsp"  class="add"><button>+ Add New Course</button></a>
		
	</div>
</body>
</html>

