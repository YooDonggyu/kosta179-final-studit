<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- tiles framework 선언부 -->
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
  <title><tiles:insertAttribute name="title" ignore="true" /></title> 
  
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="all,follow">
    <!-- Bootstrap-->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/bootstrap.min.css">
    <!-- Google fonts - Open Sans-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,300,700,800,400italic">
    <!-- Stroke 7 font by Pixeden (http://www.pixeden.com/icon-fonts/stroke-7-icon-font-set)-->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/pe-icon-7-stroke.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/helper.css">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/style.default.css" id="theme-stylesheet">
    <!-- owl carousel-->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/owl.carousel.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/owl.theme.css">
    <!-- plugins-->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/simpletextrotator">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/custom.css">
    <!-- Favicon-->
    
    <!-- Javascript files-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/bootstrap.min.js"> </script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/jquery.cookie.js"> </script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/ekko-lightbox.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/jquery.simple-text-rotator.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/jquery.scrollTo.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/front.js"></script>
    <script>
      (function(b,o,i,l,e,r){b.GoogleAnalyticsObject=l;b[l]||(b[l]=
      function(){(b[l].q=b[l].q||[]).push(arguments)});b[l].l=+new Date;
      e=o.createElement(i);r=o.getElementsByTagName(i)[0];
      e.src='//www.google-analytics.com/analytics.js';
      r.parentNode.insertBefore(e,r)}(window,document,'script','ga'));
      ga('create','UA-XXXXX-X');ga('send','pageview');
    </script>
    
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    
</head>

<body>
	<div id="header">
		<tiles:insertAttribute name="header"/>
	</div>
	
	<div class="container-fluid text-center">    
    	 <div class="row content">
			<div id="main" >
				<tiles:insertAttribute name="main"/>
			</div>
		</div>
	</div>
	
	<div id="footer">
		<tiles:insertAttribute name="footer"/>
	</div>
</body>

</html>










