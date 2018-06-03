<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 글수정 폼 -->
<form method="post" action="${pageContext.request.contextPath }/group/updateGroupPostView" id="updateGroupPostForm">
	<input type="hidden" id="gpNo" name="gpNo" value="${gpNo }">
	<input type="hidden" id="nowPage" name="nowPage" value="${nowPage }">
</form>

<!-- 목록으로 돌아가는 폼 -->
<form method="post" action="${pageContext.request.contextPath }/group/findGroupBoard" id="goBackForm">
	<input type="hidden" id="nowPage" name="nowPage" value="${nowPage }">
	<input type="hidden" id="sgNo" name="sgNo" value="${sessionScope.sgNo }">
</form>

<!-- 글삭제 폼 -->
<form method="post" action="${pageContext.request.contextPath }/group/deleteGroupPost" id="deleteGroupPostForm">
	<input type="hidden" name="gpNo" value="${gpNo }">
</form>
<hr>
<h3 style="font-weight: bold; text-align: center;">${glist.title }</h3>
<hr>
<table>
	<tbody>
		<tr>
			<td>작성자 : ${glist.groupMemberVO.memberVO.name}(${glist.groupMemberVO.memberVO.memberEmail })</td>
			<td>등록일 : ${glist.regdate}</td>
			<td>조회수 : ${glist.hit}</td>
		</tr>
		<tr>
			<td colspan="2"><textarea style="width:100%; height: 250px; resize: none;"  readonly="readonly" id="content" name="content">${glist.content }</textarea></td>
		</tr>
	</tbody>
</table>

<c:if test="${memberVO.memberEmail eq glist.groupMemberVO.memberVO.memberEmail }">
	<input type="button" value="수정" onclick="return updateGroupPost()">
	<input type="button" value="삭제" onclick="return deleteGroupPost()">
</c:if>
<input type="button" value="목록" onclick="return goBack()">


<!-- comment -->
    <div class="container" >
    <!-- comment -->
    <div class="row" >
    <div class="col-xs-1"></div>
    	<div class="col-xs-10" id="commentArea">
    		 <c:forEach items="${comment }" var="comment"  >
    		 	<div class="panel panel-default no-shadow no-border">
    				<div class="panel-body  no-padding">
    						<div class="row">
    						<div class="col-xs-6 recruit-comment-left "><label class="label label-default ">${comment.groupMemberVO.memberVO.name}님</label>&nbsp; ${comment.regdate }</div>
    						<div class="col-xs-6 recruit-comment-right">
	    							<c:if test="${sessionScope.memberVO.memberEmail == comment.groupMemberVO.memberVO.memberEmail }">
		    							<button class="btn btn-xs btn-default cuBtn recruit-comment-right" value="${comment.groupCommentNo}" >수정</button>
		    							<button class="btn btn-xs btn-default cdBtn recruit-comment-right" value="${comment.groupCommentNo}" >삭제</button>
		    						</c:if>
		    				</div>
    						</div>
    						<div class="col-xm-12">
	    						<input type="text"  style="background-color: #ffffff" class="form-control ${comment.groupCommentNo}"   value="${comment.content}" readonly="readonly">
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
    						<div class="col-xs-6 recruit-comment-left"><label class="label label-default ">${sessionScope.memberVO.name}(${sessionScope.memberVO.memberEmail })님 댓글 달기</label></div>
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









<script>
function updateGroupPost(){
	$("#updateGroupPostForm").submit();
}

function deleteGroupPost(){
	if(confirm("정말 삭제하시겠습니까?")){
		$("#deleteGroupPostForm").submit();
	}
}

function goBack(){
	$("#goBackForm").submit();
}

$(document).ready(function(){
	//작성: 유동규
	//기능: 댓글 추가하기
	//로직: 1. 댓글 입력안의 공백, null 체크를 우선
	//		 2. ajax로 댓글 추가 
	//       3. reload() 함수를 통해 새로고침
	$("#registerCommentBtn").click(function(){
    	var comment = $("#registerComment").val();
    	var gpNo =${gpNo};
    	if(comment.trim().length == 0 || comment =="" || comment == null){
    		alert("댓글을 입력하세요");
    		return false;
    	}
    	
    	$.ajax({
    		type:"post",
			url:"${pageContext.request.contextPath}/ajax/registerGroupPostCommentAjax",
			data:"gpNo="+gpNo+"&comment="+comment,
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
			url:"${pageContext.request.contextPath}/ajax/deleteGroupPostCommentByCommentNoAjax",
			data: "commentNo="+commentNo,
			success:function(data){
				if(data == "true"){
					location.reload();
				}//if
			}//success
		})//ajax
    })//click
    
	//작성: 유동규
	//기능: 댓글 수정하기
	//로직: 1. 
	//	 	2. 
	//   	3. reload() 함수를 통해 새로고침
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
    			url:"${pageContext.request.contextPath}/ajax/updateGroupPostCommentByCommentNoAjax",
    			data:"commentNo="+commentNo+"&content="+content,
    			success:function(){
    				if(data == "true"){
    					location.reload();
    				}//if
    			}//success
    		})//ajax
    	}//else
    })//click
})//ready


</script>