<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.recruit{
		margin-bottom: 10px;
	}
	.recruit-comment-left{
		text-align: left;
	}
	.recruit-comment-right{
		text-align: right;
	}
	.no-shadow{
		box-shadow: 0 0 0;
	}
	.no-border{
		border: 0;
	}
	.no-padding{
		padding: 0;
	}
	
</style>


<br>
	<div class="container">
	<div class="col-sm-1"></div>
    <div class="col-sm-10">
    <div class="row"  style="text-align: right">
    	<span class="label label-default">[${recruitInfo.detail.smallCategoryVO.bigCategoryVO.name}/${recruitInfo.detail.smallCategoryVO.name}]</span>
    	<span class="label label-default">${recruitInfo.detail.capacity }명</span>
    	<span class="label label-default">${recruitInfo.detail.location }</span>
    		<c:choose>
    		<c:when test="${recruitInfo.day.size() == 7 }">
				<span class="label label-danger">매일</span>
			</c:when>
			<c:when test="${! recruitInfo.day.contains('토') && !recruitInfo.day.contains('일') && recruitInfo.day.size() == 5}">
				<span class="label label-danger">매주 평일</span>
			</c:when>
			<c:when test="${recruitInfo.day.contains('토') && recruitInfo.day.contains('일') && recruitInfo.day.size() == 2}">
				<span class="label label-danger">매주 주말</span>
			</c:when>
			<c:otherwise>
				<c:forEach items="${recruitInfo.day }"  varStatus="cnt" var="day">
					<span class="label label-info">${day}</span>
				</c:forEach>
			</c:otherwise>
    		</c:choose>
	   	</div><!-- row -->
    	
    	<div class="row">
    		<!-- 제목 및 내용 -->
	    	<div class="page-header">
				<h3 class="recruit">${recruitInfo.detail.title}</h3>
	    	</div>
	    	<div class="btn-group btn-group-justified recruit"  role="group" >
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-default">작성자: ${recruitInfo.detail.memberVO.name } </button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-default">등록일: ${recruitInfo.detail.regdate}</button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-default">조회수 : ${recruitInfo.detail.hit} </button>
				</div>
			</div>
	    	<div >
	    		<pre >${recruitInfo.detail.content}</pre>
	    	</div>
    		<input type="hidden" id="hiddenRecruitNo" value="${recruitInfo.detail.recruitPostNo}">
    	</div><!-- row -->
    
		     <div class="row">
		    	<div class="col-xs-3" ></div>
		    	<div class="col-xs-6" >
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
					    <c:if test="${recruitInfo.detail.condition eq '모집중'}">		
					    	<a  data-toggle="modal"  href="#deleteConfrimModal" class="btn btn-primary" >삭제</a> &nbsp;
					    </c:if>
				    </c:if>
				    <a  href="${pageContext.request.contextPath}/recruit/getRecruitPostList?pageNo=${nowPage}" class="btn btn-primary">목록으로</a> &nbsp;
		    	</div><!-- col -->
		    	<div class="col-xs-3" ></div>
		    </div><!-- row -->
    
		    <div class="row">
		    	<div class="col-xs-12">
		    	<br><br>
		    		<hr>
		    	</div>
		    </div><!-- row -->
    	</div><!-- col -->
    </div><!-- container -->
    
    
    <!-- comment -->
    <div class="container" >
    <!-- comment -->
    <div class="row" >
    <div class="col-xs-1"></div>
    	<div class="col-xs-10" id="commentArea">
    		 <c:forEach items="${recruitInfo.comment }" var="comment"  >
    		 	<div class="panel panel-default no-shadow no-border">
    				<div class="panel-body  no-padding">
    						<div class="row">
    						<div class="col-xs-6 recruit-comment-left "><label class="label label-default ">${comment.memberVO.name}님</label>&nbsp; ${comment.regdate }</div>
    						<div class="col-xs-6 recruit-comment-right">
	    							<c:if test="${sessionScope.memberVO.memberEmail == comment.memberVO.memberEmail }">
		    							<button class="btn btn-xs btn-default cuBtn recruit-comment-right" value="${comment.recruitCommentNo}" >수정</button>
		    							<button class="btn btn-xs btn-default cdBtn recruit-comment-right" value="${comment.recruitCommentNo}" >삭제</button>
		    						</c:if>
		    				</div>
    						</div>
    						<div class="col-xm-12">
	    						<input type="text"  style="background-color: #ffffff" class="form-control ${comment.recruitCommentNo}"   value="${comment.content}" readonly="readonly">
    						</div> 
    				</div>
    			</div>
    		</c:forEach>
    	</div>
    	 <div class="col-xs-1"></div>
    </div>
    
    <!-- comment insert box -->
    <div class="row" >
    <div class="col-xs-1"></div>
    	<div class="col-xs-10"  >
    			<hr>
    		 	<div class="panel panel-default no-shadow no-border">
    				<div class="panel-body no-padding">
    						<div class="row">
    						<div class="col-xs-6 recruit-comment-left"><label class="label label-default ">${sessionScope.memberVO.name}님 댓글 달기</label></div>
	    						<div class="col-xs-6 recruit-comment-right">
		    						<input type="button"  class="btn btn-xs btn-default" value="등록"  id="registerCommentBtn"  >
			    				</div>
    						</div>
    						<div class="col-xm-12">
	    						<input type="text"  class="form-control" id="registerComment">
    						</div> 
    				</div>
    			</div>
    	</div>
    <div class="col-xs-1"></div>
    </div>
    </div>
    
    <!-- Modal -->
    <jsp:include page="register_recruit_study.jsp" />
    
    <script>
    	function goBack(){
    		history.back();
    	}
    
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
					success:function(data){
						location.reload();
					}//success
				})//ajax
		    })//click
		    
			//작성: 유동규
			//기능: 댓글 수정하기
			//로직: 1. 
			//		   2. 
			//        3. reload() 함수를 통해 새로고침
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
    
    
    