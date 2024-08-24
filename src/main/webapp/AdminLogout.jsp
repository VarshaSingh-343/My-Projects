<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String curruser = session.getAttribute("user").toString();
	 if(curruser == null){
		response.sendRedirect("LoginPage.jsp");
	 }
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Logout</title>
	<link rel="stylesheet" type="text/css" href="css/Logout.css">
</head>
<body>
		<%@ include file="AdminSidebar.jsp" %>
	 <div class="maincon" > 
	 <div class="form-wrapper">
	 		<form method = "post" action = "LogoutSupport.jsp" >
			 	<label>Are you sure you want to log out?</label><br>
				<button type="submit" id="log" name="logbut">Yes, Log Out</button><br>
				<button type="submit" id="can" name="canadmin">Cancel</button>
			</form>
	 </div>
	</div> 
</body>
</html>