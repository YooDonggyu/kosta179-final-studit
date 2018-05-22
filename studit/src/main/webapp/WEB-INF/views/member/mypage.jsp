<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>

div.sc-table {
    font-size: 60%;
}
</style>
<section>
<div class="col-sm-1"></div>
<!-- 스터디 신청 현황 -->
<div class="col-sm-4 sc-table">
	<table class="table table-hover">
		<thead>
			<tr>
				<th>No</th>
				<th>Category</th>
				<th>Location</th>
				<th>Title</th>
				<th>Writer</th>
				<th>regDate</th>
				<th>Status</th>
			</tr>
		</thead>
		<tbody id="recruitAjaxResult">
			<c:forEach items="${studyConditionList.list }" var="list">
				<tr>
					<td>${list.studyConditionNo }</td>
					<td>${list.recruitPostVO.smallCategoryVO.name }</td>
					<td>${list.recruitPostVO.location }</td>
					<td>${list.recruitPostVO.title }</td>
					<td>${list.memberVO.name }</td>
					<td>${list.regdate}</td>
					<td><input type="button" value="${list.state }" class="btn btn-secondary"></td>
				</tr>
			</c:forEach>
		</tbody>
		<c:set var="recruitpb" value="${studyConditionList.pagingBean}" />
		<c:if test="${recruitpb.nextPage == true}">
			<tr>
				<td colspan="7"><input type="button" id="recruitpbBtn"  value="더보기"></td>
			</tr>
		</c:if>
	</table>
	</div>
	
	<div class="col-sm-1"></div>
	<!-- 스터디 룸 신청현황 -->
	<div class="col-sm-4 sc-table">
	<table class="table table-hover">
		<thead>
			<tr>
				<th>companyName</th>
				<th>studyroomName</th>
				<th>useDate</th>
				<th>startTime</th>
				<th>endTime</th>
				<th>regDate</th>
				<th>state</th>
			</tr>
		</thead>
		<tbody id="roomAjaxResult">
			<c:forEach items="${srcListVO.list}" var="srlist">
				<tr>
					<td>${srlist.studyRoomVO.companyVO.name }</td>
					<td>${srlist.studyRoomVO.name }</td>
					<td>${srlist.useDate }</td>
					<td>${srlist.startTime }</td>
					<td>${srlist.endTime }</td>
					<td>${srlist.regDate }</td>
					<td><input type="button" value="${srlist.state }" class="btn btn-secondary"></td>
				</tr>
			</c:forEach>
		</tbody>
		<c:set var="roompb" value="${srcListVO.pagingBean}" />
		<c:if test="${roompb.nextPage == true}">
			<tr>
				<td colspan="7"><input type="button" id="roompbBtn"  value="더보기"></td>
			</tr>
		</c:if>
	</table>
	</div>
	<div class="col-sm-1"></div>
</section>



<script>
	$(document).ready(function(){
		var roomPageNo = 1;
		var recruitPageNo = 1;
		$("#roompbBtn").click(function(){
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
							"<td>"+item.studyRoomVO.companyVO.name+"</td>"+
							"<td>"+item.studyRoomVO.name+"</td>"+
							"<td>"+item.useDate+"</td>"+
							"<td>"+item.startTime+"</td>"+
							"<td>"+item.endTime+"</td>"+
							"<td>"+item.regDate+"</td>"+
							"<td>"+"<input type='button' value="+item.state+" class='btn btn-secondary'>"+"</td>"
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
		
		
		
		$("#recruitpbBtn").click(function(){
			recruitPageNo += 1;
			$.ajax({
				type:"get",
				url:"${pageContext.request.contextPath}/ajax/findStudyConditionByNowPage",
				data:"nowPage="+recruitPageNo,
				success:function(data){
					var temp="";
				 	$.each(data.list, function(index, item) {
						temp += 
							"<tr>"+
							"<td>"+item.studyRoomVO.companyVO.name+"</td>"+
							"<td>"+item.studyRoomVO.name+"</td>"+
							"<td>"+item.useDate+"</td>"+
							"<td>"+item.startTime+"</td>"+
							"<td>"+item.endTime+"</td>"+
							"<td>"+item.regDate+"</td>"+
							"<td>"+"<input type='button' value="+item.state+" class='btn btn-secondary'>"+"</td>"
							+"</td>"
					})//each 
					$("#recruitAjaxResult").append(temp);
				 	if(!data.pagingBean.nextPage){
				 		$("#recruitpbBtn").hide();
				 	}else{
				 		$("#recruitpbBtn").show();
				 	}
				}//success
			})//ajax
		})//click
	})//ready
</script>




 