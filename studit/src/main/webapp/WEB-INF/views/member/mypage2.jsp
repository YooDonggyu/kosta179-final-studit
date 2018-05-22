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
	<c:if test="${pb.nextPage == true}">
		<input type="button" id="pbBtn"  value="더보기"><br>
	</c:if>
	<input type="hidden" id="hiddenNowPage" value="${pb.nowPage}">
</section>

<script>
	$(document).ready(function(){
		var pageNo = 1;
		$("#pbBtn").click(function(){
			pageNo += 1;
			$.ajax({
				type:"get",
				url:"${pageContext.request.contextPath}/ajax/findStudyRoomConditionByNowPage",
				data:"nowPage="+pageNo,
				success:function(data){
					var temp="";
				 	$.each(data.list, function(index, item) {
						/* result +=	"<option value="+item.smallCategoryNo+">"+item.name+"</option>"; */
						/* alert(item.studyRoomConditionNo) */
						temp += "useDate : "+item.useDate+
							" &emsp; regDate : "+item.regDate+
							" &emsp; startTime : "+item.startTime +
							" &emsp; endTime : "+item.endTime +
							" &emsp; state : "+item.state +
							" &emsp; memberName : "+item.memberVO.name+
							" &emsp; memberEmail : "+item.memberVO.memberEmail+
							" &emsp; studyroomName : "+item.studyRoomVO.name+
							" &emsp; companyName : "+item.studyRoomVO.companyVO.name+
							"<br>";
					})//each 
					$("#ajaxResult").append(temp);
				 	if(!data.pagingBean.nextPage){
				 		$("#pbBtn").hide();
				 	}else{
				 		$("#pbBtn").show();
				 	}
				 	
				}//success
			})
		})
	})
</script>