<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
<nav class="side-navbar" style="background-color: #F78181;">
      <div class="side-navbar-wrapper">
        <div class="sidenav-header d-flex align-items-center justify-content-center" style="background-color: #F78181;">
          <div class="sidenav-header-inner text-center">
          <div id="egg"><img src="${pageContext.request.contextPath }/resources/assets/img/groupLogo1.png" alt="person" class="img-fluid rounded-circle"></div>
            <h2 class="h5 text-uppercase">${groupMemberVO.groupVO.name}</h2><span class="text-uppercase">${groupMemberVO.memberVO.name}(${groupMemberVO.memberVO.memberEmail })님</span>
            <c:if test="${groupMemberVO.position eq '팀장' }"><i class="fas fa-crown fa-2x" style="color: #ffcc00"></i></c:if>
          </div>
          <!-- <div class="sidenav-header-logo"><a href="index.html" class="brand-small text-center"> <strong>B</strong><strong class="text-primary">D</strong></a></div> -->
        </div>
        <div class="main-menu">
        <form method="post" action="${pageContext.request.contextPath }/group/groupHome" id="groupHome">
        <input type="hidden" id="sgNo" name="sgNo">
          <ul id="side-main-menu" class="side-menu list-unstyled">               
            <li><a id="home" onclick="return groupHome(${groupMemberVO.groupVO.groupNo})"> <i class="icon-home"></i><span>HOME</span></a></li>
            <li> <a href="#"><i class="icon-presentation"></i><span>BOARD</span></a></li>
            <li> <a href="#"> <i class="icon-grid"> </i><span>SCHEDULER</span></a></li>
            <c:choose>
            	<c:when test="${groupMemberVO.position eq '팀장' }">
            		 <li> <a href="${pageContext.request.contextPath}/group/findGroupMemberView?groupNo=${groupMemberVO.groupVO.groupNo}"><i class="icon-form"></i><span>ADMIN</span></a></li>
            	</c:when>
            	<c:otherwise>
            		 <li> <a href="#"><i class="icon-form"></i><span>LEAVE</span></a></li>
            	</c:otherwise>
            </c:choose>
            <li> <a href="${pageContext.request.contextPath}/"> <i class="icon-interface-windows"></i><span>EXIT</span></a></li>
            <!-- <li> <a href="#"> <i class="icon-mail"></i><span>Demo</span>
                <div class="badge badge-warning">6 New</div></a></li> -->
          </ul>
          </form>
        </div>
			        <!-- <div class="admin-menu">
			          <ul id="side-admin-menu" class="side-menu list-unstyled"> 
			            <li> <a href="#pages-nav-list" data-toggle="collapse" aria-expanded="false"><i class="icon-interface-windows"></i><span>Dropdown</span>
			                <div class="arrow pull-right"><i class="fa fa-angle-down"></i></div></a>
			              <ul id="pages-nav-list" class="collapse list-unstyled">
			                <li> <a href="#">Page 1</a></li>
			                <li> <a href="#">Page 2</a></li>
			                <li> <a href="#">Page 3</a></li>
			                <li> <a href="#">Page 4</a></li>
			              </ul>
			            </li>
			            <li> <a href="#"> <i class="icon-screen"> </i><span>Demo</span></a></li>
			            <li> <a href="#"> <i class="icon-flask"> </i><span>Demo</span>
			                <div class="badge badge-info">Special</div></a></li>
			            <li> <a href=""> <i class="icon-flask"> </i><span>Demo</span></a></li>
			            <li> <a href=""> <i class="icon-picture"> </i><span>Demo</span></a></li>
			          </ul>
			        </div> -->
      </div>
    </nav>
    
    <script>
    	$(document).ready(function(){
    		var cnt=1;
    		$("#egg").click(function(){
    			cnt+=1;
    			var temp="";
    			if(cnt%2==0){
    				temp+="<img src='${pageContext.request.contextPath }/resources/assets/img/groupLogo2.png' alt='person' class='img-fluid rounded-circle'>";
    			}else{
    				temp+="<img src='${pageContext.request.contextPath }/resources/assets/img/groupLogo1.png' alt='person' class='img-fluid rounded-circle'>";
    			}
    			$("#egg").html(temp);
    		});
    	});
    	function groupHome(sgNo){
    		$("#sgNo").val(sgNo);
    		$("#groupHome").submit();
    	}
    </script>
    
    
    
    
    