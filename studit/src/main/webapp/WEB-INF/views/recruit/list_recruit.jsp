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
				<table style="width: 600px; margin: 0 auto">
					<tr>
						<td>
							<select name="bigCategory" id="bigCategory" class="form-control">
								<option id="bigCategoryMenu">대분류</option> 
								<c:forEach	items="${bigCategoryList}" var="bc">
									<option value="${bc.bigCategoryNo}">${bc.name}</option> 
								</c:forEach>
			 				</select>  
						</td>
						<td style="padding-left: 10px; padding-right: 10px">
							<div class="dropdown">
								<a href="#" class="dropdown-toggle" id="smallCategoryMenu" data-toggle="dropdown">소분류<b class="caret"></b></a>
								<ul class="dropdown-menu" id="smallCheckbox">
									<li><a href='#' class='dropdown-item'>대분류를 먼저 선택하세요.</a></li>
								</ul>
 							</div>
 						</td>
 						<td>
							<input id="keyword" name="keyword" type="text" placeholder="제목, 지역을 검색하세요" class="form-control">
						</td>
						<td>
							<input type="button" value="검색" class="btn btn-primary" id="recruitSrchBtn" onclick="return categoryCheck(1)"> 
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</section>

<section id="features" class="section">
	<div class="container">
		<div style="float: left" id="resultData">
			${recruitPostListVO.pagingBean.totalPostCount}건이 검색되었습니다.
		</div>
		<button class="btn btn-transparent" style="float: right;" id="createRecruitPost"><b>새 스터디 모집하기</b></button><br><br><br>
	  	<table class="table table-hover">
			<thead>
				<tr>
					<th style="text-align: center">번호</th>
					<th style="text-align: center">카테고리</th>
					<th style="text-align: center">지역</th>
					<th style="text-align: center">제목</th>
					<th style="text-align: center">팀장</th>
					<th style="text-align: center">등록날짜</th>
					<th style="text-align: center">조회수</th>
				</tr>
			</thead>
			<tbody  id="recruitTable">
				<c:forEach items="${recruitPostListVO.recruitPostList}" var="post">
					<tr onclick="findDetailRecruitPostInfoByRecruitNo(${post.recruitPostNo})">
						<td>${post.recruitPostNo}</td>		
						<td>[${post.smallCategoryVO.bigCategoryVO.name}/${post.smallCategoryVO.name}]</td>
						<td>${post.location}</td>
						<td>${post.title}</td>
						<td>${post.memberVO.name}</td>
						<td>${post.regdate}</td>
						<td>${post.hit}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="pagingInfo" >
		<c:set var="pb" value="${recruitPostListVO.pagingBean}"></c:set>
		<ul class="pagination" id="divData">
			<c:if test="${pb.previousPageGroup}">	
				<li><a href="${pageContext.request.contextPath}/recruit/getRecruitPostList?pageNo=${pb.startPageOfPageGroup-1}">&laquo;</a></li>
			</c:if>
			<c:forEach var="i" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
				<c:choose>
					<c:when test="${pb.nowPage!=i}">
						<li><a href="javascript:void(0);" onclick="return categoryCheck(${i})">${i}</a></li> 
					</c:when>
					<c:otherwise>
						<li class="disabled"><a href="#" >${i}</a></li>
					</c:otherwise>
				</c:choose>
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
			var bigCategoryNo = $("#bigCategory").val();
			if(bigCategoryNo == '대분류'){
				bigCategoryNo = -1;
			}
			
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath}/ajax/getSmallCategoryList",
				dataType:"json",
				data:"bigCategoryNo="+bigCategoryNo,
				success:function(data){
					var result = "";
					if(data == null || data == ""){
						result+= "<li><a href='#' class='dropdown-item'>대분류를 먼저 선택하세요.</li>";
					}else{
						$.each(data, function(index, item) {
							result+= "<li>"
											+"<a href='#' class='dropdown-item'>"
											+"<input type='checkbox' name='category' data-citem="+item.name+" value="+item.smallCategoryNo+">"
											+item.name
											+"</a>"
											"</li>";
						})//each
					}
					$("#smallCheckbox").html(result);
				}//success
			})//ajax
		})//change
		
		$("#createRecruitPost").click(function(){
			location.href="${pageContext.request.contextPath}/recruit/createRecruitPostView";
		});
		
	})//ready
	
	//작성: 유동규
	//기능: 카테고리와 키워드를 이용해 페이징처리
	//로직: 소, 대 카테고리 값과 키워드 값을 읽어 컨트롤러로 전송
	//			페이징처리된 결과를 화면에 뿌려준다.
	//			검색된 내용을 테이블 위에 뿌려준다
	function categoryCheck(i) {
		var nowPage = i;
		var bigCategory = $("#bigCategory option:selected").val();
		var smallCategory = [];
		var keyword = $("#keyword").val();
		if(bigCategory == '대분류'){
			bigCategory="";
		}
		$("input[name='category']:checked").each(function(i){
			smallCategory.push($(this).val());
		})
		var listData ="";
	 	$.ajax({
			type:"get",
			url:"${pageContext.request.contextPath}/ajax/findRecruitPostByCategoryAndKeyword",
			dataType:"json",
			data:"bigCategoryNo="+bigCategory+"&smallCategoryNo="+smallCategory+"&keyword="+keyword+"&nowPage="+nowPage,
			success:function(data){
				$.each(data.recruitPostList, function(index, item){
					listData += 
						"<tr onclick="+'findDetailRecruitPostInfoByRecruitNo('+item.recruitPostNo+')'+">"+
						"<td>"+item.recruitPostNo+"</td>"+
						"<td>"+"["+item.smallCategoryVO.bigCategoryVO.name+"/"+item.smallCategoryVO.name+"]"+"</td>"+
						"<td>"+item.location+"</td>"+
						"<td>"+item.title+"</td>"+
						"<td>"+item.memberVO.name+"</td>"+
						"<td>"+item.regdate+"</td>"+
						"<td>"+item.hit+"</td>"+
						"</tr>"
						;
				})//each
				$("#recruitTable").html(listData);
				//페이징 객체 담기
				var pagingData = data.pagingBean;
				//페이징처리할 곳 초기화
				$("#divData").empty();
				var pData = 0;
				//이전 그룹이 있으면 버튼 생성
				 if(pagingData.previousPageGroup){
					 pData = parseInt(pagingData.startPageOfPageGroup)-1;
					$("#divData").append("<li><a href=\"javascript:void(0);\" onclick=\"return categoryCheck("+pData+")\">&laquo;</a></li>");
				}
				//페이지 그룹 수 만큼 번호 버튼 생성
				 for(var i =pagingData.startPageOfPageGroup; i<=pagingData.endPageOfPageGroup; i++){
					 pData = i;
					 $("#divData").append("<li><a href=\"javascript:void(0);\" onclick=\"return categoryCheck("+pData+")\">"+pData+"</a></li> ");
				 }
				//다음 그룹이 있으면 버튼 생성
				if(pagingData.nextPageGroup){
					pData = parseInt(pagingData.endPageOfPageGroup)+1;
					$("#divData").append("<li><a href=\"javascript:void(0);\" onclick=\"return categoryCheck("+pData+")\" >&raquo;</a></li>");
				}
				
				//검색한 키워드를 테이블 상단에 뿌려주기 위한 작업
				$("#resultData").empty();
				if(bigCategory > 0){
					$("#resultData").append("\""+$("#bigCategory option:selected").text()+"\"");
					$("#resultData").append("    ");
				}
				if(smallCategory.length >0){
					$("input[name='category']:checked").each(function(i){
						$("#resultData").append("\""+$(this).data("citem")+"\"")
					});
					$("#resultData").append("    ");
				}
				if(keyword != "" && keyword != null){
					$("#resultData").append("\""+keyword+"\"");
				}
				
				 if(data.recruitPostList.length >0){
					$("#resultData").append(data.pagingBean.totalPostCount+"건이 검색되었습니다.");
				} 
				
			}//success
		})//ajax
	}//categoryCheck
	
	
	//작성: 김유란
	//기능: 상세글 보기로 이동
	//로직: 테이블의 특정 행을 클릭하면 글번호가 전송되어 해당 글의 상세페이지로 이동한다. 
	function findDetailRecruitPostInfoByRecruitNo(recruitNo) {
		location.href=
			"${pageContext.request.contextPath }/recruit/findDetailRecruitPostInfoByRecruitNo?recruitNo="+recruitNo;
	}
	 	
</script>

    
