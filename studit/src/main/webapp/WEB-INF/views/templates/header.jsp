<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 
    <div role="navigation" class="navbar navbar-default navbar-fixed-top">
          <div class="container">
            <div class="navbar-header"><a href="${pageContext.request.contextPath}/" class="navbar-brand scroll-to"><img src="${pageContext.request.contextPath }/resources/assets/img/logo.png" alt="logo" class="hidden-xs hidden-sm"><img src="${pageContext.request.contextPath }/resources/assets/img/logo-small.png" alt="logo" class="visible-xs visible-sm"><span class="sr-only">Go to homepage</span></a>
              <div class="navbar-buttons">
                <button type="button" data-toggle="collapse" data-target=".navbar-collapse" class="navbar-toggle navbar-btn">Menu<i class="pe-7s-menu"></i></button>
              </div>
            </div>
            <div id="navigation" class="collapse navbar-collapse navbar-right">
            
              <ul class="nav navbar-nav ">
		            <li class="active"><a href="${pageContext.request.contextPath}/">HOME</a></li>
		            <li><a href="${pageContext.request.contextPath}/recruit/getRecruitList">STUDY</a></li>
		            <li><a href="${pageContext.request.contextPath}/">STUDY-ROOM</a></li>
		            <li><a href="${pageContext.request.contextPath}/">PLACE</a></li>
		            <li><a data-toggle="modal" href="#"><i class="fa fa-envelope-o"></i></a></li>
	          	</ul>
            
              <ul class="nav navbar-nav navbar-right">
                <c:choose>
        		    <c:when test="${ sessionScope.memberVO == null }">
						<li><a data-toggle="modal"  href="#loginModal">Login</a></li>
	        			<li><a href="${pageContext.request.contextPath}/register_member">Join</a></li>
           		 </c:when>
           		 <c:otherwise>
					<li class="dropdown">
	                <a href="#" class="dropdown-toggle" data-toggle="dropdown">${sessionScope.memberVO.name }님<b class="caret"></b></a>
	                <ul class="dropdown-menu multi-level">
	                  <li class="dropdown-header">관리</li>
	                  <li><a href="${pageContext.request.contextPath}/member/getMyPage">스터디통합관리</a></li>
	                  <li class="divider"></li>
	                  <li class="dropdown-header">회원정보</li>
	                  <li><a data-toggle="modal"  href="#checkMemberModal">회원정보 수정</a></li>
	                  <li><a href="${pageContext.request.contextPath}/member/updatePasswordView">비밀번호 변경</a></li>
	                  <li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
	                </ul>
	              </li>
              </c:otherwise>
              </c:choose>
              </ul>
             
            </div>
          </div>
        </div>
        

    <jsp:include page="../member/login.jsp" />
 <jsp:include page="../member/check_member.jsp" />
