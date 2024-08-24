<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Courses</title>
<link rel="stylesheet" type="text/css" href="css/HomeCourses.css">
</head>
<body>
	<jsp:include page="HomeNavBar.jsp" />
	<div class="homepage">
		<div class="about">
		<h1>Courses</h1>
			<div class="courses-container">

				<%
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/smsproject", "root", "varsha");

				PreparedStatement stmt = conn.prepareStatement("SELECT * FROM courses");
				ResultSet rs = stmt.executeQuery();
				%>


				<%
				while (rs.next()) {
				%>

				<div class="course">
					<div class="details">
						<h3><%=rs.getString("course_name")%></h3>
						<div class="fee">
							Fee:
							<%=rs.getString("fee")%></div>
						<div class="duration">
							Duration:
							<%=rs.getString("duration")%></div>
						<div class="description">
							Description:
							<%=rs.getString("about")%></div>
					</div>
				</div>

				<%
				}

				rs.close();
				stmt.close();
				conn.close();
				%>

			</div>

		</div>
	</div>
</body>
</html>