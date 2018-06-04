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
<section>
<div id="MainMenu">
	<div class="list-group panel">
		<a href="${pageContext.request.contextPath}/company/companyView" class="list-group-item list-group-item-success strong" >업체 관리</a>
		<a href="${pageContext.request.contextPath }/company/registerCompanyView" >업체 추가하기</a>
		<c:forEach items="${cvoList }" var="cvo" varStatus="info">
			<a href="#company${info.count }" class="list-group-item list-group-item-success strong" data-toggle="collapse" data-parent="#MainMenu">${cvo.name}<i class="fa fa-caret-down"></i></a>
			<div class="collapse" id="company${info.count }">
				<c:forEach items="${srvoList }" var="srvo" varStatus="info">
					<c:if test="${srvo.companyVO.companyNo eq cvo.companyNo }">
						<a href="${pageContext.request.contextPath }/company/StudyRoomInfoView?studyRoomNo=${srvo.studyRoomNo}&memberEmail=${memberVO.memberEmail}" class="list-group-item"  data-parent="#studyroom${info.count }">${srvo.name }<i class="fa fa-caret-down"></i></a>
					</c:if>
				</c:forEach>
				<a href="${pageContext.request.contextPath }/company/registerStudyRoomForm?companyNo=${cvo.companyNo}&companyName=${cvo.name}" class="list-group-item" ><i class="material-icons" style="font-size: 30px;">add_circle</i><i class="fa fa-caret-down"></i></a>
				<a href="${pageContext.request.contextPath }/company/findStudyRoomConditionByCompanyNo?companyNo=${cvo.companyNo}" class="list-group-item strong" >예약 현황 관리<i class="fa fa-caret-down"></i></a>
			</div>
		</c:forEach>
	</div>
</div>
</section>