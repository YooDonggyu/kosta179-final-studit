<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <head>
<script>
$(document).ready(function(){
    $('#context').keyup(function(){
        if ($(this).val().length > 30) {
            alert('글자수가 초과 되었습니다. 30자 이내로 작성해 주세요.');
            $(this).val("");
        }
    });
});
</script>


 </head>
    
<div class="modal fade" id="recruitStudyModal"  tabindex="-1" role="dialog" aria-labelledby="recruitStudyModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
					<span class="sr-only">닫 기</span>
				</button>
				<h4 class="modal-title">신청하기</h4>
			</div>
			<!-- Modal Body -->
			<div class="modal-body">
			    <form role="form" action="${pageContext.request.contextPath }/recruit/registerRcruitStudy" method="post"  id="recruitForm" autocomplete="off">
	                <div class="form-group">
	                    <label for="context" class="sr-only">자기소개</label>
	                    <input type="text" name="context" id="context" class="form-control" placeholder="자기소개">
	                    <input type="hidden" name="memberEmail" id="memberEmail" value="${memberVO.memberEmail}">
	                    <input type="hidden" name="recruitPostNo" id="recruitPostNo" value="1">
	                </div>
	                <input type="submit" id="btn-registerRcruitStudy" class="btn btn-custom btn-lg btn-block" value="신청하기">
	             </form>
			</div>
			<!-- <div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-custom">확인</button>
			</div> -->
		</div> 
	</div> 
</div> 