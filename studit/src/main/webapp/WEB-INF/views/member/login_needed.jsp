<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
	// 작성: 유동규
	alert("로그인이 필요합니다.")
	//location.href="${pageContext.request.contextPath}/" 
</script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

<!-- All the files that are required -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link href='http://fonts.googleapis.com/css?family=Varela+Round' rel='stylesheet' type='text/css'>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.13.1/jquery.validate.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<title>Insert title here</title>
</head>
<body>
<div class="container">
<div class="row">
	<div class="col-4"></div>
</div>
<div class="row">
<div class="col-4"></div>
    <!-- Where all the magic happens -->
	<!-- LOGIN FORM -->
	<div class="text-center col-4" style="padding:50px 0">
		<div class="logo">login</div>
		<!-- Main Form -->
		<div class="login-form-1">
			<form role="form" action="${pageContext.request.contextPath }/member/login" method="post"  id="loginForm" autocomplete="off">
				<div class="login-form-main-message"></div>
				<div class="main-login-form">
					<div class="login-group">
						<div class="form-group">
							<label for="lg_username" class="sr-only">Email</label>
							<input type="email" class="form-control" name="loginEmail" placeholder="studit@studit.com">
						</div>
						<div class="form-group">
							<label for="lg_password" class="sr-only">Password</label>
							<input type="password" class="form-control" name="loginPassword" placeholder="Enter password">
						</div>
						<div class="form-group login-group-checkbox">
							<input type="checkbox" id="lg_remember" name="lg_remember">
							<label for="lg_remember">remember</label>
						</div>
					</div>
					<button type="submit" class="btn btn-success btn-block"> Login</button>
				</div>
				<div class="etc-login-form">
					<p>forgot your password? <a href="#">click here</a></p>
					<p>new user? <a href="#">create new account</a></p>
				</div>
			</form>
		</div>
		<!-- end:Main Form -->
	</div>
	<div class="col-4"></div>
	</div>
	</div>
</body>
</html>







<%-- 
<section>
<div class="col-sm-2"></div>
	<form role="form" action="${pageContext.request.contextPath }/member/login" method="post"  id="loginForm" autocomplete="off">
		<div class="form-group">
			<label for="usrname"> Email</label>
			<input type="email" class="form-control" name="loginEmail" placeholder="studit@studit.com">
		</div>
		<div class="form-group">
			<label for="psw"> Password</label>
			<input type="password" class="form-control" name="loginPassword" placeholder="Enter password">
		</div>
		<div class="checkbox">
			<label><input type="checkbox" value="" checked>Remember me</label>
		</div>
		<button type="submit" class="btn btn-success btn-block"> Login</button>
	</form>
</section>
<div class="col-sm-2"></div>
<section>

</section> --%>