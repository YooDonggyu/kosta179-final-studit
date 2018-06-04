<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.formCategory{
	font-weight: bold;
	width: 150px;
	/* text-align: left; */
}
.updateBtn{
	width: 300px;
	height: 50px;
}
.table>tbody>tr>td{
line-height: 2;
vertical-align: middle;
}
.table>thead>tr>th{
	text-align: center;
}
.table>tbody>tr>td>img{
height: 300px;
width: 300px;
}
.material-icons { 
font-size: 24px; 
vertical-align: sub;
}
</style>
<script>
	console.log('srfunction: ${srFunction }');
</script>
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
						    				<c:set var="root" value="1"/>
						    				<%int a=0; %>
							    			<c:forEach items="${srFunction }" var="func" varStatus="info">
							    				<c:if test="${func.SRNO eq srno }">
							    					<%if(a>0){ %>
							    						&emsp;
							    					<%} %>
							    					<%if(a==4 || a==8){ %>
							    						<br><br>
							    					<%} %>
							    					<c:if test="${func.NAME eq '에어컨'}">
							    						<i class="material-icons">toys</i> 에어컨
							    						<%a++; %>
							    					</c:if>
							    					<c:if test="${func.NAME eq '카페 및 레스토랑'}">
							    						<i class="material-icons">local_cafe</i> 카페 및 레스토랑
							    						<%a++; %>
							    					</c:if>
							    					<c:if test="${func.NAME eq '와이파이'}">
							    						<i class="material-icons">wifi</i> 와이파이
							    						<%a++; %>
							    					</c:if>
							    					<c:if test="${func.NAME eq '복사/인쇄기'}">
							    						<i class="material-icons">print</i> 복사/인쇄기
							    						<%a++; %>
							    					</c:if>
							    					<c:if test="${func.NAME eq '반려동물 동반가능'}">
							    						<i class="material-icons">pets</i> 반려동물 동반가능
							    						<%a++; %>
							    					</c:if>
							    					<c:if test="${func.NAME eq '마이크'}">
							    						<i class="material-icons">mic</i> 마이크
							    						<%a++; %>
							    					</c:if>
							    					<c:if test="${func.NAME eq '충전기'}">
							    						<i class="material-icons">battery_charging_full</i> 충전기
							    						<%a++; %>
							    					</c:if>
							    					<c:if test="${func.NAME eq '멀티탭/콘센트'}">
							    						<i class="material-icons">power</i> 멀티탭/콘센트
							    						<%a++; %>
							    					</c:if>
							    					<c:if test="${func.NAME eq '흡연실'}">
							    						<i class="material-icons">smoking_rooms</i> 흡연실
							    						<%a++; %>
							    					</c:if>
							    					<c:if test="${func.NAME eq '화이트보드'}">
							    						<i class="material-icons">border_color</i> 화이트보드
							    						<%a++; %>
							    					</c:if>
							    					<c:if test="${func.NAME eq '빔프로젝트'}">
							    						<i class="material-icons">videocam</i> 빔프로젝트
							    						<%a++; %>
							    					</c:if>
							    					<c:if test="${func.NAME eq '주차공간'}">
							    						<i class="material-icons">local_parking</i> 주차공간
							    						<%a++; %>
							    					</c:if>
							    				</c:if>
							    			</c:forEach>
						    			</td>
						    		</tr>
						    		<tr>
						    			<td class="formCategory" style="height: 350px;">사진</td><td colspan="3">
						    				<c:forEach items="${srPicPath }" var="srPic">
						    					<c:if test="${srPic.SRNO eq srno }">
						    						<img id="picView" src="${pageContext.request.contextPath}/resources/upload/${srPic.PATH }">
						    					</c:if>
						    				</c:forEach>
						    			</td>
						    		</tr>
						    		<tr>
						    			<td colspan="4" style="height: 100px;">
						    				<div class="updateBtnDiv">
						    				<form method="post" action="${pageContext.request.contextPath }/company/updateStudyroomForm">
						    					<input type="hidden" name="studyRoomNo" value="${srno}">
									    		<input type="submit" id="updateBtn" value="수정하기" class="btn btn-danger updateBtn">
									    	</form>
									    	</div>
						    			</td>
						    		</tr>
				    			</tbody>
				    	</table>
					  </c:if>
				  </c:forEach>
			    	<br>
		    	</div>
	  		</div>
		</div>
	</div>
</section>