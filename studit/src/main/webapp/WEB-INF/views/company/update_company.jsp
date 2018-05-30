<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.add {
	background-color: rgb(96, 201, 255);
	color: rgb(255, 255, 255);
}
.formCategory{
	font-weight: bold;
	width: 150px;
	/* text-align: left; */
}
.table>tbody>tr>td{
line-height: 2;
vertical-align: middle;
}
.table>tbody>tr>td>img{
height: 300px;
width: 300px;
}
</style>
<script>
var days = new Array('월', '화', '수', '목');
$(document).ready(function(){
	for(var i=0; i<days.length; i++){
		/* alert(days[i]+' '+$('#monBtn').val()); */
		if($('#monBtn').val() == days[i]){
			$('#monBtn').addClass('add');
		}else if($('#tueBtn').val() == days[i]){
			$('#tueBtn').addClass('add');
		}else if($('#wenBtn').val() == days[i]){
			$('#wenBtn').addClass('add');
		}else if($('#thuBtn').val() == days[i]){
			$('#thuBtn').addClass('add');
		}else if($('#friBtn').val() == days[i]){
			$('#friBtn').addClass('add');
		}else if($('#satBtn').val() == days[i]){
			$('#satBtn').addClass('add');
		}else if($('#sunBtn').val() == days[i]){
			$('#sunBtn').addClass('add');
		} 
	}
});
</script>
<section>
	<div class="col-sm-10" style="padding-left:0px;">
  <div class="container col-sm-12 col-sm-offset-1">
	  <div class="tab-head">
		  <h2>STUD-IT 업체 관리</h2>
		  <p>업체 관리페이지 입니다.</p>
	  </div>
  <ul class="nav nav-tabs">
  	<c:forEach items="${cvoList }" var="cvo" varStatus="info">
  		<c:choose>
	  		<c:when test="${info.count eq 1 }">
			    <li class="active"><a class="step" data-toggle="tab" href="#${cvo.name }">${cvo.name }</a></li>
	  		</c:when>
	  		<c:otherwise>
	   		 	<li><a data-toggle="tab" class="step" href="#${cvo.name}">${cvo.name }</a></li>
	   		 </c:otherwise>
   		 </c:choose>
  	</c:forEach>
  </ul>
	
  <div class="tab-content">
  	<c:forEach items="${cvoList }" var="cvo" varStatus="info">
  		<c:choose>
  			<c:when test="${info.count eq 1 }">
			    <div id="${cvo.name }" class="tab-pane fade in active"><br>
			    	<div class="hash-day">
			    		<div class="col-sm-4"><span class="label label-danger">#해시태그</span></div>
			    		<div class="col-sm-6">
				    		<div id="days" class="btn-group" role="group" aria-label="...">
								<input type="button" id="monBtn" class="btn btn-default" value="월" >
						        <input type="button" id="tueBtn" class="btn btn-default" value="화" >
						        <input type="button" id="wenBtn" class="btn btn-default" value="수" >
						        <input type="button" id="thuBtn" class="btn btn-default" value="목">
						        <input type="button" id="friBtn" class="btn btn-default" value="금" >
						        <input type="button" id="satBtn" class="btn btn-default" value="토" >
						        <input type="button" id="sunBtn" class="btn btn-default" value="일" >
						        <input type="hidden" id="day" name="day">
						        <span></span>
							</div>
			    		</div>
				    	<div class="text-right col-sm-2">
				    		<!-- <span class="label label-danger">수정하기</span> -->
				    		<input type="button" value="수정하기" class="btn btn-danger">
				    	</div>
			    	</div><br><br>
			    	<table class="table table-bordered">
			    		<tr>
			    			<td class="formCategory">업체명</td><td>${cvo.name}</td><td class="formCategory">사업자 등록 번호</td><td>${cvo.license }</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory">주소</td><td colspan="3">${cvo.primaryAddr } ${cvo.detailAddr }</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory">연락처</td><td>${cvo.tel }</td><td class="formCategory">url</td><td>${cvo.url }</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory">소개</td><td colspan="3">${cvo.intro }</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory">영업시간</td><td>${cvo.open } ~ ${cvo.close }시</td><td class="formCategory">공휴일</td><td>${cvo.holiday}</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory" style="height: 300px;">사진</td>
			    			<td colspan="3">
			    				<img id="picView" src="${pageContext.request.contextPath}/resources/upload/company/${cvo.profilePath }" width="100px">
			    			</td>
			    		</tr>
			    		<tr>		
			    			<td class="formCategory">조회수</td><td>${cvo.hit }</td><td class="formCategory">업체 상태</td><td>${cvo.state }</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory">등록일시</td><td colspan="3">${cvo.regdate }</td>
			    		</tr>
			    	</table>
	   			</div>
  			</c:when>
  			<c:otherwise>
		    	<div id="${cvo.name }" class="tab-pane fade"><br>
		    	<div class="hash-day">
			    		<div class="col-sm-4"><span class="label label-danger">#해시태그</span></div>
			    		<div class="col-sm-6">
				    		<!-- <div id="days" class="btn-group" role="group" aria-label="...">
								<input type="button" id="monBtn" class="btn btn-default" value="월" >
						        <input type="button" id="tueBtn" class="btn btn-default" value="화" >
						        <input type="button" id="wenBtn" class="btn btn-default" value="수" >
						        <input type="button" id="thuBtn" class="btn btn-default" value="목 ">
						        <input type="button" id="friBtn" class="btn btn-default" value="금" >
						        <input type="button" id="satBtn" class="btn btn-default" value="토" >
						        <input type="button" id="sunBtn" class="btn btn-default" value="일" >
						        <input type="hidden" id="day" name="day">
						        <span></span>
							</div> -->
			    		</div>
				    	<div class="text-right col-sm-2">
				    		<!-- <span class="label label-danger">수정하기</span> -->
				    		<input type="button" value="수정하기" class="btn btn-danger">
				    	</div>
			    	</div><br><br>
		    		<table class="table table-bordered">
			    		<tr>
			    			<td class="formCategory">업체명</td><td>${cvo.name}</td><td class="formCategory">사업자 등록 번호</td><td>${cvo.license }</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory">주소</td><td colspan="3">${cvo.primaryAddr } ${cvo.detailAddr }</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory">연락처</td><td>${cvo.tel }</td><td class="formCategory">url</td><td>${cvo.url }</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory">소개</td><td colspan="3">${cvo.intro }</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory">영업시간</td><td>${cvo.open } ~ ${cvo.close }시</td><td class="formCategory">공휴일</td><td>${cvo.holiday}</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory" style="height: 300px;">사진</td><td colspan="3">
			    				<img id="picView" src="${pageContext.request.contextPath}/resources/upload/company/${cvo.profilePath }" width="100px">
			    			</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory">조회수</td><td>${cvo.hit }</td><td class="formCategory">업체 상태</td><td>${cvo.state }</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory">등록일시</td><td colspan="3">${cvo.regdate }</td>
			    		</tr>
			    	</table>
		    	</div>
  			</c:otherwise>
  		</c:choose>
    </c:forEach>
  </div>
  </div>
  </div>
  </section>
                