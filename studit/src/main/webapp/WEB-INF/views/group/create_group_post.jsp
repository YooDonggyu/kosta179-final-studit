<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 목록으로 가기 폼 -->
<form method="post" action="${pageContext.request.contextPath}/group/findGroupBoard" id="goList">
	<input type="hidden" value="${nowPage }" name="nowPage">
</form>
<div class="comtainer" align="center">
<div class="col-sm-3" ></div>
	<div class="col-sm-6">
        <form action="${pageContext.request.contextPath}/group/createGroupPost" class="form-horizontal" role="form" onsubmit="return check()">
            <div style="padding-top: 30px; padding-bottom: 20px;"><h3>게시글 작성</h3></div>
            <div class="form-group">
                <label for="title" class="col-sm-3 control-label formCategory">제목</label>
                <div class="col-sm-9">	
                    <input type="text" id="title" name="title" placeholder="제목을 입력하세요" class="form-control" maxlength="33" autofocus>
                </div>
            </div>
            
            <div class="form-group">
                <label for="content" class="col-sm-3 control-label formCategory" >내용</label>
                <div class="col-sm-9">
                    <pre><textarea style="width:100%; resize:none; height: 250px;" placeholder="내용을 입력하세요!" id="content" name="content"></textarea></pre>
                </div>
            </div>
            
            <div class="form-group">
                <div class="col-sm-9 col-sm-offset-3">
                    <input type="submit" value="작성"> &nbsp;
                    <input type="button" value="목록" onclick="return goBack()">
                </div>
            </div>
        </form> <!-- /form -->
    </div> <!-- ./container -->
<div class="col - sm- 3" ></div>
</div>
<style>
.formCategory{
	font-weight: bold;
}
</style>

<script>
function goBack(){
	$("#goList").submit();
}

function check(){
	if($("#title").val()==""){
		alert("제목을 입력하세요!");
		$("#title").focus();
		return false;
	}
	if($("#title").val().length > 33){
		alert("제목은 33글자까지 가능합니다.");
		return false;
	}
	if($("#content").val()==""){
		alert("내용을 입력하세요!"); 
		return false;
	}
	if($("#content").val().length > 1332){
		alert("내용은 1300글자까지 가능합니다. 현재 "+$("#content").val().length+"글자 입니다."); 
		return false;
	}
	return true;
}
</script>








