<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
  	if (request.getParameter("submit") != null){
  		try {
			String username = request.getParameter("username"); 
			String password = request.getParameter("password");
			String role = request.getParameter("role");
			String email = request.getParameter("email");
		
			Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/smsproject", "root", "varsha");
	        
	        String sql1 = "Select username, email from login";
	        PreparedStatement pstmt1 = con.prepareStatement(sql1);
	        ResultSet rs1 = pstmt1.executeQuery();
	        
	       	boolean umatch = false;
	       	boolean ematch = false;
	       	
	       	while( rs1.next()){
	        	if(rs1.getString("username").equals(username)){
	        		umatch = true; 
	        		break;
	        	}
	        	if(rs1.getString("email").equals(email)){
	        		ematch = true; 
	        		break;
	        	}
	        }
	       	
	       	if(umatch || ematch){
	        	if(umatch){
	        		out.println("<input type= 'text' id='hiddenfi' value='This Username is already Registered. Try Another.'>");
	        	}
	        	if(ematch){
	        		out.println("<input type= 'text' id='hiddenfi' value='This Email-ID is already Registered. Try Another.'>");
	        	}
	        }else{
	        	 if(role.equals("Student")){
	 		        String sql2 = "Select email from admittedstudents";
	 		        PreparedStatement pstmt2 = con.prepareStatement(sql2);
	 		        ResultSet rs2 = pstmt2.executeQuery();
	 		   
	 		    	boolean smatch = false;
	 		    	
	 	    		while( rs2.next()){
	 		        	if(rs2.getString("email").equals(email)){
	 		        		smatch = true; 
	 		        		break;
	 		        	}
	 		        }
	 	    		
	 	    		if(!smatch){
	 		        	out.println("<input type= 'text' id='hiddenfi' value='This Email is not found in the Registered Students Database.'>");
	 		        }
	 		        else{
	 		        	String sql ="INSERT INTO Login(username, password, role, email) VALUES(?,?,?,?)";
	 			        PreparedStatement pstmt = con.prepareStatement(sql);
	 			        
	 					pstmt.setString(1, username);
	 					pstmt.setString(2, password);
	 					pstmt.setString(3, role);
	 					pstmt.setString(4, email);  
	 					
	 					pstmt.executeUpdate();
	 					pstmt.close();
	 					
	 					response.sendRedirect("LoginPage.jsp");
	 		        }
	 	        }else{
	 	        	String sql3 = "Select email from admin";
	 		        PreparedStatement pstmt3 = con.prepareStatement(sql3);
	 		        ResultSet rs3 = pstmt3.executeQuery();
	 		   
	 		    	boolean amatch = false;
	 		    	
	 	    		while( rs3.next()){
	 		        	if(rs3.getString("email").equals(email)){
	 		        		amatch = true; 
	 		        		break;
	 		        	}
	 		        }
	 	    		
	 	    		if(!amatch){
	 		        	out.println("<input type= 'text' id='hiddenfi' value='This Email is not found in the Registered Admin Database.'>");
	 		        }
	 		        else{
	 		        	String sql ="INSERT INTO Login(username, password, role, email) VALUES(?,?,?,?)";
	 			        PreparedStatement pstmt = con.prepareStatement(sql);
	 			        
	 					pstmt.setString(1, username);
	 					pstmt.setString(2, password);
	 					pstmt.setString(3, role);
	 					pstmt.setString(4, email);  
	 					
	 					pstmt.executeUpdate();
	 					pstmt.close();
	 					
	 					response.sendRedirect("LoginPage.jsp");
	 		        }
	 	        }
	        }
	      
	        
	        con.close();
			} 
			catch (Exception e) {
				System.out.println( e.getMessage());
			}
  		}	
%>
	
<!DOCTYPE html>
<html>
<head>
	<title>Register Me</title>
	<link rel="stylesheet" type="text/css" href="css/Register.css">
</head>
<body>
	<div class="register-box">
    <h2>Registration Form</h2>
    <form method="post" action="RegisterPage.jsp" >
	      <div class="user-box">
	        <input type="text" name="username" placeholder="Enter Username" required>
	      </div>
	      <div class="user-box">
	        <input type="password" name="password" placeholder="Enter Password"  required>
	      </div>
	      <div class="user-box">
	        <select name="role" required>
	          <option value="" selected disabled>Select Role</option>
	          <option value="Admin">Admin</option>
	          <option value="Student">Student</option>
	        </select>
	      </div>
	      <div class="user-box">
	      <input type="email" name="email" placeholder="Enter Email" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" required>
	    </div>
	      <button type="submit" name="submit">Register</button>
    </form>
    	
  </div> 
</body>
</html>