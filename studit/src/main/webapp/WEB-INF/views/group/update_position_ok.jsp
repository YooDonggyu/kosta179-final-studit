<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
alert("팀장 위임 완료. \n스터디 통합 관리로 이동합니다.")
location.href="${pageContext.request.contextPath}/member/getMyPage?mypage";
</script>