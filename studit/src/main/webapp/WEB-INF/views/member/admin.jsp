<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <style>
div.sc-table {
    font-size:100%;
}
th{
	text-align: center;
}
.MultiCarousel {
 	float: left; 
 	overflow: hidden; 
 	padding: 15px; 
 	width: 100%; 
 	height: 200px;
 	position:relative; 
}
.MultiCarousel .MultiCarousel-inner { transition: 1s ease all; float: left; }
.MultiCarousel .MultiCarousel-inner .item { float: left;}
.MultiCarousel .MultiCarousel-inner .item > div { text-align: center; padding:10px; margin:10px; background:#f1f1f1; color:#666;}
.MultiCarousel .MultiCarousel-inner .item > div:hover { background: white;}
.MultiCarousel .leftLst, .MultiCarousel .rightLst { position:absolute; border-radius:50%;top:calc(50% - 20px); }
.MultiCarousel .leftLst { left:0; }
.MultiCarousel .rightLst { right:0; }   
.MultiCarousel .leftLst.over, .MultiCarousel .rightLst.over { pointer-events: none; background:#ccc; }
</style>
    
    
    
<section class="no-padding-bottom">
<div class="container">
	<div class="row">
		<div style="padding-bottom: 40px;"> 
			<ul class="nav nav-tabs">
				<li class="active" style="width: 50%"><a data-toggle="tab" href="#company"><b>업체</b></a></li>
				<li style="width: 50%"><a data-toggle="tab" href="#member"><b>회원</b></a></li>
			</ul>
		
			<div class="tab-content">
				<div id="company" class="tab-pane fade in active">
				<c:choose>
					<c:when test="${empty comListVO.list}">
					<br><br><br><br><br> 업체가 없습니다. <br><br><br><br><br>
				</c:when>
				<c:otherwise>  
				<div class="col-sm-10" style="padding:5px;">
					<input type="text" placeholder="가게 이름 혹은 상태를 입력하세요" id="comSrch" name="comSrch"
							style="width: 100%; border-radius: 5px; padding: 5px;" >
				</div>
				<div class="col-sm-2" style="padding:5px;">
					<input type="button" class="btn btn-sm-warning"  value="검색" id="srchBtn"
							style="width: 100%; border-radius: 3px; padding: 5px; background-color: white; border-color: #FFBC9B; " >
				</div>
					<table class="table table-hover">
						<thead>
							<tr>
								<th>업체이름</th>
								<th>주소</th>
								<th>전화번호</th>
								<th>사업자번호</th>
								<th>요청날짜</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody id="comAjaxResult">
							<c:forEach items="${comListVO.list }" var="list">
								<tr>
									<%-- <td>${list.companyNo}</td> --%>
									<td>${list.name }</td>
									<td style="font-size: 13px;">${list.primaryAddr } <br>  ${list.detailAddr }</td>
									<td>${list.tel}</td>
									<td>${list.license}</td>
									<td>${list.regdate}</td>
									<td>
										<select class="readyCompany">
											<option value="${list.companyNo}" <c:if test="${list.state == '대기'}">selected</c:if>>대기</option>
											<option value="${list.companyNo}" <c:if test="${list.state == '승인'}">selected</c:if>>승인</option>
											<option value="${list.companyNo}" <c:if test="${list.state == '거절'}">selected</c:if>>거절</option>
										</select>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<c:set var="pb" value="${comListVO.pagingBean}" />
					<ul class="pagination" id="divData">
						<c:if test="${pb.previousPageGroup}">	
							<li><a href="#" onclick="return ajaxComSrch(${pb.startPageOfPageGroup-1})" >&laquo;</a></li>
						</c:if>
						<c:forEach var="i" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
							<c:choose>
								<c:when test="${pb.nowPage!=i}">
									<li><a href="javascript:void(0);" onclick="return ajaxComSrch(${i})">${i}</a></li> 
								</c:when>
								<c:otherwise>
									<li class="disabled"><a href="#" >${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${pb.nextPageGroup}">	
							<li><a href="#" onclick="return ajaxComSrch(${pb.endPageOfPageGroup+1})">&raquo;</a></li>
						</c:if>
					</ul>	 		
				</c:otherwise>
				</c:choose> 
				</div><%-- tab1-1 --%>
			
			
			
				<div id="member" class="tab-pane fade">
				<c:choose>
					<c:when test="${empty memberListVO.list}">
						<br><br><br><br><br> 사용자가 없습니다. <br><br><br><br><br>
					</c:when>
				<c:otherwise>  
				<div class="col-sm-10" style="padding:5px;">
					<input type="text" placeholder="회원 이메일 혹은 이름을 입력하세요" id="memberSrch" name="memberSrch"
							style="width: 100%; border-radius: 5px; padding: 5px;" >
				</div>
				<div class="col-sm-2" style="padding:5px;">
					<input type="button" class="btn btn-sm-warning"  value="검색" id="memberSrchBtn"
							style="width: 100%; border-radius: 3px; padding: 5px; background-color: white; border-color: #FFBC9B; " >
				</div>
					<table class="table table-hover">
						<thead>
							<tr>
								<th>이메일</th>
								<th>이름</th>
								<th>주소</th>
								<th>번호</th>
								<th>가입날짜</th>
								<th>권한</th>
							</tr>
						</thead>
						<tbody id="memberAjaxResult">
							<c:forEach items="${memberListVO.list }" var="list">
								<tr>
									<td>${list.memberEmail }</td>
									<td>${list.name }</td>
									<td style="font-size: 13px;">${list.primaryAddr } <br>  ${list.detailAddr }</td>
									<td>${list.phone}</td>
									<td>${list.regdate}</td>
									<td>
										<c:forEach items="${memberListVO.map}" var="pmap">
											<c:if test="${pmap.key == list.memberEmail}">
												<h5><span class="label label-warning stopMember"  data-email="${list.memberEmail}">${pmap.value}</span></h5>
											</c:if>
										</c:forEach>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<c:set var="pb" value="${memberListVO.pagingBean}" />
					<ul class="pagination" id="divMemberData">
						<c:if test="${pb.previousPageGroup}">	
							<li><a href="#" onclick="return ajaxMemberFunc(${pb.startPageOfPageGroup-1})" >&laquo;</a></li>
						</c:if>
						<c:forEach var="i" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
							<c:choose>
								<c:when test="${pb.nowPage!=i}">
									<li><a href="javascript:void(0);" onclick="return ajaxMemberFunc(${i})">${i}</a></li> 
								</c:when>
								<c:otherwise>
									<li class="disabled"><a href="#" >${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${pb.nextPageGroup}">	
							<li><a href="#" onclick="return ajaxMemberFunc(${pb.endPageOfPageGroup+1})">&raquo;</a></li>
						</c:if>
					</ul>	 		
				</c:otherwise>
				</c:choose> 
				</div><%-- tab2 --%>
			</div><%--tab-content --%>
			
			
		</div><%--col --%>
	</div><%--row --%>
	</div><%--container --%>
	<input type="hidden" id="hiddenMemberSrch"  value="">
	<input type="hidden" id="hiddenComSrch"  value="">
	<form action="${pageContext.request.contextPath}/company/updateCompanyCondition" method="post" id="stateUpdateForm">
		<input type="hidden" id="hiddenCompanyNo"  name="companyNo" value="">
		<input type="hidden" id="hiddenCompanyState"  name="state" value="">
	</form>
	<form action="${pageContext.request.contextPath}/member/updateMemberState" method="post" id="memberStateUpdateForm">
		<input type="hidden" id="hiddenMemberEmail" name="memberEmail" value="">
	</form>
	<form action="${pageContext.request.contextPath}/member/deleteMemberState" method="post" id="memberStateDeleteForm">
		<input type="hidden" id="hiddenEmail" name="memberEmail" value="">
	</form>
</section>


<script>

$(document).ready(function(){
		//검색버튼
		$("#srchBtn").click(function(){
			$("#hiddenComSrch").val( $("#comSrch").val()); 
	 		ajaxFunc(1)
		})//srchBtn
		
		$("#memberSrchBtn").click(function(){
			$("#hiddenMemberSrch").val($("#memberSrch").val());
			ajaxMemberFunc(1)
		})//memberSrchBtn
		
		
		//승인 및 거절
		$(document).on("change",".readyCompany", function(){ 
			var state =  $(this).find('option:selected').text();
			var companyNo = $(this).find('option:selected').val();
				if(confirm(state+"(으)로 변경 하시겠습니까?")){
 				$("#hiddenCompanyNo").val(companyNo);
 				$("#hiddenCompanyState").val(state);
					$("#stateUpdateForm").submit();
				}else{
					location.reload();
				}
		})//readyCompany
		
		$(document).on("click",".stopMember", function(){
			var email = $(this).data("email");
			var posList = $(this).text();
			if(posList.includes('정지')){
				if(confirm("이미 정지된 회원입니다. 다시 회원으로 만드시겠습니까?")){
					$("#hiddenEmail").val(email);
					$("#memberStateDeleteForm").submit();
				}else{
					return false;
				}
			}else{
				if(confirm(email+"님을 정지시키겠습니까?")){
					$("#hiddenMemberEmail").val(email);
					$("#memberStateUpdateForm").submit();
				}else{
					return false;
				}
			}
		})//stopMember
	})//document

	var comNowPage = 1;
	//paging
	function ajaxComSrch(nowPage){
		ajaxFunc(nowPage);
	}
 	function ajaxFunc(nowPage){
 		comNowPage = nowPage;
 		comSrch = $("#hiddenComSrch").val();
 		$.ajax({
 			type:"post",
 			url: "${pageContext.request.contextPath}/ajax/getCompanyListForAdmin",
 			data:"nowPage="+comNowPage+"&comSrch="+comSrch,
 			success:function(data){
 				$("#comAjaxResult").empty();
 				var temp="";
			 	$.each(data.list, function(index, item) {
					temp += 
						"<tr>"+
						"<td>"+item.name+"</td>"+
						"<td style='font-size: 13px;'>"+item.primaryAddr+"<br>"+item.detailAddr+"</td>"+
						"<td>"+item.tel+"</td>"+
						"<td>"+item.license+"</td>"+ 
						"<td>"+item.regdate+"</td>"+
						"<td><select class='readyCompany'>";
					if(item.state == '대기'){
						temp += 
							"<option value='"+item.companyNo+"' selected='selected'>대기</option>"+
							"<option value='"+item.companyNo+"' >승인</option>"+
							"<option value='"+item.companyNo+"' >거절</option>";
					}else if(item.state == '승인'){
						temp += 
							"<option value='"+item.companyNo+"' >대기</option>"+
							"<option value='"+item.companyNo+"' selected='selected'>승인</option>"+
							"<option value='"+item.companyNo+"' >거절</option>";
					}else{
						temp += 
							"<option value='"+item.companyNo+"' >대기</option>"+
							"<option value='"+item.companyNo+"' >승인</option>"+
							"<option value='"+item.companyNo+"' selected='selected'>거절</option>";
					}
					temp += "</select></td></tr>"; 
				})//each 
				$("#comAjaxResult").append(temp);
				
				//paging
				//paging 지우기
			 	$("#divData").empty();
			 	var pb = data.pagingBean;
			 	//이전 그룹이 있으면
			 	if(pb.previousPageGroup){
			 		$("#divData").append('<li><a href="#" onclick="return ajaxComSrch('+pb.startPageOfPageGroup-1+')">&laquo;</a></li>');
			 	}
			 	//가운데 번호 그리기
			 	for(var i = pb.startPageOfPageGroup; i<= pb.endPageOfPageGroup; i++){
			 		if(i !=nowPage){
			 			$("#divData").append('<li><a href="#" onclick="return ajaxComSrch('+i+')">'+i+'</a></li>');
			 		}else{
			 			$("#divData").append('<li class="disabled"><a href="#">'+i+'</a></li>');
			 		}
			 	} 
			 	//다음 그룹이 있으면
			 	if(pb.nextPageGroup){
			 		$("#divData").append('<li><a href="#" onclick="return ajaxComSrch('+pb.startPageOfPageGroup+1+')">&raquo;</a></li>');
			 	}
 			}//success
 		})//ajax
	 }//com-function

	 
	 
	 
	 var memberNowPage = 1;

	 function ajaxMemberFunc(nowPage){
		 memberNowPage = nowPage;
	 		memberSrch = $("#hiddenMemberSrch").val();
	 		$.ajax({
	 			type:"post",
	 			url: "${pageContext.request.contextPath}/ajax/getMemberListForAdmin",
	 			data:"nowPage="+memberNowPage+"&memberSrch="+memberSrch,
	 			success:function(data){
	 				$("#memberAjaxResult").empty();
	 				var str="";
				 	$.each(data.list, function(index, item) {
						str = 
							"<tr>"+
							"<td>"+item.memberEmail+"</td>"+
							"<td>"+item.name+"</td>"+ 
							"<td style='font-size: 13px;'>"+item.primaryAddr+"<br>"+item.detailAddr+"</td>"+
							"<td>"+item.phone+"</td>"+
							"<td>"+item.regdate+"</td>"+
							"<td>";
							$.map(data.map, function(value, i){
								if(item.memberEmail == i){
									str +="<h5><span class='label label-warning stopMember'>"+value+"</span></h5>";
								}
							})
							str += "</td>";
							
					$("#memberAjaxResult").append(str);
					})//each 
					
					//paging
					//paging 지우기
				 	$("#divMemberData").empty();
				 	var pb = data.pagingBean;
				 	//이전 그룹이 있으면
				 	if(pb.previousPageGroup){
				 		$("#divMemberData").append('<li><a href="#" onclick="return ajaxMemberFunc('+pb.startPageOfPageGroup-1+')">&laquo;</a></li>');
				 	}
				 	//가운데 번호 그리기
				 	for(var i = pb.startPageOfPageGroup; i<= pb.endPageOfPageGroup; i++){
				 		if(i !=nowPage){
				 			$("#divMemberData").append('<li><a href="#" onclick="return ajaxMemberFunc('+i+')">'+i+'</a></li>');
				 		}else{
				 			$("#divMemberData").append('<li class="disabled"><a href="#">'+i+'</a></li>');
				 		} 
				 	} 
				 	//다음 그룹이 있으면
				 	if(pb.nextPageGroup){
				 		$("#divMemberData").append('<li><a href="#" onclick="return ajaxMemberFunc('+pb.startPageOfPageGroup+1+')">&raquo;</a></li>');
				 	}
	 			}//success
	 		})//ajax
		 }//com-function
	 
 	
</script>








