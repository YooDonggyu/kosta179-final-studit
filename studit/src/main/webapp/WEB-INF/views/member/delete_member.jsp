<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	$(document).ready(function(){
		var study=$("#studyFlag").val().trim();
		var studyRoom=$("#studyRoomFlag").val().trim();
		var studyGroup=$("#studyGroupFlag").val().trim();
		var company=$("#companyFlag").val().trim();
		
		if(study=="탈퇴가능"&&studyRoom=="탈퇴가능"&&studyGroup=="탈퇴가능"&&company=="탈퇴가능"){
			$("#deleteMemberBtn").prop("disabled", true);
		}else{
			$("#deleteMemberBtn").prop("disabled", true);			
		}
	});
	
	function deleteMemeber(memberEmail){
		location.href="${pageContext.request.contextPath}/deleteMember?memberEmail="+memberEmail;
	}
</script>

	<c:set var="waitStudyCount" value="${requestScope.deleteMemberInfo.waitStudyCount }" />
	<c:set var="waitStudyRoomCount" value="${requestScope.deleteMemberInfo.waitStudyRoomCount }" />
	<c:set var="myLeadStudyGroupHasMemberCount" value="${requestScope.deleteMemberInfo.myLeadStudyGroupHasMemberCount }" />
	<c:set var="myLeadStudyGroupHasMemberList" value="${requestScope.deleteMemberInfo.myLeadStudyGroupHasMemberList }" />
	<c:set var="isCompany" value="${requestScope.deleteMemberInfo.isCompany }" />
	<c:set var="waitReservation" value="${requestScope.deleteMemberInfo.waitReservation }" />
	
<section class="signup-section text-center no-padding-bottom">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h3>회원탈퇴</h3>
				<p class="lead text-gray-light">회원 탈퇴를 위해서는 아래의 조건에 충족해야 합니다.</p>
			</div>   
		</div> 
	</div>
</section>

<section id="features" class="section">
	<div class="container">
	<table class="table table-hover">
		<thead>
			<tr>
				<th style="text-align: center">검사영역</th>
				<th style="text-align: center">세부사항</th>
				<th style="text-align: center">가능여부</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>스터디</td>
				<c:choose>
					<c:when test="${waitStudyCount>0 }">
						<td>
							신청중인 스터디가 ${waitStudyCount }개 있습니다.
						</td>
						<td id="studyFlag">
							탈퇴불가
						</td>
					</c:when>
					<c:otherwise>
						<td>
							-
						</td>
						<td id="studyFlag">
							탈퇴가능
						</td>
					</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<td>스터디룸</td>
				<c:choose>
					<c:when test="${waitStudyRoomCount>0 }">
						<td>
							승인대기중인 스터디룸 예약이 ${waitStudyRoomCount}개 있습니다.
						</td>
						<td id="studyRoomFlag">
							탈퇴불가
						</td>
					</c:when>
					<c:otherwise>
						<td>
							-
						</td>
						<td id="studyRoomFlag">
							탈퇴가능
						</td>
					</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<td>스터디그룹</td>
				<c:choose>
					<c:when test="${myLeadStudyGroupHasMemberCount>0 }">
						<td>
							팀장 위임이 가능한 스터디 그룹이 ${myLeadStudyGroupHasMemberCount}개 있습니다.<br>
							<c:forEach var="myLeadStudyGroupHasMemberList" items="${myLeadStudyGroupHasMemberList }" varStatus="status" >
								${status.count }. ${myLeadStudyGroupHasMemberList.NAME }<Br>
							</c:forEach>
						</td>
						<td id="studyGroupFlag">
							탈퇴불가
						</td>
					</c:when>
					<c:otherwise>
						<td>
							-
						</td>
						<td id="studyGroupFlag">
							탈퇴가능
						</td>
					</c:otherwise>
				</c:choose>
			</tr>
			<c:choose>
				<c:when test="${isCompany }">
					<tr>
						<td>업체</td>
						<c:choose>
							<c:when test="${waitReservation>0}">
								<td>
									처리해야할 예약건수가 ${waitReservation }건 있습니다.
								</td>
								<td id="companyFlag">
									탈퇴불가
								</td>
							</c:when>
							<c:otherwise>
								<td>
									-
								</td>
								<td id="companyFlag">
									탈퇴가능
								</td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<td>업체</td>
						<td>업체가 아닙니다.</td>
						<td>탈퇴가능</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	<input type="button" value="회원탈퇴" style="margin-bottom: 40px;"  id="deleteMemberBtn" onclick="deleteMemeber(${sessionScope.memberVO.memberEmail})">
</div>
</section>