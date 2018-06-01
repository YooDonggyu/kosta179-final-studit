<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	alert('스터디룸 정보가 정상적으로 수정되었습니다.');
	location.href='${pageContext.request.contextPath}/company/StudyRoomInfoView?studyRoomNo=${srno}&memberEmail=${memberVO.memberEmail}';
</script>