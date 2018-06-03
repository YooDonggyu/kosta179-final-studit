<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="dashboard-counts " style="background-color:#F2F5A9;">
        <div class="container-fluid">
		<div class="row content">
			<div class="col-md-12" style="text-align: center; padding-top: 35px; padding-bottom: 35px;">
				<div>
				<img src="${pageContext.request.contextPath }/resources/upload/studygroup.png" width="70px" height="70px">
				</div>
				<span style="font-weight: 500; font-size: 35px;">속닥속닥 게시판</span>
				<p class="lead text-gray-light" style="font-size: 15px;">우리만의 비밀스런 이야기 공간</p>
			</div>   
		</div> 
	</div>
</section>

<input type="hidden" id="sgNo" value="${groupMemberVO.groupVO.groupNo }">

<!-- 상세보기 폼 -->
<form method="post" action="${pageContext.request.contextPath}/group/findDetailGroupPostByPostNo" id="groupBoardForm">
	<input type="hidden" id="gpNo" name="gpNo">
	<input type="hidden" class="nowPage" name="nowPage" value="${glist.pb.nowPage }">
</form>
<!-- 글작성 폼 -->
<form method="post" action="${pageContext.request.contextPath}/group/createGroupPostView" id="createPost">
	<input type="hidden" class="nowPage" name="nowPage" value="${glist.pb.nowPage }">
</form>

<section class="dashboard-header" style="padding-top: 10px;">
<input type="button" class="btn btn-primary" value="글작성" onclick="return createPost()" style="color:black; background-color:#F2F5A9 ; margin-left: 1200px; margin-bottom: 10px;">
 <div class="container-fluid">
    <div class="row d-flex align-items-md-stretch">
		<table class="table table-hover">
			<thead>
				<tr>
					<th style="text-align: center">번호</th>
					<th style="text-align: center">제목</th>
					<th style="text-align: center">작성자</th>
					<th style="text-align: center">등록일</th>
					<th style="text-align: center">조회수</th>
				</tr>
			</thead>
			<tbody id="groupPostBoard">
				<c:forEach items="${glist.list }" var="list">
					<tr onclick="return goDetail(${list.groupPostNo})">
						<td>${list.groupPostNo }</td>
						<td>${list.title }</td>
						<td>${list.groupMemberVO.memberVO.name }(${list.groupMemberVO.memberVO.memberEmail })</td>
						<td>${list.regdate }</td>
						<td>${list.hit }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<div class="pagingInfo" style="margin-bottom: 50px; margin-left: 620px;">
	<div id="pagingDiv">
	<c:set var="pb" value="${glist.pb}"></c:set>
	</div>
	<ul class="pagination" id="divData">
		<c:if test="${pb.previousPageGroup}">	
			<li><a href="javascript:void(0);" onclick="return findGroupBoard(${pb.startPageOfPageGroup-1})">&laquo;</a></li>
		</c:if>
		<c:forEach var="i" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
			<c:choose>
				<c:when test="${pb.nowPage!=i}">
					<li><a href="javascript:void(0);" onclick="return findGroupBoard(${i})">${i}</a></li>
				</c:when>
				<c:otherwise>
					<li class="disabled"><a href="#">${i}</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${pb.nextPageGroup}">	
			<li><a href="javascript:void(0);" onclick="return findGroupBoard(${pb.endPageOfPageGroup+1})">&raquo;</a></li>
		</c:if>
	</ul>	 		
</div> 
</section>
<script>

function createPost(){
	$("#createPost").submit();
}

function goDetail(gpNo){
	$("#gpNo").val(gpNo);
	$("#groupBoardForm").submit();
}//goDetail

function findGroupBoard(nowPage){
	var sgNo=$("#sgNo").val();
	var pageNo=nowPage;
	$.ajax({
		type: "post",
		url: "${pageContext.request.contextPath}/ajax/findGroupBoardAjax",
		dataType: "json",
		data: "sgNo="+sgNo+"&pageNo="+pageNo,
		success: function(data){
			var temp1="";
			$.each(data.list, function(index, item){
				temp1+="<tr onclick='goDetail(";
				temp1+=item.groupPostNo;
				temp1+=")'>";
				temp1+="<td>";
				temp1+=item.groupPostNo;
				temp1+="</td>";
				temp1+="<td>";
				temp1+=item.title;
				temp1+="</td>";
				temp1+="<td>";
				temp1+=item.groupMemberVO.memberVO.name+"(";
				temp1+=item.groupMemberVO.memberVO.memberEmail+")";
				temp1+="</td>";
				temp1+="<td>";
				temp1+=item.regdate;
				temp1+="</td>";
				temp1+="<td>";
				temp1+=item.hit;
				temp1+="</td>";
				temp1+="</tr>";
			});
			$("#groupPostBoard").html(temp1);

			//페이징 객체 담기
			var pagingData = data.pb;
			//페이징처리할 곳 초기화
			$("#divData").empty();
			var pData = 0;
			//이전 그룹이 있으면 버튼 생성
			 if(pagingData.previousPageGroup){
				 pData = parseInt(pagingData.startPageOfPageGroup)-1;              
				$("#divData").append("<li><a href=\"javascript:void(0);\" onclick=\"return findGroupBoard("+pData+")\">&laquo;</a></li>");
			}
			//페이지 그룹 수 만큼 번호 버튼 생성
			 for(var i =pagingData.startPageOfPageGroup; i<=pagingData.endPageOfPageGroup; i++){
				 pData = i;
				 $("#divData").append("<li><a href=\"javascript:void(0);\" onclick=\"return findGroupBoard("+pData+")\">"+pData+"</a></li> ");
			 }
			//다음 그룹이 있으면 버튼 생성
			if(pagingData.nextPageGroup){
				pData = parseInt(pagingData.endPageOfPageGroup)+1;
				$("#divData").append("<li><a href=\"javascript:void(0);\" onclick=\"return findGroupBoard("+pData+")\" >&raquo;</a></li>");
			}
			
			 //nowPage 설정
			$(".nowPage").val(pagingData.nowPage); 
		}//success
	});//ajax
}//findGroupBoard

</script>


