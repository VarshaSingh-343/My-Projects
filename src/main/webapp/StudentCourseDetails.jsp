<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%  
		String curruser = session.getAttribute("user").toString();
	 	 if(curruser == null){
	    	response.sendRedirect("LoginPage.jsp");
	 	 }
%>
<%				
				String curremail = null;
				String currcourse = null;
				String currcoursecode = null;
				String currcourseduration = null;
				String currcourseabout = null;
				
		Connection conn = null;
		try {
		  Class.forName("com.mysql.cj.jdbc.Driver");
		  conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/smsproject", "root", "varsha");
		
		  // finding current user email to get more information from the table
		  String sql1 = "SELECT email FROM login WHERE username = ?";
		  PreparedStatement pstmt1 = conn.prepareStatement(sql1);
		  pstmt1.setString(1, curruser);
		  ResultSet rs1 = pstmt1.executeQuery();
		  rs1.next();
		  curremail = rs1.getString("email");	 
		 
		  pstmt1.close();
		  rs1.close();
		  
		  String sql2 = "SELECT course FROM admittedstudents WHERE email = ?";
		  PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		  pstmt2.setString(1, curremail);
		  ResultSet rs2 = pstmt2.executeQuery();
		  rs2.next();
		  currcourse = rs2.getString("course");
		
		  pstmt2.close();
		  rs2.close();
		  
		  String sql3 = "SELECT course_code, duration, about FROM courses WHERE course_name = ?";
		  PreparedStatement pstmt3 = conn.prepareStatement(sql3);
		  pstmt3.setString(1, currcourse);
		  ResultSet rs3 = pstmt3.executeQuery();
		  rs3.next();
		  	currcoursecode = rs3.getString("course_code");
			currcourseduration = rs3.getString("duration");
			currcourseabout = rs3.getString("about");
		
		  pstmt3.close();
		  rs3.close();
		  
		  conn.close();
		}
		catch(Exception e){
			System.out.println(e.getMessage());
		}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Your Course Details</title>
	<link rel="stylesheet" type="text/css" href="css/StudentCourseDetails.css">
</head>
<body>
	<%@ include file="StudentSidebar.jsp" %>
	<div class="maincon"> 
			<h1>Course Details</h1>
			<div class="form-wrapper">
				<form method="post" action="">
				<div class="form-item">
					<label for="course_code">Course Code:</label>
					 <span id="course_code"><%= currcoursecode %></span>
				</div>
			    <div class="form-item">
					<label for="course_name">Course Name:</label>
					 <span id="couuse_name"><%= currcourse %></span>
				</div>
				<div class="form-item">
					<label for="duration">Duration (Years):</label>
					 <span id="duration"><%= currcourseduration %></span>
				</div>
				<div class="form-item">
					<label for="description">Description:</label>
					 <span id="description"><%= currcourseabout %></span>
				</div>
			</form>
		</div>
	</div>
</body>
</html>