<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form method="post" action="${pageContext.request.contextPath }/group/findGroupBoard" id="goList"></form>
<script>
	alert("삭제되었습니다!");
	$("#goList").submit();
</script>