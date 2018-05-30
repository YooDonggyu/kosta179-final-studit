<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.formCategory{
	font-weight: bold;
	width: 150px;
	/* text-align: left; */
}
.table>tbody>tr>td{
line-height: 2;
}
.table>thead>tr>th{
	text-align: center;
}
.material-icons { font-size: 36px; }
</style>
<section>
	<div class="col-sm-10" style="padding-left:0px;">
		<div class="container col-sm-12 col-sm-offset-1">
	  		<div class="tab-head">
				  <h2>STUD-IT 스터디룸 관리</h2>
				  <p>스터디룸 정보를 수정할 수 있습니다.</p><br>
				  <div>
				  <c:forEach items="${srvoList }" var="srvo">
					  <c:if test="${srvo.studyRoomNo eq srno }">
			    		<table class="table table-bordered">
			    			<thead>
			    				<tr>
			    					<th colspan="4" class="danger">${srvo.name }</th>
			    				</tr>
			    			</thead>
			    				<tbody>
						    		<tr>
						    			<td class="formCategory">정원</td><td>${srvo.capacity}</td><td class="formCategory">이용 금액</td><td>${srvo.price }</td>
						    		</tr>
						    		<tr>
						    			<td class="formCategory">소개</td><td colspan="3">${srvo.content }</td>
						    		</tr>
						    		<tr>
						    			<td class="formCategory">제공 기능</td>
						    			<td colspan="3">
						    			<i class="material-icons">toys</i>에어컨
						    			<i class="material-icons">find_in_page</i>주소지등록
						    			<i class="material-icons">local_cafe</i>카페및레스토랑
						    			<i class="material-icons">wifi</i>와이파이
						    			<i class="material-icons">print</i>복사인쇄기
						    			<i class="material-icons">pets</i>반려동물 동반가능
						    			<i class="material-icons">mic</i>마이크
						    			<i class="material-icons">battery_charging_full</i>충전기
						    			<i class="material-icons">power</i>멀티탭/콘센트
						    			<i class="material-icons">smoking_rooms</i>흡연실
						    			<i class="material-icons">border_color</i>화이트보드
						    			<i class="material-icons">videocam</i>빔프로젝터
						    			<i class="material-icons">local_parking</i>주차공간
						    			
						    			</td>
						    		</tr>
						    		<tr>
						    			<td class="formCategory">사진</td><td colspan="3">사진 경로</td>
						    		</tr>
				    			</tbody>
				    	</table>
					  </c:if>
				  </c:forEach>
			    	<div class="text-right">
			    		<span class="label label-danger">수정하기</span>
			    	</div>
			    	<br>
		    	</div>
	  		</div>
		</div>
	</div>
</section>