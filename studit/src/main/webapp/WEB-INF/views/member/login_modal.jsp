<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<div class="modal fade" id="loginModal"  tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
	<div class="modal-dialog ">
	 <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="padding:25px 40px;">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4>Login</h4>
        </div>
        <div class="modal-body" style="padding:40px 50px;">
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
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal"> Cancel</button>
          <p>Not a member? <a href="#">Sign Up</a></p>
          <p>Forgot <a href="${pageContext.request.contextPath }/member/findPasswordView">Password?</a></p>
        </div>
      </div>
		
	</div> 
</div> 