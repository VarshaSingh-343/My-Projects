<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fee Details</title>
<link rel="stylesheet" type="text/css" href="css/AdminFee.css">
</head>
<body>
	<%@ include file="AdminSidebar.jsp"%>
	<div class="maincon">
		<h1>Fee Status </h1>
		<div class="form-wrapper">
			<div class="form-item">
				<form>
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
						%>
					</select> 
					<br>
					<label id="choosefee">Choose Fee Status:</label> 
					<select name="feestatus" id="feestatus" required>
						<option value="" selected disabled>Select Fee Status</option>
						<option value="paid">Paid</option>
						<option value="unpaid">Unpaid</option>
					</select>
					<button type="submit" name="submit" id="searchbut">Search</button>
				</form>
			</div>

			<div class="tablecontent">
				<table>
					<%
					if (request.getParameter("submit") != null) {
						try {
							String course = request.getParameter("course");
							String squery = "SELECT * FROM admittedstudents WHERE course = ?";
							PreparedStatement stmt1 = conn.prepareStatement(squery);
							stmt1.setString(1, course);
							ResultSet rs1 = stmt1.executeQuery();

							String squ = "SELECT * FROM fees WHERE course = ?";
							PreparedStatement stmt2 = conn.prepareStatement(squ);
							stmt2.setString(1, course);
							ResultSet rs2 = stmt2.executeQuery();

							String feestatus = request.getParameter("feestatus");

							if (feestatus.equals("paid")) {
						out.println(
								"<tr><th> Course </th><th> Student Name</th><th> Email </th><th>Transaction ID</th><th>Payment ID</th><th>Amount</th></tr>");
						while (rs2.next()) {
							String name = rs2.getString("studentname");
							String email = rs2.getString("email");
							String transactionid = rs2.getString("transactionid");
							String paymentdate = rs2.getString("paymentdate");
							String amount = rs2.getString("amount");
							out.println("<tr><td>" + course + "</td><td>" + name + "</td><td>" + email + "</td><td>" + transactionid
									+ "</td><td>" + paymentdate + "</td><td>" + amount + "</td></tr>");
						}
							} 
							
							if (feestatus.equals("unpaid")) {
						out.println("<tr><th> Course </th><th> Student Name </th><th> Email </th><th> Contact </th></tr>");
						while (rs1.next()) {
							String name = rs1.getString("studentname");
							String stuemail = rs1.getString("email");
							String contact = rs1.getString("contact");

							boolean match = false;
							rs2 = stmt2.executeQuery();
							while (rs2.next()) {
								String email = rs2.getString("email");
								if(email.equals(stuemail)){
									match = true;
								}
							}
							
							if(!match){
								out.println("<tr><td>" + course + "</td><td>" + name + "</td><td>" + stuemail + "</td><td>" + contact + "</td></tr>");	
							}
						}
							}

							rs.close();
							rs1.close();
							rs2.close();
							stmt.close();
							stmt1.close();
							stmt2.close();	
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