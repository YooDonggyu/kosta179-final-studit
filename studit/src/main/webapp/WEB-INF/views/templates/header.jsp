<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <section class="menu cid-qRwIUXq4f4" once="menu" id="menu2-1j"> 
    <nav class="navbar navbar-expand beta-menu navbar-dropdown align-items-center navbar-fixed-top navbar-toggleable-sm bg-color transparent">
        <!-- Logo -->
        <div class="menu-logo">
            <div class="navbar-brand">
                <span class="navbar-logo">
                    <a href="${pageContext.request.contextPath }/">
                        <img src="${pageContext.request.contextPath }/resources/assets/images/logo2.png" alt="Mobirise" style="height: 3.8rem;">
                    </a>
                </span>
            </div>
        </div>
        
        <!-- Menu -->
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav nav-dropdown" data-app-modern-menu="true"><li class="nav-item">
                    <a class="nav-link link text-black display-4" href="#">STUDY</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link link text-black display-4" href="#">STUDY-ROOM</a>
                </li>
                <li class="nav-item">
                	<a class="nav-link link text-black display-4" href="#">PLACE</a>
                </li>
            </ul>
            <!-- 로그인, 회원가입, 로그아웃 -->
            <div class="navbar-buttons mbr-section-btn">
            	<c:choose>
            		<c:when test="${sessionScope.memberVO == null }">
		            	<a class="btn btn-sm btn-primary display-4" href="${pageContext.request.contextPath }/loginView">Login</a> 
		            	<a class="btn btn-sm btn-primary display-4" href="#">Join</a>
            		</c:when>
            		<c:otherwise>
            			<a class="btn btn-sm btn-primary display-4" >${sessionScope.memberVO.name}</a> 
		            	<a class="btn btn-sm btn-primary display-4" href="${pageContext.request.contextPath }/logout">Logout</a>
            		</c:otherwise>
            	</c:choose>
            </div>
        </div>
    </nav>
  </section>