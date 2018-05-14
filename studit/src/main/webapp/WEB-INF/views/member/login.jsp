<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>STUD-IT LOGIN</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/studit/css/login.css">
<title>Insert title here</title>
</head>

<body>
	<div class="lowin">
		<div class="lowin-brand">
			<img src="${pageContext.request.contextPath}/resources/assets/studit/images/login.jpg" alt="logo">
		</div>
		<div class="lowin-wrapper">
			<div class="lowin-box lowin-login">
				<div class="lowin-box-inner">
					<form action="login" method="post">
					.	<p>STUD-IT LOGIN</p>
						<div class="lowin-group">
							<label>이메일 <a href="#" class="login-back-link"></a></label>
							<input type="email" autocomplete="email" name="memberEmail" class="lowin-input">
						</div>
						<div class="lowin-group password-group">
							<label>비밀번호<a href="#" class="forgot-link">비밀번호 찾기</a></label>
							<input type="password" name="password" autocomplete="current-password" class="lowin-input">
						</div>
						<button class="lowin-btn login-btn">
							로그인
						</button>

						<div class="text-foot">
							계정이 없으세요? <a href="" class="register-link">회원가입</a>
						</div>
					</form>
				</div>
			</div>
		
		<!-- 	<div class="lowin-box lowin-register">
				<div class="lowin-box-inner">
					<form>
						<p>Let's create your account</p>
						<div class="lowin-group">
							<label>Name</label>
							<input type="text" name="name" autocomplete="name" class="lowin-input">
						</div>
						<div class="lowin-group">
							<label>Email</label>
							<input type="email" autocomplete="email" name="email" class="lowin-input">
						</div>
						<div class="lowin-group">
							<label>Password</label>
							<input type="password" name="password" autocomplete="current-password" class="lowin-input">
						</div>
						<button class="lowin-btn">
							Sign Up
						</button>

						<div class="text-foot">
							Already have an account? <a href="" class="login-link">Login</a>
						</div>
					</form>
				</div>
			</div> -->
		</div>
	</div>

</body>
</html>