<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.min.css">
</head>
<body>

<div class="row">
	<img  src="resources/assets/img/error/400.png" width="100%" height="600px" onclick="go()" data-toggle="tooltip" title="클릭하면 메인으로 이동합니다.">
</div>
</body>

<script type="text/javascript">
	function go(){
		location.href="${pageContext.request.contextPath}/"
	}
</script>
</html>