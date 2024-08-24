<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
	String studentname = request.getParameter("hidden_firstname")+" "+request.getParameter("hidden_lastname");
	String gender = request.getParameter("hidden_gender");
	String dob = request.getParameter("hidden_dob");
	String email = request.getParameter("hidden_email");
	String contact = request.getParameter("hidden_contact");
	String address = request.getParameter("hidden_address");
	String fathername = request.getParameter("hidden_fathername");
	String mothername = request.getParameter("hidden_mothername");
	String guardiancontact = request.getParameter("hidden_guardiancontact");
	String tenth = request.getParameter("hidden_tenth");
	String twelth = request.getParameter("hidden_twelth");
	String graduation = request.getParameter("hidden_graduation");
	String course = request.getParameter("hidden_course");
		
	try{
		//JDBC connection code
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/smsproject", "root", "varsha");
		
		String sql = "INSERT INTO students (studentname, gender, dob, email, contact, address, fathername, mothername, guardiancontact, tenth, twelth, graduation, course) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		
		// Set the parameter values for the SQL statement
	    pstmt.setString(1, studentname);
	    pstmt.setString(2, gender);
	    pstmt.setString(3, dob);
	    pstmt.setString(4, email);
	    pstmt.setString(5, contact);
	    pstmt.setString(6, address);
	    pstmt.setString(7, fathername);
	    pstmt.setString(8, mothername);
	    pstmt.setString(9, guardiancontact);
	    pstmt.setString(10, tenth);
	    pstmt.setString(11, twelth);
	    pstmt.setString(12, graduation);
	    pstmt.setString(13, course);
	       
	   	int a = pstmt.executeUpdate();
	   	System.out.println(a);
	    conn.close();
	  } 
		catch (Exception e) {
		  
		 }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Admission Form</title>
  <link rel="stylesheet" href="css/AdmissionLast.css">
</head>
<body>
	<div class="container">
		<div class="successmsg">
			<p> Thank you,<span> <%=studentname %>!</span> <br>Your admission form has been submitted successfully.</p>
		</div>
		<div class="contactmsg">
			<p>We will review your application and contact you shortly.</p>
		</div>
		<div class="backtohome">
			<form action="HomePage.jsp">
			<button type="submit">Return To Home</button>
			</form>
		</div>
	</div>
</body>
</html>