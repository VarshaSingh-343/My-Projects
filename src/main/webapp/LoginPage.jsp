<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
 
 <%
	  if(request.getParameter("submit") != null) {
	    String username = request.getParameter("username");
	    String password = request.getParameter("password");
	    String role = request.getParameter("role");
	
	    if (!username.trim().isEmpty() && !password.trim().isEmpty()) {
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/smsproject", "root", "varsha");
	
	        String sql = "SELECT username, password, role FROM login WHERE username = ? AND password = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, username);
	        pstmt.setString(2, password);
	
	        rs = pstmt.executeQuery();
	
	        if (rs.next()) {
	          String dbRole = rs.getString("role");
	          if (role.equals(dbRole)) {
	        	  session.setAttribute("user", username);
	            if (dbRole.equals("Admin")) {
	              response.sendRedirect("AdminDashboard.jsp");
	            } 
	            else if (dbRole.equals("Student")) {
	              response.sendRedirect("StudentDashboard.jsp");
	            }
	          } else {
	              String errorMessage = "Invalid username or password. Please try again.";
		     	  String redirectUrl = "LoginPage.jsp";
		     	  String jsScript = "alert('" + errorMessage + "'); window.location.href = '" + redirectUrl + "';";
		     	  out.println("<script>" + jsScript + "</script>");
	          }
	        } else {
		          String errorMessage = "Please try again.";
		       	  String redirectUrl = "LoginPage.jsp";
		       	  String jsScript = "alert('" + errorMessage + "'); window.location.href = '" + redirectUrl + "';";
		       	  out.println("<script>" + jsScript + "</script>");
	        }
	
	        conn.close();
		        		 
	      } catch (Exception e) {
	       		System.out.println("Error: " + e.getMessage());
	      }
	    }
	  }
 %>
  
<!DOCTYPE html>
<html>
<head>
  <title>Login Form</title>
  <link rel="stylesheet" type="text/css" href="css/Login.css">
</head>
<body>
	<div class="login-box">
    <h2>Login</h2>
    <form method="post" action="LoginPage.jsp">
      <div class="user-box">
        <input type="text" name="username" placeholder="Enter Username" required>
      </div>
      <div class="user-box">
        <input type="password" name="password" placeholder="Enter Password" required>
      </div>
      <div class="user-box">
        <select name="role" required>
          <option value="" selected disabled>Select Role</option>
          <option value="Admin">Admin</option>
          <option value="Student">Student</option>
        </select>
      </div>
      <button type="submit" name='submit'>Login</button>
       <div class="registerme">
       	<a href="RegisterPage.jsp">Register Me</a>
      </div>
    </form>
    <a href="HomePage.jsp"><button id="backbut">Back</button></a>
  </div> 
</body>
</html>