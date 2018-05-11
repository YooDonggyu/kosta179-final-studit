<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- tiles framework 선언부 -->
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <!-- title이 null인 경우는 무시된다 -->
  <title>
  		<tiles:insertAttribute name="title" ignore="true"/>
  </title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="generator" content="Mobirise v4.7.2, mobirise.com">
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1">
	<link rel="shortcut icon" href="assets/images/logo2.png" type="image/x-icon">
	<meta name="description" content="">
	<%-- <base href="${pageContext.request.contextPath }"/> --%>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/web/assets/mobirise-icons/mobirise-icons.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/tether/tether.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/soundcloud-plugin/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/bootstrap/css/bootstrap-grid.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/bootstrap/css/bootstrap-reboot.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/socicon/css/styles.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/datatables/data-tables.bootstrap4.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/dropdown/css/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/theme/css/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/mobirise/css/mbr-additional.css" type="text/css">
	
</head>
<body>
	<div id="header">
		<tiles:insertAttribute name="header"/>
	</div>
	
	<div class="container-fluid text-center">    
    	 <div class="row content">
			<div id="main" class="col-12 text-center">
				<tiles:insertAttribute name="main"/>
			</div>
		</div>
	</div>
	
	<div id="footer">
		<tiles:insertAttribute name="footer"/>
	</div>
</body>
</html>










