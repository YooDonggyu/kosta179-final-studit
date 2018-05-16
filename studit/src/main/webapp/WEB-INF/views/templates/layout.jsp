<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- tiles framework 선언부 -->
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
	<!-- meta -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    
    <!-- link -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/assets/ico/favicon.png">
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/font-awesome.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/main.css" rel="stylesheet">
    
	<!-- title -->
	<title><tiles:insertAttribute name="title" ignore="true"/></title>
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
	
	<!-- MODAL FOR CONTACT -->
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h4 class="modal-title" id="myModalLabel">contact us</h4>
	      </div>
	      <div class="modal-body">
		        <div class="row centered">
		        	<p>We are available 24/7, so don't hesitate to contact us.</p>
		        	<p>
		        		Somestreet Ave, 987<br/>
						London, UK.<br/>
						+44 8948-4343<br/>
						hi@blacktie.co
		        	</p>
		        	<div id="mapwrap">
		<iframe height="300" width="100%" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://www.google.es/maps?t=m&amp;ie=UTF8&amp;ll=52.752693,22.791016&amp;spn=67.34552,156.972656&amp;z=2&amp;output=embed"></iframe>
					</div>	
		        </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">Save & Go</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->

    <!-- script -->
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.min.js"></script>
    
</body>

</html>










