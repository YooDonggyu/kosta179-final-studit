<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<div class="modal fade" id="updateRoomConditionModal"  tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
					<span class="sr-only">닫 기</span>
				</button>
				<h4 class="modal-title">예약 정보</h4>
			</div>
			<!-- Modal Body -->
			<div class="modal-body">
			    <form role="form" action="${pageContext.request.contextPath }/company/updateStudyRoomCondition" method="post"  id="updateRoomConditionForm" autocomplete="off">
	                <div class="form-group">
	                    	<span id="name"> </span><br>
	                    	<span id="roomName"></span><br>
	                    	<input type="date" id="useDate" name="useDate">
	                 		<input type="time" id="startTime" name="startTime">-
	                 		<input type="time" id="endTime" name="endTime"><br>
	                 		<select id="state" name="state">
	                 			<option>예약대기</option>
	                 			<option>예약완료</option>
	                 			<option>예약불가</option>
	                 		</select>
	                </div>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
					<input type="hidden" id="studyRoomConditionNo" name="studyRoomConditionNo">
	                <input type="submit" id="updateBtn" class="btn btn-primary" value="수정">
	             </form>
			</div>
			 <div class="modal-footer">

			</div>
		</div> 
	</div> 
</div> 