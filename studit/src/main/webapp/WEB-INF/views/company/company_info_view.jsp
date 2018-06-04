<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.add {
	background-color: rgb(96, 201, 255);
	color: rgb(255, 255, 255);
}
.updateBtn{
	width: 300px;
	height: 50px;
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
height: 217px;
width: 217px;
}
</style>
<script>
/* var days = ${days}; */
$(document).ready(function(){
		console.log('comPic: ${companyPicPath}');
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
			    		<div class="col-sm-6 text-left">
			    			<c:forEach items="${hashList }" var="hash">
			    				<c:if test="${hash.CNO eq cvo.companyNo}">
					    			<span class="label label-danger">#${hash.CONTENT }</span>
			    				</c:if>
			    			</c:forEach>
			    		</div>
			    		<div class="col-sm-6 text-right" >
				    		<div id="days" class="btn-group" role="group" aria-label="...">
				    			<c:forEach items="${days }" var="day">
				    				<c:if test="${day.CNO eq cvo.companyNo }">
				    					<c:if test="${day.DAY eq '월' }">
				    						<input type="button" class="btn btn-default add" value="월" >
				    					</c:if>
				    					<c:if test="${day.DAY eq '화' }">
				    						<input type="button" class="btn btn-default add" value="화" >
				    					</c:if>
				    					<c:if test="${day.DAY eq '수' }">
				    						<input type="button" class="btn btn-default add" value="수" >
				    					</c:if>
				    					<c:if test="${day.DAY eq '목' }">
				    						<input type="button" class="btn btn-default add" value="목" >
				    					</c:if>
				    					<c:if test="${day.DAY eq '금' }">
				    						<input type="button" class="btn btn-default add" value="금" >
				    					</c:if>
				    					<c:if test="${day.DAY eq '토' }">
				    						<input type="button" class="btn btn-default add" value="토" >
				    					</c:if>
				    					<c:if test="${day.DAY eq '일' }">
				    						<input type="button" class="btn btn-default add" value="일" >
				    					</c:if>
				    				</c:if>
				    			</c:forEach>
							</div>
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
			    			<td class="formCategory intro">소개</td><td colspan="3">${cvo.intro }</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory">영업시간</td><td>${cvo.open } ~ ${cvo.close }시</td><td class="formCategory">공휴일</td><td>${cvo.holiday}</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory" style="height: 217px;">사진</td>
			    			<td colspan="3">
			    				<img id="picView" src="${pageContext.request.contextPath}/resources/upload/${cvo.profilePath }">
			    				<c:if test="${!empty companyPicPath }">
			    					<c:forEach items="${companyPicPath }" var="comPic">
			    						<c:if test="${comPic.CNO eq cvo.companyNo }">
			    							<img id="picView" src="${pageContext.request.contextPath}/resources/upload/${comPic.PATH }">
			    						</c:if>
			    					</c:forEach>
			    				</c:if>
			    			</td>
			    		</tr>
			    		<tr>		
			    			<td class="formCategory">조회수</td><td>${cvo.hit }</td><td class="formCategory">업체 상태</td><td>${cvo.state }</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory">등록일시</td><td colspan="3">${cvo.regdate }</td>
			    		</tr>
			    		<tr>
			    			<td colspan="4" style="height: 100px;">
			    				<div class="updateBtnDiv" >
				    				<input type="button" value="수정하기" class="btn btn-danger updateBtn" onclick="updateCompanyForm(${cvo.companyNo})">
			    				</div>
			    			</td>
			    		</tr>
			    	</table>
	   			</div>
  			</c:when>
  			<c:otherwise>
		    	<div id="${cvo.name }" class="tab-pane fade"><br>
		    	<div class="hash-day">
			    		<div class="col-sm-6 text-left">
			    			<c:forEach items="${hashList }" var="hash">
			    				<c:if test="${hash.CNO eq cvo.companyNo}">
					    			<span class="label label-danger">#${hash.CONTENT }</span>
			    				</c:if>
			    			</c:forEach>
			    		</div>
			    		<div class="col-sm-6 text-right">
				    		<div id="days" class="btn-group" role="group" aria-label="...">
								<c:forEach items="${days }" var="day">
				    				<c:if test="${day.CNO eq cvo.companyNo }">
				    					<c:if test="${day.DAY eq '월' }">
				    						<input type="button" class="btn btn-default add" value="월" >
				    					</c:if>
				    					<c:if test="${day.DAY eq '화' }">
				    						<input type="button" class="btn btn-default add" value="화" >
				    					</c:if>
				    					<c:if test="${day.DAY eq '수' }">
				    						<input type="button" class="btn btn-default add" value="수" >
				    					</c:if>
				    					<c:if test="${day.DAY eq '목' }">
				    						<input type="button" class="btn btn-default add" value="목" >
				    					</c:if>
				    					<c:if test="${day.DAY eq '금' }">
				    						<input type="button" class="btn btn-default add" value="금" >
				    					</c:if>
				    					<c:if test="${day.DAY eq '토' }">
				    						<input type="button" class="btn btn-default add" value="토" >
				    					</c:if>
				    					<c:if test="${day.DAY eq '일' }">
				    						<input type="button" class="btn btn-default add" value="일" >
				    					</c:if>
				    				</c:if>
				    			</c:forEach>
							</div>
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
			    			<td class="formCategory intro">소개</td><td colspan="3">${cvo.intro }</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory">영업시간</td><td>${cvo.open } ~ ${cvo.close }시</td><td class="formCategory">공휴일</td><td>${cvo.holiday}</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory" style="height: 217px;">사진</td><td colspan="3">
			    				<img id="picView" src="${pageContext.request.contextPath}/resources/upload/${cvo.profilePath }" width="100px">
			    				<c:if test="${!empty companyPicPath }">
			    					<c:forEach items="${companyPicPath }" var="comPic">
			    						<c:if test="${comPic.CNO eq cvo.companyNo }">
			    							<img id="picView" src="${pageContext.request.contextPath}/resources/upload/${comPic.PATH }">
			    						</c:if>
			    					</c:forEach>
			    				</c:if>
			    			</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory">조회수</td><td>${cvo.hit }</td><td class="formCategory">업체 상태</td><td>${cvo.state }</td>
			    		</tr>
			    		<tr>
			    			<td class="formCategory">등록일시</td><td colspan="3">${cvo.regdate }</td>
			    		</tr>
			    		<tr>
			    			<td colspan="4" style="height: 100px;">
			    				<div class="updateBtnDiv" >
			    					<input type="button" value="수정하기" class="btn btn-danger updateBtn" onclick="updateCompanyForm(${cvo.companyNo})">
			    				</div>
			    			</td>
			    		</tr>
			    	</table>
		    	</div>
  			</c:otherwise>
  		</c:choose>
    </c:forEach>
  </div>
  </div>
  </div>
  <form method="post" id="updateCompanyForm" action="${pageContext.request.contextPath }/company/updateCompanyForm">
  	<input type="hidden" name="selectedCompanyNo" id="selectedCompanyNo">
  </form>
  </section>         
  <script>
  function updateCompanyForm(companyNo){
	  $("#selectedCompanyNo").val(companyNo);
	  $("#updateCompanyForm").submit();
  }
  </script>