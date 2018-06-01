<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.add {
	background-color: rgb(96, 201, 255);
	color: rgb(255, 255, 255);
}

.formCategory{
	font-weight: bold;
}

.tag{
	border-radius: 40%;
}

.picFile{
	width: 100%;
}

.tab-head{
	height: 150px;
}

.srfunction{
	text-align: left;
}

.noresize {
  resize: none; /* 사용자 임의 변경 불가 */
}

.map{
	display: view;
}
</style>
<script>
$(document).ready(function(){
	console.log('${srvoList}')
	console.log('${srFunction}');
	var data = '${srFunction}'.split(', ');
	console.log(data[0]);
	console.log('data[0].replace: '+data[0].replace('[',''));
	console.log('data[length-1].replace: '+data[data.length-1].replace(']',''));
	
	data[0] = data[0].replace('[','');
	data[data.length-1] = data[data.length-1].replace(']','');
	
	console.log(data);
	for(var i=1; i<13; i++){
		for(var j=0; j<data.length; j++){
			if(data[j] == $('#function'+i).val()){
				$('#function'+i).attr("checked", "checked");
				console.log('data: '+data[j]+', function'+i+': '+$('#function'+i).val());
			}
		}
	}
});//ready
</script>
<br><br><br><br>
<div class="row">
	<div class="col-sm-11">
		<h3>STUD-IT 스터디룸 수정</h3>
	</div>
</div>
	<div class="col-sm-1" ></div>
	<div style="padding-left:0px;">
<form action="${pageContext.request.contextPath }/studyroom/updateStudyRoom" method="post" class="form-horizontal" role="form" enctype="multipart/form-data">
	<c:forEach items="${srvoList }" var="srvo">
		<c:if test="${srvo.studyRoomNo eq srno }">
			<div id="step3"><br><br>
		    	 <div class="form-group">
			          	 <label for="studyRoomName" class="col-sm-2 control-label formCategory">스터디룸 명</label>
			             <div class="col-sm-7">
			                 <input type="text" id="studyRoomName" name="name" required="required" placeholder="무궁화, 나팔꽃" value="${srvo.name }" class = "form-control">
			             </div>
			         </div>
		                
		          <div class="form-group">
		              <label for="capacity" class="col-sm-2 control-label formCategory">수용 인원</label>
		              <div class="capacityPriceForm text-left">
		              		<div class="col-sm-1">
		                		  <input type="number" min="1" id="capacity" name="capacity" required="required" placeholder="6" value="${srvo.capacity }" class = "form-control">
		              		</div>
		              		<label for="" class="col-sm-1 control-label" style="text-align:left; padding-left:0px;">명</label>
		              		<label for="price" class="col-sm-3 control-label formCategory">이용 가격</label>
		              		<div class="col-sm-2">
		                  		  <input type="number" id="price" min="1" name="price" required="required" placeholder="시간당 가격" value="${srvo.price }" class = "form-control">
		                  	</div>
		                 	<label for="" class="col-sm-1 control-label" style="text-align:left; padding-left:0px;">원/시간</label>
		              </div>
		          </div>
		          
		           <div class="form-group text-left">
		              <label for="" class="col-sm-2 control-label formCategory">제공 기능</label>
		              <div class="col-sm-8 srfunction">
		              	<table style="width: 100%;">
		              		<tbody>
		              			<tr>
		              				<td style="width: 180px;">
		              					<input type="checkbox" id="function1" name="studyRoomFunction" value="에어컨">
				              			<label for="function1" class=" control-label">에어컨</label>
		              				</td>
		              				<td style="width: 180px;">
		              					<input type="checkbox" id="function2" name="studyRoomFunction" value="복사/인쇄기">
				              			<label for="function2" class=" control-label">복사/인쇄기</label>
		              				</td>
		              				<td style="width: 120px;">
		              					<input type="checkbox" id="function3" name="studyRoomFunction" value="와이파이">
				              			<label for="function3" class="control-label">와이파이</label>
		              				</td>
		              				<td>
		              					<input type="checkbox" id="function4" name="studyRoomFunction" value="멀티탭/콘센트">
				              			<label for="function4" class="control-label">멀티탭/콘센트</label>
		              				</td>
		              			</tr>
		              			<tr>
		              				<td>
		              					<input type="checkbox" id="function5" name="studyRoomFunction" value="빔프로젝트">
				              			<label for="function5" class="control-label">빔프로젝트</label>
				              		</td>
		              				<td>
		              					<input type="checkbox" id="function6" name="studyRoomFunction" value="화이트보드">
				              			<label for="function6" class="control-label">화이트보드</label>
		              				</td>
		              				<td>
		              					<input type="checkbox" id="function7" name="studyRoomFunction" value="충전기">
				              			<label for="function7" class="control-label">충전기</label>
		              				</td>
		              				<td>
		              					<input type="checkbox" id="function8" name="studyRoomFunction" value="마이크">
				              			<label for="function8" class="control-label">마이크</label>
		              				</td>
		              			</tr>
		              			<tr>
		              				<td>
		              					<input type="checkbox" id="function9" name="studyRoomFunction" value="카페 및 레스토랑">
				              			<label for="function9" class="control-label">카페 및 레스토랑</label>
		              				</td>
		              				<td>
		              					<input type="checkbox" id="function10" name="studyRoomFunction" value="반려동물 동반가능">
				              			<label for="function10" class="control-label">반려동물 동반가능</label>
		              				</td>
		              				<td>
		              					<input type="checkbox" id="function11" name="studyRoomFunction" value="흡연실">
				              			<label for="function11" class="control-label">흡연실</label>
		              				</td>
		              				<td>
		              					<input type="checkbox" id="function12" name="studyRoomFunction" value="주차공간">
				              			<label for="function12" class="control-label">주차공간</label>
		              				</td>
		              			</tr>     			
		              		</tbody>
		              	</table>
		              </div>
		          </div>
		          
		          <div class="form-group">
		              <label for="content" class="col-sm-2 control-label formCategory">스터디룸 소개</label>
		              <div class="col-sm-7 text-left">
		                  <textarea id="content" name="content" class="noresize" rows="6" cols="72" maxlength="179" required="required" placeholder="스터디룸에 대해 소개해주세요. (ex_이용인원, 목적 등)">${srvo.content }</textarea>
		              </div>
		          </div>
		          
		          <div class="form-group">
		              <label for="studyRoomPicFile" class="col-sm-2 control-label formCategory">스터디룸 사진</label>
		              <div class="col-sm-7 studyRoomPicDiv">
		                  <input type="file" id="studyRoomPicFile" name="studyRoomPicFile" placeholder="대표 사진" class = "form-control studyRoomPicFile">
		              </div>
		          </div>
		          
		          <div class="form-group">
		          	 <div class="col-sm-7 col-sm-offset-2">
		          	 <input type="hidden" name="studyRoomNo" value="${srno }">
		          	 <input type="hidden" name="memberEmail" value="${memberVO.memberEmail}">
		          	 <input type="hidden" name="companyNo" value="${srvo.companyVO.companyNo}">
		                        <button type="submit" class="btn btn-primary btn-block" onclick="return registerFlag()">수정하기</button>
		             </div>
		          </div>
		    </div>
	    </c:if>
    </c:forEach>
     </form>
	</div>
