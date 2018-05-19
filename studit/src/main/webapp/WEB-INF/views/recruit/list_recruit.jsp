<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

      <section class="signup-section text-center no-padding-bottom">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <h3>스터디 모집</h3>
              <p class="lead text-gray-light">지금 당신에게 필요한 모든 스터디를 찾아보세요!</p>
          	</div>   
          </div> 
           <div class="row">
            <div class="col-md-12">
           <form action="${pageContext.request.contextPath}/recruit/findRecruitPostByCategoryAndKeyword" method="post">
			<table style="width: 600px; margin: 0 auto">
          		<tr>
          			<td>
            		 <select name="bigCategory" id="bigCategory" class="form-control">
            	 			<option value="">대분류</option> 
             				<c:forEach	items="${bigCategoryList}" var="bc">
             					<option value="${bc.bigCategoryNo}">${bc.name}</option> 
             				</c:forEach>
            		  </select>  
             		</td>
             		<td style="padding-left: 10px; padding-right: 10px">
     					<div class="dropdown">
        					<a href="#" class="dropdown-toggle" id="smallCategoryMenu" data-toggle="dropdown">소분류<b class="caret"></b></a>
							<ul class="dropdown-menu" id="checkbox">
							<li><a href='#' class='dropdown-item'>대분류를 먼저 선택하세요.</a></li>
							</ul>
  						</div>
  					</td>
  					<td>
						<input id="keyword" name="keyword" type="text" placeholder="강남역, 종로, 주말" class="form-control">
            		 </td>
            		  <td>
            		  	<input id="submit" type="submit" value="검색" class="btn btn-primary"> 
            		  </td>
            		 </tr>
            </table>   
            
     	   </form>
     	   </div>
     	   </div>
        </div>
      </section>
    
     <%--  <section id="features" class="section">
        <div class="container">
          <div class="row text-center-mobile"> 
            <div class="col-md-6">
              <div class="icon"><i class="pe-7s-diamond"></i></div>
              <h2>First great feature</h2>
              <p>Effects present letters inquiry no an removed or friends. Desire behind latter me though in. Supposing shameless am he engrossed up additions. My possible peculiar together to. Desire so better am cannot he up before points. Remember mistaken opinions it pleasure of debating. Court front maids forty if aware their at. Chicken use are pressed removed.  </p>
            </div>
            <div class="col-md-6">
              <p><img alt="" src="${pageContext.request.contextPath }/resources/assets/img/features1.png" class="img-responsive"></p>
            </div>
          </div>
        </div>
      </section> --%>

<section id="features" class="section">
	<div class="container">
	  <!-- <h2>Table</h2>
	  <p>The .table-hover class enables a hover state on table rows within a tbody:</p>                    -->           
	 <button class="btn btn-transparent" style="float: right;" onclick=""><b>새 스터디 모집하기</b></button>
	 <br>
	 <br>
	 <br>
	  <table class="table table-hover">
	    <thead>
	      <tr>
	        <th style="text-align: center">#</th>
	        <th style="text-align: center">title</th>
	        <th style="text-align: center">name</th>
	        <th style="text-align: center">date</th>
	        <th style="text-align: center">location</th>
	        <th style="text-align: center">hit</th>
	      </tr>
	    </thead>
	    <tbody>
	      <c:forEach items="${recruitPostListVO.recruitPostList}" var="post">
	     	 <tr onclick="findDetailRecruitPostInfoByRecruitNo(${post.recruitPostNo})">
		      	<td>${post.recruitPostNo}</td>		
		      	<td>${post.title}</td>
		      	<td>${post.memberVO.name}</td>
		      	<td>${post.regdate}</td>
		      	<td>${post.location}</td>
		      	<td>${post.hit}</td>
	      	</tr>
	      </c:forEach>  
	    </tbody>
	  </table>
	</div>
	<div class="pagingInfo">
		<c:set var="pb" value="${recruitPostListVO.pagingBean}"></c:set>
		<ul class="pagination">
		<c:if test="${pb.previousPageGroup}">	
			<li><a href="${pageContext.request.contextPath}/recruit/getRecruitPostList?pageNo=${pb.startPageOfPageGroup-1}">&laquo;</a></li>
		</c:if>
		<c:forEach var="i" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
			<c:choose>
				<c:when test="${pb.nowPage!=i}">
					<li><a href="${pageContext.request.contextPath}/recruit/getRecruitPostList?pageNo=${i}">${i}</a></li> 
				</c:when>
				<c:otherwise>
					<li class="disabled"><a href="#" >${i}</a></li>
				</c:otherwise>
			</c:choose>
			&nbsp;
		</c:forEach>
		<c:if test="${pb.nextPageGroup}">	
			<li><a href="${pageContext.request.contextPath}/recruit/getRecruitPostList?pageNo=${pb.endPageOfPageGroup+1}">&raquo;</a></li>
		</c:if>
		</ul>	 		
	</div> 	
