<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>

div.sc-table {
    font-size: 60%;
}
</style>
<section>
<div class="col-sm-2" ></div>
<div class="col-sm-4 sc-table">
<table class="table table-hover">
	<thead>
		<tr>
			<th>No</th>
			<th>Category</th>
			<th>Location</th>
			<th>Title</th>
			<th>Writer</th>
			<th>regDate</th>
			<th>Status</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${studyConditionList.list }" var="list">
			<tr>
				<td>${list.studyConditionNo }</td>
				<td>${list.recruitPostVO.smallCategoryVO.name }</td>
				<td>${list.recruitPostVO.location }</td>
				<td>${list.recruitPostVO.title }</td>
				<td>${list.memberVO.name }</td>
				<td>${list.regdate}</td>
				<td><input type="button" value="${list.state }" class="btn btn-secondary"></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div class="pagingInfo">
	<%-- 코드를 줄이기 위해 pb 변수에 pagingBean을 담는다. --%>
	<c:set var="pb" value="${studyConditionList.pagingBean}"></c:set>
	<!-- 
			step2 1) 이전 페이지 그룹이 있으면 화살표 보여준다
				   		페이징빈의 previousPageGroup 이용 
				   2)  이미지에 이전 그룹의 마지막 페이지번호를 링크한다. 
				   	    hint)   startPageOfPageGroup-1 하면 됨 		 
	 -->  
	<!-- step1. 1)현 페이지 그룹의 startPage부터 endPage까지 forEach 를 이용해 출력한다
				   2) 현 페이지가 아니면 링크를 걸어서 서버에 요청할 수 있도록 한다.
				      현 페이지이면 링크를 처리하지 않는다.  
				      PagingBean의 nowPage
				      jstl choose 를 이용  
				      예) <a href="DispatcherServlet?command=list&pageNo=...">				   
	 -->	
		<ul class="pagination">
			<c:if test="${pb.previousPageGroup}">	
				<li><a href="${pageContext.request.contextPath}/member/getMyPage?pageNo=${pb.startPageOfPageGroup-1}">&laquo;</a></li>
			</c:if>
			<c:forEach var="i" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
				<c:choose>
					<c:when test="${pb.nowPage!=i}">
						<li><a href="${pageContext.request.contextPath}/member/getMyPage?pageNo=${i}">${i}</a></li> 
					</c:when>
					<c:otherwise>
						<li class="active"><a href="#" >${i}</a></li>
					</c:otherwise>
				</c:choose>
				&nbsp;
			</c:forEach>
			<c:if test="${pb.nextPageGroup}">	
				<li>
					<a href="${pageContext.request.contextPath}/member/getMyPage=${pb.endPageOfPageGroup+1}">&raquo;</a>
				</li>
			</c:if>
		</ul>	 		
	</div> 
</div>
</section>
