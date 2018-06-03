<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<input type="text" value="${gpNo}" readonly="readonly">
<input type="text" value="${glist.title}" readonly="readonly">
<input type="text" value="${glist.groupMemberVO.memberVO.name}/${glist.groupMemberVO.memberVO.memberEmail }" readonly="readonly">
<input type="text" value="${glist.regdate}" readonly="readonly">
<input type="text" value="${glist.hit}" readonly="readonly"> <br>

<form method="post" action="${pageContext.request.contextPath}/group/findDetailGroupPostByPostNo" id="goBackForm">
	<input type="hidden" id="gpNo" name="gpNo" value="${gpNo}">
	<input type="hidden" id="nowPage" name="nowPage" value="${nowPage }">
</form>
<form method="post" action="${pageContext.request.contextPath }/group/updateGroupPost" id="updateGroupPostForm">
	<input type="hidden" name="groupPostNo" value="${gpNo }">
	<input type="hidden" id="nowPage" name="nowPage" value="${nowPage }">
	<pre><textarea style="width:100%; height: 250px;" id="content" name="content">${glist.content}</textarea></pre>
</form>
<hr>

<input type="button" value="수정완료" onclick="update()">
<input type="button" value="수정취소" onclick="goDetail(${gpNo})">

<script>
function update(){
	$("#updateGroupPostForm").submit();
}

function goDetail(gpNo){
	$("#goBackForm").submit();
}
</script>