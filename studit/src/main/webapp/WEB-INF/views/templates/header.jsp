<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

      <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">SP<i class="fa fa-circle"></i>T</a>
        </div>
        <div class="navbar-collapse collapse">
        
           <ul class="nav navbar-nav navbar-right">
            <li><a href=""></a></li>
            <li><a href=""></a></li>
            <c:choose>
            <c:when test="${ sessionScope.memberVO == null }">
				<li><a data-toggle="modal"  href="#loginModal">Login</a></li>
	        	<li><a href="${pageContext.request.contextPath}/register_member">Join</a></li>
            </c:when>
            <c:otherwise>
				<li class="dropdown">
	                <a href="#" class="dropdown-toggle" data-toggle="dropdown">${sessionScope.memberVO.name }님<b class="caret"></b></a>
	                <ul class="dropdown-menu multi-level">
	                  <li class="dropdown-submenu">
		                  <a href="#">회원</a>
		                  <ul class="dropdown-menu">
		                      <li><a href="#">회원정보 수정</a></li>
		                      <li><a href="#">비밀번호 변경</a></li>
		                  </ul>                  
	                  </li>
	                  <li><a href="#">Another action</a></li>
	                  <li><a href="#">Something else here</a></li>
	                  <li class="divider"></li>
	                  <li class="dropdown-header">Nav header</li>
	                  <li><a href="#">Separated link</a></li>
	                  <li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
	                </ul>
	              </li>
              </c:otherwise>
              </c:choose>
          </ul>
          
          <ul class="nav navbar-nav navbar-right">
            <li class="active"><a href="index.html">HOME</a></li>
            <li><a href="about.html">STUDY</a></li>
            <li><a href="services.html">STUDY-ROOM</a></li>
            <li><a href="works.html">PLACE</a></li>
            <li><a data-toggle="modal" data-target="#myModal" href="#myModal"><i class="fa fa-envelope-o"></i></a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>
    
    <jsp:include page="../member/login.jsp" />
    