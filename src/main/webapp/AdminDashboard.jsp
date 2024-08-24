<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
if (session.getAttribute("user") == null) {
	response.sendRedirect("LoginPage.jsp");
}
String curruser = session.getAttribute("user").toString();
%>
<%
String curremail = null;
String adminname = null;
String gender = null;
String dob = null;
String contact = null;
String address = null;
String department = null;
String position = null;

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

	String sql2 = "SELECT * FROM admin WHERE email = ?";
	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
	pstmt2.setString(1, curremail);
	ResultSet rs2 = pstmt2.executeQuery();
	rs2.next();

	adminname = rs2.getString("admin_name");
	gender = rs2.getString("gender");
	dob = rs2.getString("dob");
	contact = rs2.getString("contact");
	address = rs2.getString("address");
	department = rs2.getString("department");
	position = rs2.getString("position");

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

	try {
		// Execute a query to update the course information
		PreparedStatement updateStmt = conn
		.prepareStatement("UPDATE admin SET contact = ?, address = ? WHERE email = ?");
		updateStmt.setString(1, updatecontact);
		updateStmt.setString(2, updateaddress);
		updateStmt.setString(3, curremail);
		int rows = updateStmt.executeUpdate();

		updateStmt.close();
		conn.close();

		response.sendRedirect("AdminDashboard.jsp");
	} catch (Exception e) {
		System.out.println(e.getMessage());
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Your DashBoard</title>
<link rel="stylesheet" type="text/css" href="css/AdminDashboard.css">
</head>
<body>
	<%@ include file="AdminSidebar.jsp"%>
	<div class="maincon">
		<div class="container">
			<h1>Welcome <%=adminname%></h1>
			<div class="form-wrapper">
				<form action="AdminDashboard.jsp" method="post">
					<div class="form-item">
						<label for="email">Email:</label> <span id="email"><%=curremail%></span>
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
					<div class="form-item">
						<label for="department">Department:</label> <span id="department"><%=department%></span>
					</div>
					<div class="form-item">
						<label for="position">Position:</label> <span id="position"><%=position%></span>
					</div>

					<button type="submit" name="submit">Update</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>

