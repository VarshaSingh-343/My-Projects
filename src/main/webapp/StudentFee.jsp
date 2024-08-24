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
				String currstuname = null;
				String currcourse = null;
				String currtransactionid = "Not Paid";
				String currpaymentdate = "Not Paid";
				String curramount = "Not Paid";
				
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
		  
		  String sql2 = "SELECT * FROM fees WHERE email = ?";
		  PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		  pstmt2.setString(1, curremail);
		  ResultSet rs2 = pstmt2.executeQuery();
		  rs2.next();
		  currstuname = rs2.getString("studentname");
		  currcourse = rs2.getString("course");
		  currtransactionid = rs2.getString("transactionid");
		  currpaymentdate = rs2.getString("paymentdate");
		  curramount = rs2.getString("amount");
		
		  pstmt2.close();
		  rs2.close();
		  
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
	<title>Your Fee Details</title>
	<link rel="stylesheet" type="text/css" href="css/StudentFee.css">
</head>
<body>
	<%@ include file="StudentSidebar.jsp" %>
	<div class="maincon"> 
			<p><br>Here is your last payment details for your Course.</p>
			<div class="form-wrapper">
				<form method="post" action="">
				<div class="form-item">
					<label for="transactionid">Transaction ID:</label>
					 <span id="transactionid"><%= currtransactionid %></span>
				</div>
			    <div class="form-item">
					<label for="paymentdate">Payment Date:</label>
					 <span id="paymentdate"><%= currpaymentdate %></span>
				</div>
				<div class="form-item">
					<label for="amount">Amount (In Rupees):</label>
					 <span id="amount"><%= curramount %></span>
				</div>
			</form>
		</div>
	</div>
</body>
</html>