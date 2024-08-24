<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Student Management System</title>
<link rel="stylesheet" type="text/css" href="css/HomePage.css">
</head>
<body>
	<jsp:include page="HomeNavBar.jsp" />
	<div class="homepage">
		<div id="image-container">
			<button id="prev">Prev</button>
			<img id="college-img">
			<button id="next">Next</button>
		</div>
	</div>

	<script>
	const images = [
		  'images/college1.jpg',
		  'images/college2.jpg', 
		  'images/college3.jpg',
		  'images/college4.jpg',
		  'images/college5.jpg'
		];

		let currentIndex = 0;
		
		document.addEventListener('DOMContentLoaded', () => {
			  document.getElementById('college-img').src = images[1]; 
			});

		document.getElementById('next').addEventListener('click', () => {
		  currentIndex++;
		  if(currentIndex >= images.length) {
		    currentIndex = 0;
		  }
		  document.getElementById('college-img').src = images[currentIndex];
		});

		document.getElementById('prev').addEventListener('click', () => {
		  currentIndex--;
		  if(currentIndex < 0) {
		    currentIndex = images.length - 1; 
		  }
		  document.getElementById('college-img').src = images[currentIndex];
		});
	</script>
</body>
</html>