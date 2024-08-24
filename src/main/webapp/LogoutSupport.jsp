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
	  
	  if (request.getParameter("logbut") != null) {
	    	response.setHeader("Cache-Control","no-cache");
	    	session.invalidate();
	        response.sendRedirect("LoginPage.jsp"); 
	    }
	  
	  if (request.getParameter("canadmin") != null) {
		  response.sendRedirect("AdminDashboard.jsp");
	  }
	  
	  if (request.getParameter("canstu") != null) {
		  response.sendRedirect("StudentDashboard.jsp");
	  }

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>