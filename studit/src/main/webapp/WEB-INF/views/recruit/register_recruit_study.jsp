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
 
 
 <!-- 
 	스터디 신청을 위해 간단히 자기소개하는 MODAL
 	@author 이승수
  -->
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
	                    <input type="text" name="context" id="context" class="form-control" placeholder="자기소개" required="required">
	                    <input type="hidden" name="memberEmail" id="memberEmail" value="${memberVO.memberEmail}">
	                    <input type="hidden" name="recruitPostNo" id="recruitPostNo" value="${recruitInfo.detail.recruitPostNo}">
	                </div>
	                <input type="submit" id="btn-registerRcruitStudy" class="btn btn-custom btn-lg btn-block" value="신청하기">
	             </form>
			</div>
		</div> 
	</div> 
</div> 

<!-- 
	삭제할 때 동작하는 MODAL
	 POST 방식으로 controller(/recruit/updateRecruitPostInfoByRecruitNo)로 이동
	false = cancel
	@author 유동규
 -->
<div class="modal fade" id="deleteConfrimModal"  tabindex="-1" role="dialog">
	<div class="modal-dialog">
	  <div class="modal-content">
	    <div class="modal-header">
	      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	      <h4 class="modal-title">삭제</h4>
	    </div>
	    <div class="modal-body">
	      <p>
	      	한 번 삭제하면 복구할 수 없습니다.
	      	그래도 삭제하시겠습니까?
	      </p>
	    </div>
	    <div class="modal-footer">
	    	<form action="${pageContext.request.contextPath}/recruit/deleteRecruitPostByRecruitNo" method="post">
	    		<input type="hidden" value="${recruitInfo.detail.recruitPostNo}" name="recruitNo" >
	    		<input type="submit" class="btn btn-primary" value="예, 삭제하겠습니다.">
	       	<button type="button" class="btn btn-default" data-dismiss="modal">아니요</button>
	      </form>
	    </div>
	  </div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
 

