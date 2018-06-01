<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
<style>
th{
	text-align: center;
}
.container{
	padding: 50px;	
}
</style>
<section>
<div class="col-sm-12 container">	
<div class="row">

	<i class="far fa-address-card  fa-2x"></i>&nbsp;&nbsp;<h2><b>팀원 관리</b></h2>
	
<div style="max-width: 400px; float: left; margin: 50px;">
	<h5><b>그룹 멤버</b></h5>
	<form action="${pageContext.request.contextPath}/group/updateGroupMemberPosition" method="post" id="changePositionForm">
  	<table class="table table-hover">
		<thead>
			<tr>
				<th>이름</th>
				<th>메일</th>
				<th>직책</th>
				<th>선택</th>
			</tr>
		</thead>
		<tbody id="memberList">
			<c:forEach items="${groupMemberList.list}" var="member">
				<tr>
					<td>${member.memberVO.name }</td>
					<td>${member.memberVO.memberEmail }</td>
					<td>${member.position}</td>
					<c:choose>
					<c:when test="${member.position eq '팀원'}"> 
					<td>
						<input type="button" value="팀장 위임" onclick="go(${member.groupMemberNo})" class="btn btn-default btn-sm" >
					</td>
					</c:when>
					<c:otherwise>
						<input type="hidden" name="groupOwnerNo" id="groupOwnerNo" value="${member.groupMemberNo}">
						<td align="center"><i class="fas fa-crown" style="color: #ffcc00"></i></td>
					</c:otherwise>
					</c:choose>
				</tr>
			</c:forEach>
		</tbody>
		<c:set var="memberpb" value="${groupMemberList.pagingBean}" />
		<c:if test="${memberpb.nextPage == true}">
			<tr>
				<td colspan="4"><input type="button" id="memberpbBtn"  value="더보기"></td>
			</tr>
		</c:if>
	</table>
	<input type="hidden" name="groupMemberNo" id="groupMemberNo">
	</form>
</div>	 

<div style="max-width: 500px; float: left; margin: 50px">
<h5><b>승인 대기중인 신청자</b></h5>
  <c:choose>
  	<c:when test="${empty conditionList.list}">
  	<br><br><br><br><br>
  	대기중인 신청자가 없습니다.
  	<br><br><br><br><br>
  	</c:when>
  	<c:otherwise>
  	<form action="${pageContext.request.contextPath}/group/registerGroupMember" method="post" id="registerGroupMemberForm">
  	<table class="table table-hover">
		<thead>
			<tr>
				<th>이름</th>
				<th>신청일</th>
				<th>한줄소개</th>
				<th colspan="2">선택</th>
			</tr>
		</thead>
		<tbody id="conditionList">
			<c:forEach items="${conditionList.list}" var="con">
				<tr>
					<td>${con.memberVO.name }</td>
					<td>${con.regdate}</td>
					<td>${con.selfAppeal}</td>
					<!-- warning 주황, default 흰색, primary 핑크?, sucess 초록, danger 빨강, info 하늘 -->
					<td><input type="button"  value="승인"  class="btn btn-primary btn-sm" onclick="confirmMember(${con.studyConditionNo})"></td>
					<td><input type="button" value="거절" class="btn btn-default btn-sm" onclick="denyMember(${con.studyConditionNo})"></td>
				</tr>
			</c:forEach>
		</tbody>
		<c:set var="conditionpb" value="${conditionList.pagingBean}" />
		<c:if test="${conditionpb.nextPage == true}">
			<tr>
				<td colspan="5"><input type="button" id="conditionpbBtn"  value="더보기"></td>
			</tr>
		</c:if>
	</table>
	<input type="hidden" name="groupVO.groupNo" value="${groupMemberVO.groupVO.groupNo}">
	</form>
  	</c:otherwise>
  </c:choose> 
</div>
</div>
<div align="center">
<c:if test="${groupMemberVO.groupVO.recruitPostVO.condition eq '모집중' || groupMemberVO.groupVO.recruitPostVO.condition eq '추가모집'}">
	<button id="openGroupBtn" class="btn btn-primary"><i class="fas fa-check"></i> 스터디 개설</button>
