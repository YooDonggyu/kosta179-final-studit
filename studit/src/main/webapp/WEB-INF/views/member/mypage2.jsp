<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
<section>
	<c:forEach items="${srcListVO.list}" var="srlist">
		useDate : ${srlist.useDate } &emsp;
		regDate : ${srlist.regDate } &emsp;
		startTime : ${srlist.startTime } &emsp;
		endTime : ${srlist.endTime } &emsp;
		state : ${srlist.state } &emsp;
		memberName : ${srlist.memberVO.name } &emsp;
		memberEmail : ${srlist.memberVO.memberEmail } &emsp;
		studyroomName : ${srlist.studyRoomVO.name } &emsp;
		companyName : ${srlist.studyRoomVO.companyVO.name } &emsp;
		<br>
	</c:forEach>
	<span id="ajaxResult">
		
	</span>
	<br><br>
		<c:set var="pb" value="${srcListVO.pagingBean}" />
	<c:if test="	${pb.nextPage }">
		<input type="button" id="pbBtn" onclick ="srPagingBtn()" value="더보기"><br>
	</c:if>
	<input type="hidden" id="hiddenNowPage" value="${pb.nowPage}">
</section>

<script>
	$(document).ready(function(){
		$("#pbBtn").click(function(){
			var nowPage = $("#hiddenNowPage").val();
			$.ajax({
				type:"get",
				url:"${pageContext.request.contextPath}/ajax/findStudyRoomConditionByNowPage",
				data:"nowPage="+nowPage,
				success:function(data){
					var temp="";
				 	$.each(data.list, function(index, item) {
						/* result +=	"<option value="+item.smallCategoryNo+">"+item.name+"</option>"; */
						/* alert(item.studyRoomConditionNo) */
						temp += "useDate : "+item.useDate+
							"regDate : "+item.regDate+
							"startTime : "+item.startTime +
							"endTime : "+item.endTime +
							"state : "+item.state +
							"memberName : "+item.memberVO.name+
							"memberEmail : "+item.memberVO.memberEmail+
							"studyroomName : "+item.studyRoomVO.name+
							"companyName : "+item.studyRoomVO.companyVO.name+
							"<br>";
					})//each 
					$("#ajaxResult").append(temp);
				}//success
			})
		})
	})
</script>