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
	    <c:forEach items="${recruitInfo.comment }" var="comment"  >
	    	<span>
			    comment : <input type="text"  class="${comment.recruitCommentNo}"  
			    						value="${comment.content}" readonly="readonly">&nbsp;
			    Email : ${comment.memberVO.memberEmail} &nbsp;
			    name : ${comment.memberVO.name} &nbsp;
			    regdate : ${comment.regdate } &nbsp;
			    <c:if test="${sessionScope.memberVO.memberEmail == comment.memberVO.memberEmail }">
			    	<button class="btn btn-primary cuBtn" value="${comment.recruitCommentNo}" >수정</button>
			    	<button class="btn btn-primary cdBtn" value="${comment.recruitCommentNo}" >삭제</button>
			    </c:if>
			    <br>
			</span>
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
		   		<a href="" class="btn btn-primary">신청 ${recruitInfo.studyState} 상태</a> &emsp;
		   </c:otherwise>
	   </c:choose>
   
	    <c:if test="${sessionEmail == requestEmail }"> 
	    	<a href="${pageContext.request.contextPath}/recruit/updateRecruitPostInfoByRecruitNoView?recruitNo=${recruitInfo.detail.recruitPostNo}&bigCategoryNo=${recruitInfo.detail.smallCategoryVO.bigCategoryVO.bigCategoryNo}" 
	    		class="btn btn-primary">수정</a> &nbsp;
	    	<a  data-toggle="modal"  href="#deleteConfrimModal" class="btn btn-primary" >삭제</a> &nbsp;
	    </c:if>
	    <a  href="${pageContext.request.contextPath}/recruit/getRecruitPostList?pageNo=1" class="btn btn-primary">이전</a> &nbsp;
	    
    </section>
    
    <!-- Modal -->
    <jsp:include page="register_recruit_study.jsp" />
    
    <script>
		$(document).ready(function(){
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
						}//if
					}//success
		    	})//ajax
	    	})//click

			//작성: 유동규
			//기능: 댓글 삭제하기
			//로직: 1. 댓글을 받아오기
			//		 2. ajax로 댓글 삭제 
			//       3. reload() 함수를 통해 새로고침
		    $(".cdBtn").click(function(){
		    	var commentNo = $(this).val();
		    	$.ajax({
		    		type:"post",
					url:"${pageContext.request.contextPath}/ajax/deleteCommentByCommentNo",
					data: "commentNo="+commentNo,
					success:function(){
						location.reload();
					}//success
				})//ajax
		    })//click
		    
			//작성: 유동규
			//기능: 댓글 수정하기
			//로직: 1. 
			//		 2. 
			//       3. reload() 함수를 통해 새로고침
		    $(".cuBtn").click(function (){
		    	var btnText = $(this).text();
		    	if(btnText == '수정'){
		    		$("."+$(this).val()+"").focus();
		    		$("."+$(this).val()+"").removeAttr("readonly");
		    		$(this).text("저장");
		    	}else{
		    		var commentNo =$(this).val();
		    		var content = $("."+$(this).val()+"").val();
		    		if(content.trim().length == 0){
		    			alert("댓글을 입력하세요");
		    			return false;
		    		}
		    		$("."+$(this).val()+"").attr("readonly","readonly");
		    		$(this).text("수정");
		    		
		    		$.ajax({
		    			type:"post",
		    			url:"${pageContext.request.contextPath}/ajax/updateCommentByCommentNo",
		    			data:"commentNo="+commentNo+"&content="+content,
		    			success:function(){
							location.reload();
		    			}//success
		    		})//ajax
		    	}//else
		    })//click
		})//ready
    </script>
    
    
    