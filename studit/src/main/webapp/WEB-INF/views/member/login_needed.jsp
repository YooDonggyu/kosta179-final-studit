
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	// 작성: 유동규
	alert("로그인이 필요합니다.")
	//location.href="${pageContext.request.contextPath}/" 
</script>
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

</section>