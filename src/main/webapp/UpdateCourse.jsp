<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%	
		String courseCod = request.getParameter("edit");
		
		Connection conn = null;
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/smsproject", "root", "varsha");
		
		PreparedStatement editStmt = conn.prepareStatement("SELECT * FROM courses WHERE course_code = ?");
		editStmt.setString(1, courseCod);
		ResultSet editResult = editStmt.executeQuery();
		
		String currentCourseCode = null;
		String currentCourseName = null;
		String currentFee = null;
		String currentDuration = null;
		String currentDescription = null;
		
		while(editResult.next()){
			System.out.println(editResult.getString("course_code")+ " " + editResult.getString("fee"));
			// Store the current values in variables
			currentCourseCode = editResult.getString("course_code");
			currentCourseName = editResult.getString("course_name");
			currentFee = editResult.getString("fee");
			currentDuration = editResult.getString("duration");
			currentDescription = editResult.getString("about");
		}
				
		editResult.close();
		editStmt.close();
%>

<%
	if(request.getParameter("update") != null){
		
		// Get the form data from the request parameters
		String courseCode = request.getParameter("courseCode");
		String courseName = request.getParameter("courseName");
		String fee = request.getParameter("fee");
		String duration = request.getParameter("duration");
		String description = request.getParameter("description");

		// Execute a query to update the course information
		PreparedStatement updateStmt = conn.prepareStatement("UPDATE courses SET course_name = ?, fee = ?, duration = ?, about = ? WHERE course_code = ?");
		updateStmt.setString(1, courseName);
		updateStmt.setString(2, fee);
		updateStmt.setString(3, duration);
		updateStmt.setString(4, description);
		updateStmt.setString(5, courseCode);
		int rows = updateStmt.executeUpdate();

		updateStmt.close();
		conn.close();
		
		response.sendRedirect("AdminCourseManagement.jsp");
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Update Course</title>
	<link rel="stylesheet" type="text/css" href="css/UpdateCourse.css">
</head>
<body>
	<div class="container">
		<h1>Edit Course</h1>
		<div class="form-wrapper">
			<form method="post" action="UpdateCourse.jsp">
			<div class="form-item">
				<label for="course_code">Course Code:</label>
				<input type="text" name="courseCode"  value="<%= currentCourseCode %>" readonly><br>
			</div>
				
		    <div class="form-item">
				<label for="course_name">Course Name:</label>
				<input type="text" name="courseName" value="<%= currentCourseName %>" required><br>
			</div>
				
			<div class="form-item">
				<label for="fee">Fee:</label>
				<input type="number" name="fee" step="0.01" value="<%= currentFee %>" required><br>
			</div>
				
			<div class="form-item">
				<label for="duration">Duration (Years):</label>
				<input type="number" name="duration" value="<%= currentDuration %>" required><br>
			</div>
				
			<div class="form-item">
				<label for="description">Description:</label>
				<textarea name="description" required> <%= currentDescription %> </textarea><br>
			</div>
			
			<button type="submit" id='updatebut' name="update">Update</button>
		</form>
			<a href="AdminCourseManagement.jsp"><button id="but">Back</button></a>
		</div>
	</div>
	
</body>
</html>