<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	// 작성: 유동규
	alert("로그인이 필요합니다.")
	//location.href="${pageContext.request.contextPath}/" 
</script>
<div class="container">
<div class="row">
<div class="col-sm-3"></div>
    <!-- Where all the magic happens -->
	<!-- LOGIN FORM -->
	<div class="text-center col-sm-6" style="padding:50px 0">
		<div class="logo text-left"><h4>Login</h4><hr></div>
		<!-- Main Form -->
		<div class="login-form-1">
			<form role="form" action="${pageContext.request.contextPath }/member/login" method="post"  id="loginForm" autocomplete="off">
				<div class="login-form-main-message"></div>
				<div class="main-login-form">
					<div class="login-group">
						<div class="form-group text-left">
							<label for="loginEmail" >Email</label>
							<input type="email" class="form-control" name="loginEmail" placeholder="studit@studit.com">
						</div>
						<div class="form-group text-left">
							<label for="loginPassword" >Password</label><br>
							<input type="password" class="form-control" name="loginPassword" placeholder="Enter password">
						</div>
						<div class="form-group login-group-checkbox">
							<input type="checkbox" id="lg_remember" name="lg_remember">
							<label for="lg_remember">remember</label>
						</div>
					</div>
					<button type="submit" class="btn btn-success btn-block"> Login</button>
				</div><br><hr>
				<div class="etc-login-form text-right">
					<p>forgot your password? <a href="#">click here</a></p>
					<p>new user? <a href="${pageContext.request.contextPath}/register_member">create new account</a></p>
				</div>
			</form>
		</div>
		<!-- end:Main Form -->
	</div>
	</div>
	</div>


