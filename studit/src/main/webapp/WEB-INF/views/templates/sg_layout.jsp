<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<title><tiles:insertAttribute name="title" ignore="true" /></title> 
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- favicon -->
<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/assets/img/favicon.ico">
<!-- Bootstrap CSS-->
<link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dashboard/1-1/vendor/bootstrap/css/bootstrap.min.css">
<!-- Custom icon font-->
<link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dashboard/1-1/css/fontastic.css">
<!-- Google fonts - Roboto -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700">
<!-- theme stylesheet-->
<link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dashboard/1-1/css/style.default.css" id="theme-stylesheet">
<!-- Javascript files-->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script src="https://d19m59y37dris4.cloudfront.net/dashboard/1-1/js/charts-home.js"></script>
</head>

<body>
<div id="left">
	<tiles:insertAttribute name="left"/>
</div>

<div class="page home-page">   
   	 
	<div id="main">
		<tiles:insertAttribute name="main"/>
	</div>
	
	<div id="footer">
		<tiles:insertAttribute name="footer"/>
	</div>
	
</div>
</body>

</html>