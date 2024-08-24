<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%
	  String firstname = request.getParameter("firstname");
	  String lastname = request.getParameter("lastname");
	  String gender = request.getParameter("gender");
	  String dob = request.getParameter("dob");
	  String email = request.getParameter("email");
	  String contact = request.getParameter("contact");
	  String address = request.getParameter("address");
	  String fathername = request.getParameter("fathername");
	  String mothername = request.getParameter("mothername");
	  String guardiancontact = request.getParameter("guardiancontact");
	  String tenth = request.getParameter("tenth");
	  String twelth = request.getParameter("twelth");
	  String graduation = request.getParameter("graduation");
	  if(graduation.equals("")) {
		  graduation = null;
		}
	  String course = request.getParameter("course");
	  
	  Class.forName("com.mysql.cj.jdbc.Driver");
	  Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/smsproject", "root", "varsha");
	  
	  String sql2 = "Select email, contact from admittedstudents";  
      PreparedStatement pstmt2 = con.prepareStatement(sql2);
      ResultSet rs1 = pstmt2.executeQuery();
      
      boolean cmatch = false;
      boolean ematch = false;
      
      boolean enableButton = false;
         
      while( rs1.next()){
    	  if(rs1.getString("email").equals(email)){
        		ematch = true; 
        		break;
        	}
      		if(rs1.getString("contact").equals(contact)){
	      		cmatch = true; 
	      		break;
      		}
      }
      
      if(cmatch || ematch){
    	  out.println("<input type= 'text' id='hiddenfi' value='This Email-ID or Contact is already Registered. Try Another.'>");
      }
      else{
    	  enableButton = true;
      }
      
      request.setAttribute("enableButton", enableButton); 
      
      pstmt2.close();
      con.close();
      
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Verify | Admission Form</title>
	  <link rel="stylesheet" href="css/AdmissionVerify.css">
	  	<script>
			var enabled = <%= enableButton %>; 
			document.querySelector("input[type='submit']").disabled = !enabled;
		</script>
</head>
<body>
	 <div class="container">
  		<h1>ADMISSION FORM</h1>
			<div class="form-wrapper">
				  <form action="AdmissionLast.jsp" method="post">
				    <label class="recog">Personal Information</label>
				    <div class="form-item">
				      <label for="firstname">First Name:</label>
				      <span id="firstname"><%= firstname %></span>
				    </div>
				    <div class="form-item">
				      <label for="lastname">Last Name:</label>
				      <span id="lastname"><%= lastname %></span>
				    </div>
				    <div class="form-item">
				      <label for="gender">Gender:</label>
				      <span id="gender"><%= gender %></span>
				    </div>
				    <div class="form-item">
				      <label for="dob">Date of Birth:</label>
				      <span id="dob"><%= dob %></span>
				    </div>
				    <div class="form-item">
				      <label for="email">Email:</label>
				      <span id="email"><%= email %></span>
				    </div>
				    <div class="form-item">
				      <label for="contact">Contact No:</label>
				      <span id="contact"><%= contact %></span>
				    </div>
				    <div class="form-item">
				      <label for="address">Address:</label>
				      <span id="address"><%= address %></span>
				    </div>
				    <hr>
				    <label class="recog">Guardian's Information</label>
				    <div class="form-item">
				      <label for="fathername">Father's Name:</label>
				      <span id="fathername"><%= fathername %></span>
				    </div>
				    <div class="form-item">
				      <label for="mothername">Mother's Name:</label>
				      <span id="mothername"><%= mothername %></span>
				    </div>
				    <div class="form-item">
				      <label for="guardiancontact">Contact No:</label>
				      <span id="guardiancontact"><%= guardiancontact %></span>
				    </div>
				    <hr>
				    <label class="recog">Educational Qualifications</label>
				    <div class="form-item">
				      <label for="tenth">10th Percentage:</label>
				      <span id="tenth"><%= tenth %></span>
				    </div>
				    <div class="form-item">
				      <label for="twelth">12th Percentage:</label>
				      <span id="twelth"><%= twelth %></span>
				    </div>
				    <div class="form-item">
				      <label for="graduation">If, Graduated:</label>
				      <span id="graduation"><%= graduation %></span>
				    </div>
				    <hr>
				    <div class="form-item">
				      <label for="course">Choose Course:</label>
				      <span id="course"><%= course %></span>
				    </div> 
				    <div>
				      <input type="hidden" name="hidden_firstname" value="<%= firstname %>">
					  <input type="hidden" name="hidden_lastname" value="<%= lastname %>">
					  <input type="hidden" name="hidden_gender" value="<%= gender %>">
					  <input type="hidden" name="hidden_dob" value="<%= dob %>">
					  <input type="hidden" name="hidden_email" value="<%= email %>">
					  <input type="hidden" name="hidden_contact" value="<%= contact %>">
					  <input type="hidden" name="hidden_address" value="<%= address %>">
					  <input type="hidden" name="hidden_fathername" value="<%= fathername %>">
					  <input type="hidden" name="hidden_mothername" value="<%= mothername %>">
					  <input type="hidden" name="hidden_guardiancontact" value="<%= guardiancontact %>">
					  <input type="hidden" name="hidden_tenth" value="<%= tenth %>">
					  <input type="hidden" name="hidden_twelth" value="<%= twelth %>">
					  <input type="hidden" name="hidden_graduation" value="<%= graduation %>">
					  <input type="hidden" name="hidden_course" value="<%= course %>">
				    </div>
				    <hr>
				    <div id="verify">
				    	<input type="submit" value="Submit" ${enableButton ? '' : 'disabled'}>
				    </div>
				    
				  </form>
    			  	<a href="AdmissionForm.jsp"><button id="backbut">Back</button></a>
		</div>
	</div>
</body>
</html>