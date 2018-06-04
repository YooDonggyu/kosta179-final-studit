<%@page import="org.kosta.studit.model.vo.CompanyVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.list-group.panel > .list-group-item {
  border-bottom-right-radius: 4px;
  border-bottom-left-radius: 4px
}
.list-group-submenu {
  margin-left:20px;
}
.strong { font-weight: bold; }
</style>
<!-- <script>
$(document).ready(function(){
	$('a').on('click',function(){
		consol.log($(this).attr('class'));
	});
});
</script> -->
<section>
<div id="MainMenu">
	<div class="list-group panel">
		<a href="${pageContext.request.contextPath}/company/companyView" class="list-group-item list-group-item-success strong" >업체 관리</a>
		<a href="${pageContext.request.contextPath }/company/registerCompanyView" >업체 추가하기</a>
		<form id="studyroomViewForm" method="post" action="${pageContext.request.contextPath }/company/StudyRoomInfoView">
				<input type="hidden" name="memberEmail" value="${memberVO.memberEmail}">
				<input type="hidden" name="studyRoomNo" id="studyRoomNo">
		</form>	
		<form id="registerStudyRoomForm" method="post" action="${pageContext.request.contextPath }/company/registerStudyRoomForm">
				<input type="hidden" name="companyNo" id="companyNo">
		</form>	
		<form id="studyRoomConditionForm" method="post" action="${pageContext.request.contextPath }/company/findStudyRoomConditionByCompanyNo">
				<input type="hidden" name="companyNo" id="companyNo2">
		</form>
		<c:forEach items="${cvoList }" var="cvo" varStatus="info">
			<a href="#company${info.count }" class="list-group-item list-group-item-success strong" data-toggle="collapse" data-parent="#MainMenu">${cvo.name}<i class="fa fa-caret-down"></i></a>
			<div class="collapse" id="company${info.count }">
				<c:forEach items="${srvoList }" var="srvo" varStatus="info">
					<c:if test="${srvo.companyVO.companyNo eq cvo.companyNo}">
						<a href="#" onclick=" studyroomView(${srvo.studyRoomNo}); return false" class="list-group-item"  data-parent="#studyroom${info.count }">${srvo.name }<i class="fa fa-caret-down"></i></a>
					</c:if>
				</c:forEach>
				<a href="#" onclick="registerStudyRoom(${cvo.companyNo}); return false" class="list-group-item" ><i class="material-icons" style="font-size: 30px;">add_circle</i><i class="fa fa-caret-down"></i></a>
				<a href="#" onclick="findStudyRoomCondition(${cvo.companyNo}); return false" class="list-group-item strong" >예약 현황 관리<i class="fa fa-caret-down"></i></a>
			</div>
		</c:forEach>
	</div>
</div>
<%-- 
<br><br><br>
<div id="MainMenu">
  <div class="list-group panel">
  	<a href="${pageContext.request.contextPath }/company/registerCompanyView" >업체 등록하기</a>
    <a href="#demo3" class="list-group-item list-group-item-success strong" data-toggle="collapse" data-parent="#MainMenu">Item 1 <i class="fa fa-caret-down"></i></a>
    <div class="collapse" id="demo3">
      <a href="#SubMenu1" class="list-group-item strong" data-toggle="collapse" data-parent="#SubMenu1">Subitem 1<i class="fa fa-caret-down"></i></a>
      <div class="collapse list-group-submenu" id="SubMenu1">
        <a href="#" class="list-group-item" data-parent="#SubMenu1">Subitem 1 a</a>
        <a href="#" class="list-group-item" data-parent="#SubMenu1">Subitem 2 b</a>
        <a href="#SubSubMenu1" class="list-group-item strong" data-toggle="collapse" data-parent="#SubSubMenu1">Subitem 3 c <i class="fa fa-caret-down"></i></a>
        <div class="collapse list-group-submenu list-group-submenu-1" id="SubSubMenu1">
          <a href="#" class="list-group-item" data-parent="#SubSubMenu1">Sub sub item 1</a>
          <a href="#" class="list-group-item" data-parent="#SubSubMenu1">Sub sub item 2</a>
        </div>
        <a href="#" class="list-group-item" data-parent="#SubMenu1">Subitem 4 d</a>
        <a href="#SubSubMenu3" class="list-group-item strong" data-toggle="collapse" data-parent="#SubSubMenu3">Subitem 5 e <i class="fa fa-caret-down"></i></a>
        	<div class="collapse list-group-submenu list-group-submenu-1" id="SubSubMenu3">
          		<a href="#" class="list-group-item" data-parent="#SubSubMenu3">Sub sub item 5.1</a>
          		<a href="#" class="list-group-item" data-parent="#SubSubMenu3">Sub sub item 5.2</a>
        	</div>
      </div>
      <a href="#" class="list-group-item">Subitem 2</a>
      <a href="#" class="list-group-item">Subitem 3</a>
    </div>
    <a href="#demo4" class="list-group-item list-group-item-success strong" data-toggle="collapse" data-parent="#MainMenu">Item 2 <i class="fa fa-caret-down"></i></a>
    <div class="collapse" id="demo4">
      <a href="#" class="list-group-item">Subitem 1</a>
      <a href="#SubSubMenu4" class="list-group-item strong" data-toggle="collapse" data-parent="#SubSubMenu4">Subitem 2 <i class="fa fa-caret-down"></i></a>
      <div class="collapse list-group-submenu list-group-submenu-1" id="SubSubMenu4">
        <a href="#" class="list-group-item" data-parent="#SubSubMenu1">Sub sub item 1</a>
        <a href="#" class="list-group-item" data-parent="#SubSubMenu1">Sub sub item 2</a>
        </div>
      <a href="#" class="list-group-item">Subitem 3</a>
    </div>
  </div>
</div> --%>
</section>

<script>
	//작성: 김유란
	//기능:스터디룸 상세정보 조회 페이지 이동(post 전송 위해 추가)
	function studyroomView(studyRoomNo){
		$("#studyRoomNo").val(studyRoomNo);
		$("#studyroomViewForm").submit();
	}
	
	//작성: 김유란
	//기능:스터디룸 등록 페이지 이동(post 전송 위해 추가)
	function registerStudyRoom(companyNo){
		$("#companyNo").val(companyNo);
		$("#registerStudyRoomForm").submit();
	}
	
	//작성: 김유란
	//기능:스터디룸 예약현황 조회 페이지 이동(post 전송 위해 추가)
	function findStudyRoomCondition(companyNo){
		$("#companyNo2").val(companyNo);
		$("#studyRoomConditionForm").submit();
	}
</script>