</section>

<script>
	$(document).ready(function() {
		
		//작성: 김유란
		//기능: 대분류 번호에 따라 소분류 목록를 가져와 보여주기
		//로직: 대분류 셀렉트 박스의 선택값이 변경될 때마다 셀렉트 옵션의 value인 대분류 번호가 전송되고
		//	    번호로 검색한 소분류 목록이 로드되어 소분류 체크박스 메뉴가 변경된다.
		$("#bigCategory").change(function() {
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath}/ajax/getSmallCategoryList",
				dataType:"json",
				data:"bigCategoryNo="+$("#bigCategory").val(),
				success:function(data){
					var result = "";
					$.each(data, function(index, item) {
						result+= "<li>"
										+"<a href='#' class='dropdown-item'>"
										+"<input type='checkbox' name='category' value="+item.smallCategoryNo+">"
										+item.name
										+"</a>"
										"</li>";
					})//each
					$("#checkbox").html(result);
				}//success
			})//ajax
		})//change
		
	})//ready



	//작성: 김유란
	//기능: 상세글 보기로 이동
	//로직: 테이블의 특정 행을 클릭하면 글번호가 전송되어 해당 글의 상세페이지로 이동한다. 
	function findDetailRecruitPostInfoByRecruitNo(recruitNo) {
		location.href=
			"${pageContext.request.contextPath }/recruit/findDetailRecruitPostInfoByRecruitNo?recruitNo="+recruitNo;
	}
</script>

    
    
<!-- 
<div class="jumbotron">
	  <h1>Hello, world!</h1>
	  <p>gd</p>
       <div class="form-group">
    		<div class="col-sm-12 col-md-12">
    			
    				<div id="radioBtn" class="btn-group">
						<div class="btn-group">
						  <button type="button" class="btn btn-default">Left</button>
						  <button type="button" class="btn btn-default">Middle</button>
						  <button type="button" class="btn btn-default">Middle</button>
						  <button type="button" class="btn btn-default">Middle</button>
						  <button type="button" class="btn btn-default">Right</button>
						</div>
    				</div>
    				
    				<br>
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
								Action <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li><a href="#">Action</a></li>
							<li><a href="#">Another action</a></li>
						    <li><a href="#">Something else here</a></li>
						    <li class="divider"></li>
						    <li><a href="#">Separated link</a></li>
						</ul>
					</div>

					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
								Action <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li><a href="#">Action</a></li>
							<li><a href="#">Another action</a></li>
						    <li><a href="#">Something else here</a></li>
						    <li class="divider"></li>
						    <li><a href="#">Separated link</a></li>
						</ul>
					</div>


					<nav class="navbar navbar-default" role="navigation">
					  Brand and toggle get grouped for better mobile display
					  <div class="navbar-header">
					    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					      <span class="sr-only">Toggle navigation</span>
					      <span class="icon-bar"></span>
					      <span class="icon-bar"></span>
					      <span class="icon-bar"></span>
					    </button>
					    <a class="navbar-brand" href="#">Brand</a>
					  </div>
					
					  Collect the nav links, forms, and other content for toggling
					  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					    
					    <ul class="nav navbar-nav">
					      <li class="active"><a href="#">Link</a></li>
					      <li><a href="#">Link</a></li>
					    </ul>
					    
					    <form class="navbar-form navbar-left" role="search">
	 					      <div class="form-group">
					        <input type="text" class="form-control" placeholder="Search">
					      </div>
					      <div class="form-group">
						<button type="button" class="btn btn-default navbar-btn">Sign in</button>
						<button type="button" class="btn btn-default navbar-btn">Sign in</button>
						<button type="button" class="btn btn-default navbar-btn">Sign in</button>
						<button type="button" class="btn btn-default navbar-btn">Sign in</button>
						</div>
					    </form>
					  </div>/.navbar-collapse
					</nav>


    				
    		</div>
    	</div>
</div>




<div class="panel panel-default">

<div class="panel-heading">
	Panel heading
	
	<div class="btn-group">
		<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
				Action <span class="caret"></span>
		</button>
		<ul class="dropdown-menu" role="menu">
			<li><a href="#">Action</a></li>
			<li><a href="#">Another action</a></li>
			<li><a href="#">Something else here</a></li>
			<li class="divider"></li>
			<li><a href="#">Separated link</a></li>
		</ul>
	</div>
	<div class="btn-group">
		<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
				Action <span class="caret"></span>
		</button>
		<ul class="dropdown-menu" role="menu">
			<li><a href="#">Action</a></li>
			<li><a href="#">Another action</a></li>
			<li><a href="#">Something else here</a></li>
			<li class="divider"></li>
			<li><a href="#">Separated link</a></li>
		</ul>
	</div>
	
	
</div>

  <div class="panel-body">
    <p>...</p>
  </div>

  Table
  <table class="table">
  
  </table>
</div>
 -->