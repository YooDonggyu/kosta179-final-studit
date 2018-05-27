<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<div class="modal fade" id="checkMemberModal"  tabindex="-1" role="dialog" aria-labelledby="checkMemberModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
					<span class="sr-only">닫 기</span>
				</button>
				<h4 class="modal-title">비밀번호 재확인</h4>
			</div>
			<!-- Modal Body -->
			<div class="modal-body">
			    <form role="form" action="${pageContext.request.contextPath }/member/checkMember" method="post"  id="checkMemberForm" autocomplete="off">
	                <div class="form-group">
	                    <label for="key" class="sr-only">비밀번호</label>
	                    <input type="password" name="checkPassword" id="checkPassword" class="form-control" placeholder="Password">
	                </div>
	                <input type="submit" id="btn-login2" class="btn btn-custom btn-lg btn-block" value="확인">
	             </form>
			</div>
			<!-- <div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-custom">확인</button>
			</div> -->
		</div> 
	</div> 
</div> 