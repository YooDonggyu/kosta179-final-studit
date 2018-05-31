<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<style>
th{
	text-align: center;
}
.container{
	padding: 50px;	
}
</style>
<section>
<div class="col-sm-offset-2 col-sm-10 container">
<div class="row">

	<h3>팀원 관리</h3>

<div style="max-width: 400px; float: left; margin: 50px;">
	<h5>팀원</h5>
  	<table class="table table-hover">
		<thead>
			<tr>
				<th>이름</th>
				<th>직책</th>
				<th>선택</th>
			</tr>
		</thead>
		<tbody id="memberList">
			<c:forEach items="${groupMemberList.list}" var="member">
				<tr>
					<td>${member.memberVO.name }</td>
					<td>${member.position}</td>
					<c:choose>
					<c:when test="${member.position eq '팀원'}">
					<td><button id="changeBtn" class="btn btn-default">팀장 위임</button></td>
					</c:when>
					<c:otherwise>
						<td></td>
					</c:otherwise>
					</c:choose>
				</tr>
			</c:forEach>
		</tbody>
		<c:set var="memberpb" value="${groupMemberList.pagingBean}" />
		<c:if test="${memberpb.nextPage == true}">
			<tr>
				<td colspan="3"><input type="button" id="memberpbBtn"  value="더보기"></td>
			</tr>
		</c:if>
	</table>
</div>	 



<div style="max-width: 400px; float: left; margin: 50px">
<h5>신청자</h5>
  <c:choose>
  	<c:when test="${empty conditionList}">
  	<br><br><br><br><br>
  	아직 신청자가 없습니다.
  	<br><br><br><br><br>
  	</c:when>
  	<c:otherwise>
  	<table class="table table-hover">
		<thead>
			<tr>
				<th>이름</th>
				<th>신청일</th>
				<th>한줄소개</th>
				<th>선택</th>
			</tr>
		</thead>
		<tbody id="conditionList">
			<c:forEach items="${conditionList.list }" var="con">
				<tr>
					<td>${con.memberVO.name }</td>
					<td>${con.regdate}</td>
					<td>${con.selfAppeal}</td>
					<!-- warning 주황, default 흰색, primary 핑크?, sucess 초록, danger 빨강, info 하늘 -->
					<td><button id="confirmBtn" value="${list.studyConditionNo}" class="btn btn-default">승인</button></td>
				</tr>
			</c:forEach>
		</tbody>
		<c:set var="conditionpb" value="${conditionList.pagingBean}" />
		<c:if test="${conditionpb.nextPage == true}">
			<tr>
				<td colspan="4"><input type="button" id="conditionpbBtn"  value="더보기"></td>
			</tr>
		</c:if>
	</table>
  	</c:otherwise>
  </c:choose> 
</div>
</div>
</div>

</section>


<script>
var conditionPageNo=1;
var memberPageNo = 1;
$("#conditionpbBtn").click(function(){
	roomPageNo += 1;
	$.ajax({
		type:"get",
		url:"${pageContext.request.contextPath}/ajax/findStudyRoomConditionByNowPage",
		data:"nowPage="+roomPageNo,
		success:function(data){
			var temp="";
		 	$.each(data.list, function(index, item) {
				temp += 
					"<tr>"+
					"<td>"+item.name+"</td>"+
					"<td>"+item.regDate+"</td>"+
					+"</td>"
			})//each 
			$("#roomAjaxResult").append(temp);
		 	if(!data.pagingBean.nextPage){
		 		$("#roompbBtn").hide();
		 	}else{
		 		$("#roompbBtn").show();
		 	}
		}//success
	})//ajax
})//click

$("#memberpbBtn").click(function(){
	memberPageNo += 1;
	$.ajax({
		type:"get",
		url:"${pageContext.request.contextPath}/ajax/findGroupMemberByNowPage",
		data:"nowPage="+memberPageNo+"&groupNo="+${param.groupNo},
		success:function(data){
			var temp="";
		 	$.each(data.list, function(index, item) {
				temp += 
					"<tr>"+
					"<td>"+item.memberVO.name+"</td>"+
					"<td>"+item.position+"</td>"+
					"<td>"+"<button id='changeBtn' class='btn btn-default'>팀장 위임</button>"+"</td>"
					+"</tr>"
			})//each 
			$("#memberList").append(temp);
		 	if(!data.pagingBean.nextPage){
		 		$("#memberpbBtn").hide();
		 	}else{
		 		$("#memberpbBtn").show();
		 	}
		}//success
	})//ajax
})//click
</script>