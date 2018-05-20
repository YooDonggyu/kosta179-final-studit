<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
    <section>
	    <!-- recruitPostNo -->
	    recruitPostNo : ${recruitInfo.detail.recruitPostNo} <br><br>
	    <!-- Category -->
	    [${recruitInfo.detail.smallCategoryVO.bigCategoryVO.name}/${recruitInfo.detail.smallCategoryVO.name}] &nbsp;
	    <!-- title -->
	    title : ${recruitInfo.detail.title} <br><br>
	    <!-- location -->
	    location: ${recruitInfo.detail.location } <br><br>
	    <!-- content -->
	    content : ${recruitInfo.detail.content} <br><br>
	    <!-- regdate -->
	    regdate : ${recruitInfo.detail.regdate} <br><br>
	    <!-- hit -->
	    hit : ${recruitInfo.detail.hit} <br><br>
	    <!-- condition -->
	    condition : ${recruitInfo.detail.condition} <br><br>
	    <!-- capacity -->
	    capacity : ${recruitInfo.detail.capacity} <br><br>
	    <!-- memberName -->
	    name : ${recruitInfo.detail.memberVO.name } <br><br>
	    <!-- day -->
	    day : ${recruitInfo.day} <br><br>
	    <!-- comment -->
	    COMMENT<br>
	    <span id="commentSpan">
	    <c:forEach items="${recruitInfo.comment }" var="comment" >
		    comment : ${comment.content}&nbsp;
		    name : ${comment.name} &nbsp;
		    regdate : ${comment.regdate } &nbsp;
		    <br>
	    </c:forEach>
	    </span><br>
	    <input type="text" id="registerComment"><input type="button" value="등록"  id="registerCommentBtn"  >
	    
	    
	    <br><br>
    
	   <c:set scope="session" value="${memberVO.memberEmail}"  var="sessionEmail" />
	   <c:set scope="request" value="${recruitInfo.detail.memberVO.memberEmail }"  var="requestEmail" />
	   <c:choose>
		   <c:when test="${empty recruitInfo.studyState || recruitInfo.studyState == '거절'}">
		   		<c:if test="${sessionEmail != requestEmail }">
					<a  data-toggle="modal"  href="#recruitStudyModal" class="btn btn-primary">신청</a> &emsp;
		   		</c:if>
		   </c:when>
		   <c:otherwise>
		   		<a href="" class="btn btn-primary">${recruitInfo.studyState} 상태입니다.</a> &emsp;
		   </c:otherwise>
	   </c:choose>
   
	    <c:if test="${sessionEmail == requestEmail }"> 
	    	<a href="${pageContext.request.contextPath}/recruit/updateRecruitPostInfoByRecruitNoView?recruitNo=${recruitInfo.detail.recruitPostNo}&bigCategoryNo=${recruitInfo.detail.smallCategoryVO.bigCategoryVO.bigCategoryNo}" 
	    	class="btn btn-primary">수정</a> &nbsp;
	    	<a  data-toggle="modal"  href="#deleteConfrimModal" class="btn btn-primary">삭제</a> &emsp;
	    </c:if>
	    
    </section>
    <jsp:include page="register_recruit_study.jsp" />
    
    <script>
		//작성: 유동규
		//기능: 댓글 추가하기
		//로직: 1. 댓글 입력안의 공백, null 체크를 우선
		//		 2. ajax로 댓글 추가 
		//       3. reload() 함수를 통해 새로고침
		
    	$("#registerCommentBtn").click(function(){
	    	var comment = $("#registerComment").val();
	    	var recruitNo =${recruitInfo.detail.recruitPostNo};
	    	if(comment.trim().length == 0 || comment =="" || comment == null){
	    		alert("댓글을 입력하세요");
	    		return false;
	    	}
	    	$.ajax({
	    		type:"post",
				url:"${pageContext.request.contextPath}/ajax/registerComment",
				data:"recruitNo="+recruitNo+"&comment="+comment,
				success:function(data){
					if(data == "true"){
						location.reload();
					}
				}//success
	    	})//ajax
    	})//click
    	
    
    </script>
    
    
    