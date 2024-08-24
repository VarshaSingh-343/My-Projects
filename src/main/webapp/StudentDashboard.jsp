<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
String curruser = session.getAttribute("user").toString();
if (curruser == null) {
	response.sendRedirect("LoginPage.jsp");
}
%>
<%
String curremail = null;
String studentname = null;
String gender = null;
String dob = null;
String email = null;
String contact = null;
String address = null;
String fathername = null;
String mothername = null;
String guardiancontact = null;
String tenth = null;
String twelth = null;
String graduation = null;
String course = null;

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

	String sql2 = "SELECT * FROM admittedstudents WHERE email = ?";
	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
	pstmt2.setString(1, curremail);
	ResultSet rs2 = pstmt2.executeQuery();
	rs2.next();

	studentname = rs2.getString("studentname");
	gender = rs2.getString("gender");
	dob = rs2.getString("dob");
	email = rs2.getString("email");
	contact = rs2.getString("contact");
	address = rs2.getString("address");
	fathername = rs2.getString("fathername");
	mothername = rs2.getString("mothername");
	guardiancontact = rs2.getString("guardiancontact");
	tenth = rs2.getString("tenth");
	twelth = rs2.getString("twelth");
	graduation = rs2.getString("graduation");
	if (graduation.equals("null")) {
		graduation = "Not Applicable";
	}
	course = rs2.getString("course");

	pstmt2.close();
	rs2.close();

} catch (Exception e) {
	System.out.println("Hello" + e.getMessage());
}
%>
<%
if (request.getParameter("submit") != null) {

	// Get the form data from the request parameters
	String updateaddress = request.getParameter("updateaddress");
	String updatecontact = request.getParameter("updatecontact");
	String updateguardiancontact = request.getParameter("updateguardiancontact");

	try {
		// Execute a query to update the course information
		PreparedStatement updateStmt = conn.prepareStatement(
		"UPDATE admittedstudents SET contact = ?, address = ?, guardiancontact = ? WHERE email = ?");
		updateStmt.setString(1, updatecontact);
		updateStmt.setString(2, updateaddress);
		updateStmt.setString(3, updateguardiancontact);
		updateStmt.setString(4, curremail);
		int rows = updateStmt.executeUpdate();

		updateStmt.close();
		conn.close();

		response.sendRedirect("StudentDashboard.jsp");
	} catch (Exception e) {
		System.out.println(e.getMessage());
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Your DashBoard</title>
<link rel="stylesheet" type="text/css" href="css/StudentDashboard.css">
</head>
<body>
	<%@ include file="StudentSidebar.jsp"%>
	<div class="maincon">
		<div class="container">
			<h1>
				Welcome
				<%=studentname%></h1>
			<div class="form-wrapper">
				<form action="StudentDashboard.jsp" method="post">
					<label class="recog">Personal Information</label>
					<div class="form-item">
						<label for="email">Email:</label> <span id="email"><%=email%></span>
					</div>
					<div class="form-item">
						<label for="gender">Gender:</label> <span id="gender"><%=gender%></span>
					</div>
					<div class="form-item">
						<label for="dob">Date of Birth:</label> <span id="dob"><%=dob%></span>
					</div>
					<div class="form-item">
						<label for="contact">Contact No:</label> <input type="tel"
							name="updatecontact" pattern="[0-9]{10}" value="<%=contact%>">
					</div>
					<div class="form-item">
						<label for="address">Address:</label> <input type="text"
							name="updateaddress" value="<%=address%>">
					</div>

					<label class="recog">Guardian's Information</label>
					<div class="form-item">
						<label for="fathername">Father's Name:</label> <span
							id="fathername"><%=fathername%></span>
					</div>
					<div class="form-item">
						<label for="mothername">Mother's Name:</label> <span
							id="mothername"><%=mothername%></span>
					</div>
					<div class="form-item">
						<label for="guardiancontact">Contact No:</label>
						 <input type="tel" name="updateguardiancontact" pattern="[0-9]{10}" value="<%=guardiancontact%>">
					</div>

					<label class="recog">Educational Qualifications</label>
					<div class="form-item">
						<label for="tenth">10th Percentage:</label> <span id="tenth"><%=tenth%></span>
					</div>
					<div class="form-item">
						<label for="twelth">12th Percentage:</label> <span id="twelth"><%=twelth%></span>
					</div>
					<div class="form-item">
						<label for="graduation">If, Graduated:</label> <span
							id="graduation"><%=graduation%></span>
					</div>

					<div class="form-item">
						<label for="course">Course:</label> <span id="course"><%=course%></span>
					</div>

					<button type="submit" name="submit">Update</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>

