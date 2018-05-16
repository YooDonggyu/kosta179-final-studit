<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<div class="modal fade" id="loginModal"  tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
					<span class="sr-only">닫 기</span>
				</button>
				<h4 class="modal-title">로그인</h4>
			</div>
			<!-- Modal Body -->
			<div class="modal-body">
			    <form role="form" action="${pageContext.request.contextPath }/member/login" method="post"  id="loginForm" autocomplete="off">
	                <div class="form-group">
	                    <label for="email" class="sr-only">이메일</label>
	                    <input type="email" name="loginEmail" id="loginEmail" class="form-control" placeholder="studit@studit.com">
	                </div>
	                <div class="form-group">
	                    <label for="key" class="sr-only">비밀번호</label>
	                    <input type="password" name="loginPassword" id="loginPassword" class="form-control" placeholder="Password">
	                </div>

	                <input type="submit" id="btn-login" class="btn btn-custom btn-lg btn-block" value="Log in">
	             </form>
			</div>
			<!-- <div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-custom">확인</button>
			</div> -->
		</div> 
	</div> 
</div> 