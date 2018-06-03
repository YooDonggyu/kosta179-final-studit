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
	                <div class="form-group">
	                    	<span id="name"> </span><br>
	                    	<span id="roomName"></span><br>
	                    	<span id="useDate"></span>
	                 		<span id="startTime"></span>:00~
	                 		<span id="endTime"></span>:50<br>
	                 		<select id="state" name="state">
	                 			<option>예약대기</option>
	                 			<option>예약완료</option>
	                 			<option>예약불가</option>
	                 			<option>예약취소</option>
	                 		</select>
	                </div>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
					<input type="hidden" id="studyRoomConditionNo" name="studyRoomConditionNo">
	                <input type="button" id="updateBtn" class="btn btn-primary" value="수정">
			</div>
			 <div class="modal-footer">

			</div>
		</div> 
	</div> 
</div> 