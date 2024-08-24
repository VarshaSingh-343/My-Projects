<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
	if (request.getParameter("submit") != null){
		try {
			String coursecode = request.getParameter("coursecode");
			coursecode = coursecode.trim();
			String coursename = request.getParameter("coursename");
			coursename = coursename.trim();
			String feee = request.getParameter("feee");
			String durations = request.getParameter("durations");
			String description = request.getParameter("description");
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/smsproject", "root", "varsha");
			
			 
	        String sql1 = "Select course_code, course_name from courses";
	        PreparedStatement pstmt1 = conn.prepareStatement(sql1);
	        ResultSet rs1 = pstmt1.executeQuery();
	        
	     	boolean umatch = false;
	     	boolean smatch = false;
	     	
	       	while(rs1.next()){
	       		if(coursecode.equals(rs1.getString("course_code"))){
	       			umatch = true;
	       			break;
	       		}
	       		if(coursename.equals(rs1.getString("course_name"))){
	       			smatch = true;
	       			break;
	       		}
	       	}
	       	
	       	if(umatch){
	       		out.println("<input type= 'text' id='hiddenfi' value='This Course Code is already Registered.'>");
	       	}
	       	else if(smatch){
	       		out.println("<input type= 'text' id='hiddenfi' value='This Course Name is already Registered.'>");
	       	}
	       	else{
	       		PreparedStatement pstmt = conn.prepareStatement("INSERT INTO courses (course_code, course_name, fee, duration, about) VALUES (?, ?, ?, ?, ?)");
				pstmt.setString(1, coursecode);
				pstmt.setString(2, coursename);
				pstmt.setString(3, feee);
				pstmt.setString(4, durations);
				pstmt.setString(5, description);
				int rows = pstmt.executeUpdate();
				
				pstmt.close();
				
				response.sendRedirect("AdminCourseManagement.jsp");
	       	}
	       	
			conn.close();
		} 
		catch (Exception e) {
			
		}
	}
%>

<html>
<head>
	<title>Add Course</title>
	<link rel="stylesheet" type="text/css" href="css/AddCourse.css">
</head>
<body>
	<div class="container">
		<h1>Add Course</h1>
		<div class="form-wrapper">
			<form method="post" action="<%=request.getContextPath()%>/AddCourse.jsp">
			<div class="form-item">
				<label for="course_code">Course Code:</label>
				<input type="text" id="coursecode" name="coursecode" required><br>
			</div>
				
		    <div class="form-item">
				<label for="course_name">Course Name:</label>
				<input type="text" id="coursename" name="coursename" required><br>
			</div>
				
			<div class="form-item">
				<label for="fee">Fee:</label>
				<input type="number" id="feee" name="feee" step="0.01" required><br>
			</div>
				
			<div class="form-item">
				<label for="duration">Duration (Years):</label>
				<input type="number" id="durations" name="durations" required><br>
			</div>
				
			<div class="form-item">
				<label for="description">Description:</label>
				<textarea id="description" name="description"></textarea><br>
			</div>
			<button type="submit" name="submit">Add Course</button>
		</form>
			<a href="AdminCourseManagement.jsp"><button>Back to Course Management</button></a>
		</div>
	</div>
	
</body>
</html>