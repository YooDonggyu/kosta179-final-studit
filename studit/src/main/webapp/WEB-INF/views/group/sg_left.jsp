<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
<nav class="side-navbar" style="background-color: #F78181;">
      <div class="side-navbar-wrapper">
        <div class="sidenav-header d-flex align-items-center justify-content-center" style="background-color: #F78181;">
          <div class="sidenav-header-inner text-center"><br>
          <div id="egg"><img src="${pageContext.request.contextPath }/resources/assets/img/groupLogo1.png" alt="person" class="img-fluid rounded-circle"></div>
            <h2 class="h5 text-uppercase">${groupMemberVO.groupVO.name}</h2><span class="text-uppercase">${groupMemberVO.memberVO.name}(${groupMemberVO.memberVO.memberEmail })님</span>
			<c:if test="${groupMemberVO.position eq '팀장' }"><i class="fas fa-crown fa-2x" style="color: #ffcc00"></i></c:if>          
          </div>
          <!-- <div class="sidenav-header-logo"><a href="index.html" class="brand-small text-center"> <strong>B</strong><strong class="text-primary">D</strong></a></div> -->
        </div>
        <div class="main-menu">
        <!-- HOME FORM -->	
        <form method="post" action="${pageContext.request.contextPath }/group/groupHome" id="groupHome">
        	<input type="hidden" id="sgNoHome" name="sgNo">
        </form>
        <!-- BOARD FORM -->
        <form method="post" action="${pageContext.request.contextPath }/group/findGroupBoard" id="groupBorad"></form>
        <!-- LEAVE FORM -->
        <form method="post" action="${pageContext.request.contextPath }/group/leaveStudyGroup" id="leaveGroup"></form>
          
          <ul id="side-main-menu" class="side-menu list-unstyled">               
            <li><a id="home" onclick="return groupHome(${groupMemberVO.groupVO.groupNo})"> <i class="icon-home"></i><span>HOME</span></a></li>
            <li> <a onclick="return groupBoard()"><i class="icon-presentation"></i><span>BOARD</span></a></li>
            <li> <a href="${pageContext.request.contextPath }/group/studyGourpKanbanView" onclick="window.open(this.href, 'kanban', 'width=900, height=600'); return false"> <i class="icon-grid"> </i><span>SCHEDULER</span></a></li>
            <c:choose>
            	<c:when test="${groupMemberVO.position eq '팀장' }">
            		 <li> <a href="${pageContext.request.contextPath}/group/findGroupMemberView"><i class="icon-form"></i><span>LEADER</span></a></li>
            	</c:when>
            	<c:otherwise>
            		 <li><a onclick="return leaveGroup(${sgNo})"><i class="icon-form"></i><span>LEAVE</span></a></li>
            	</c:otherwise>
            </c:choose>
            <li> <a href="${pageContext.request.contextPath}/group/exitStudyGroup"> <i class="icon-interface-windows"></i><span>EXIT</span></a></li>
            <!-- <li> <a href="#"> <i class="icon-mail"></i><span>Demo</span>
                <div class="badge badge-warning">6 New</div></a></li> -->
          </ul>
          
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
    		});//egg
    	});//ready
    	
    	function groupHome(sgNo){
    		$("#sgNoHome").val(sgNo);
    		$("#groupHome").submit();
    	}
    	
    	function groupBoard(){
    		$("#groupBorad").submit();
    	}
    	
    	function leaveGroup(){
    		if(confirm("정말 탈퇴하시겠습니까?")){
        		$("#leaveGroup").submit();
			}
    	}
    	
    	
    </script>
    
    
    
    
    