</c:if>
<c:if test="${groupMemberVO.groupVO.recruitPostVO.condition eq '모집완료'}">
	<button class="btn btn-outline-warning"><i class="fas fa-plus"></i> 추가모집</button>
</c:if>	
</div>
</div>
</section>


<script>
var conditionPageNo=1;
var memberPageNo = 1;

$(document).ready(function() {
	
	
	$("#conditionpbBtn").click(function(){
		conditionPageNo += 1;
		$.ajax({
			type:"post",
			url:"${pageContext.request.contextPath}/ajax/findStudyConditionByNowPageAndConditionNo",
			data:"nowPage="+conditionPageNo+"&groupNo="+${groupMemberVO.groupVO.groupNo},
			success:function(data){
				var temp="";
			 	$.each(data.list, function(index, item) {
					temp += 
						"<tr>"+
						"<td>"+item.memberVO.name+"</td>"+
						"<td>"+item.regdate+"</td>"+
						"<td>"+item.selfAppeal+"</td>"+
						"<td>"+"<input type='button'  value='승인'  class='btn btn-primary btn-sm' onclick='confirmMember("+item.studyConditionNo+")'>"+"</td>"+
						"<td>"+"<input type='button' value='거절' class='btn btn-default btn-sm' onclick='denyMember("+item.studyConditionNo+")'>"+"</td>"+
						+"</tr>"
				})//each 
				$("#conditionList").append(temp);
			 	if(!data.pagingBean.nextPage){
			 		$("#conditionpbBtn").hide();
			 	}else{
			 		$("#conditionpbBtn").show();
			 	}
			}//success
		})//ajax
	})//click

	$("#memberpbBtn").click(function(){
		memberPageNo += 1;
		$.ajax({
			type:"post",
			url:"${pageContext.request.contextPath}/ajax/findGroupMemberByNowPage",
			data:"nowPage="+memberPageNo+"&groupNo="+${groupMemberVO.groupVO.groupNo},
			success:function(data){
				var temp="";
			 	$.each(data.list, function(index, item) {
					temp += 
						"<tr>"+
						"<td>"+item.memberVO.name+"</td>"+
						"<td>"+item.memberVO.memberEmail+"</td>"+
						"<td>"+item.position+"</td>"+
						"<td>"+"<input type='button' value='팀장 위임' onclick='go("+item.groupMemberNo+")' class='btn btn-default btn-sm'>"+"</td>"
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
	});//click
	
	$("#openGroupBtn").click(function() {
		if(confirm("스터디 개설 후에는 모집글을 열람할 수 없습니다. \n이후 새로운 팀원을 모집하고 싶다면 추가모집 메뉴를 이용해주세요. \n이제 스터디를 개설할까요?")){
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath}/ajax/updateRecruitCondition",
				data:"recruitPostNo="+${groupMemberVO.groupVO.recruitPostVO.recruitPostNo},
				success:function(data){
					alert("스터디 개설 완료! 그룹 활동을 시작합니다.")
					location.reload();
				}//success
			})//ajax
		}
	});
	
})//ready


function go(groupMemberNo){
	if(confirm("팀장을 위임하는 즉시 팀원이 되어 \n팀원 관리에 대한 모든 권한이 사라집니다. \n지금 위임하시겠습니까?")){
		$("#groupMemberNo").val(groupMemberNo);
		$("#changePositionForm").submit(); 
	}
}

function confirmMember(conditionNo) {
	if(confirm("이 신청을 승인할까요?")){
		$.ajax({
			type:"post",
			url:"${pageContext.request.contextPath}/ajax/registerGroupMember",
			data:"state=승인&studyConditionNo="+conditionNo+"&groupNo="+${groupMemberVO.groupVO.groupNo},
			success:function(data){
				location.reload();
			}//success
		})//ajax
	}
}

function denyMember(conditionNo) {
	if(confirm("이 신청을 거절할까요?")){
		$.ajax({
			type:"post",
			url:"${pageContext.request.contextPath}/ajax/registerGroupMember",
			data:"state=거절&studyConditionNo="+conditionNo+"&groupNo="+${groupMemberVO.groupVO.groupNo},
			success:function(data){
				location.reload();
			}//success
		})//ajax
	}
}



</script>