<%@page import="java.util.ArrayList"%>
<%@page import="org.kosta.studit.model.vo.CompanyVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(document).ready(function(){
		var firstAddrSelectedVal="";
		var secondAddrSeleceteVal="";
		$("#firstAddress").change(function(){
			$("#keywordORhashtag").val("");
			$.ajax({
				type: "get",
				dataType: "json",
				url:"${pageContext.request.contextPath}/ajax/findCompanyListByAddressAjax",
				data:"addr1="+$("#firstAddress option:selected").val() ,
				success:function(result){
					var studyroom="";
					if(result==""){
						studyroom+="<c:forEach items='${allCompanyList }' var='clist'>";
						studyroom+="<div class='hidden'>${pageContext.request.contextPath }/resources/upload/업체1.JPG</div>";
						studyroom+="<div class='col-sm-4'><div class='box box-services'><div>";
						studyroom+="<img src='${pageContext.request.contextPath }/resources/upload/업체1.JPG' style='width: 300px; height: 200px'>";
						studyroom+="</div><div><h4 cl ass='heading'>${clist.name }</h4></div>";
						studyroom+="<div id='showAddress' style='font-size: 14px; color: #AB8888; font-weight: bold;'>${clist.addr1 } ${clist.addr2 } ${clist.addr3 }</div>";
						studyroom+="<p>${clist.intro }</p></div></div></c:forEach>";
					}else{
						$.each(result, function(index, item){
							studyroom+="<div class='hidden'>${pageContext.request.contextPath }/resources/upload/업체1.JPG</div>";
							studyroom+="<div class='col-sm-4'><div class='box box-services'><div>";
							studyroom+="<img src='${pageContext.request.contextPath }/resources/upload/업체1.JPG' style='width: 300px; height: 200px'>";
							studyroom+="</div><div><h4 class='heading'>";
							studyroom+=item.name;
							studyroom+="</h4></div><div id='showAddress' style='font-size: 14px; color: #AB8888; font-weight: bold;'>";
							studyroom+=item.addr1;
							studyroom+=" ";
							studyroom+=item.addr2;
							studyroom+=" ";
							studyroom+=item.addr3;
							studyroom+="</div><br><p>";
							studyroom+=item.intro;
							studyroom+="</p></div></div>";
						})
					}
					$("#studyroomList").html(studyroom);
					firstAddrSelectedVal="";
					firstAddrSelectedVal+=studyroom;
				}
			});//ajax
			
			$.ajax({
				type: "get",
				dataType: "json",
				url:"${pageContext.request.contextPath}/ajax/findSecondAddressListByFirstAddressName",
				data:"addr1="+$("#firstAddress option:selected").val(),
				success:function(result){
					var temp="<option value='주소2'>선택</option>";
					$.each(result, function(index, item){
						temp+="<option value='";
						temp+=item;
						temp+="'>";
						temp+=item;
						temp+="</option>";
						
						//$("#secondAddress").append("<option value='"+item+"'>"+item+"</option>");			
					})
					$("#secondAddress").html(temp);
					$("#thirdAddress").html("<option value='주소3'>선택</option>");
				}
			});//ajax
		});//firstAddress
		$("#secondAddress").change(function(){
			$("#keywordORhashtag").val("");
			$.ajax({
				type: "get",
				dataType: "json",
				url:"${pageContext.request.contextPath}/ajax/findCompanyListByAddressAjax",
				data:"addr2="+$("#secondAddress option:selected").val(),
				success:function(result){
					var studyroom="";
					if(result==""){
						studyroom+=firstAddrSelectedVal;
					}else{
						$.each(result, function(index, item){
							studyroom+="<div class='hidden'>${pageContext.request.contextPath }/resources/upload/업체1.JPG</div>";
							studyroom+="<div class='col-sm-4'><div class='box box-services'><div>";
							studyroom+="<img src='${pageContext.request.contextPath }/resources/upload/업체1.JPG' style='width: 300px; height: 200px'>";
							studyroom+="</div><div><h4 class='heading'>";
							studyroom+=item.name;
							studyroom+="</h4></div><div id='showAddress' style='font-size: 14px; color: #AB8888; font-weight: bold;'>";
							studyroom+=item.addr1;
							studyroom+=" ";
							studyroom+=item.addr2;
							studyroom+=" ";
							studyroom+=item.addr3;
							studyroom+="</div><br><p>";
							studyroom+=item.intro;
							studyroom+="</p></div></div>";
						})
					}
					$("#studyroomList").html(studyroom);
					secondAddrSelectedVal="";
					secondAddrSelectedVal+=studyroom;
				}
			});//ajax
			
			$.ajax({
				type: "get",
				dataType: "json",
				url:"${pageContext.request.contextPath}/ajax/findThirdAddressListBySecondAddressName",
				data:"addr2="+$("#secondAddress option:selected").val(),
				success:function(result){
					var temp="<option value='주소3'>선택</option>";
					$.each(result, function(index, item){
						temp+="<option value='";
						temp+=item;
						temp+="'>";
						temp+=item;
						temp+="</option>";
						//$("#thirdAddress").append("<option value='"+item+"'>"+item+"</option>");			
					})
					$("#thirdAddress").html(temp);
				}
			});//ajax
		});//secondAddress
		
		$("#thirdAddress").change(function(){
			$("#keywordORhashtag").val("");
			$.ajax({
				type: "get",
				dataType: "json",
				url:"${pageContext.request.contextPath}/ajax/findCompanyListByAddressAjax",
				data:"addr3="+$("#thirdAddress option:selected").val(),
				success:function(result){
					var studyroom="";
					if(result==""){
						studyroom+=secondAddrSelectedVal;
					}else{
						$.each(result, function(index, item){
							studyroom+="<div class='hidden'>${pageContext.request.contextPath }/resources/upload/업체1.JPG</div>";
							studyroom+="<div class='col-sm-4'><div class='box box-services'><div>";
							studyroom+="<img src='${pageContext.request.contextPath }/resources/upload/업체1.JPG' style='width: 300px; height: 200px'>";
							studyroom+="</div><div><h4 class='heading'>";
							studyroom+=item.name;
							studyroom+="</h4></div><div id='showAddress' style='font-size: 14px; color: #AB8888; font-weight: bold;'>";
							studyroom+=item.addr1;
							studyroom+=" ";
							studyroom+=item.addr2;
							studyroom+=" ";
							studyroom+=item.addr3;
							studyroom+="</div><br><p>";
							studyroom+=item.intro;
							studyroom+="</p></div></div>";
						})
					}
					$("#studyroomList").html(studyroom);
				}
			});//ajax
		});//thirdAddress
		
		$("#searchBtn").click(function(){
			$.ajax({
				type: "get",
				dataType: "json",
				url:"${pageContext.request.contextPath}/ajax/findCompanyListByAddressAndKeywordAndHashTagAjax",
				data:"addr1="+$("#firstAddress option:selected").val()+"&addr2="+$("#secondAddress option:selected").val()+"&addr3="+$("#thirdAddress option:selected").val()+"&keywordORhashtag="+$("#keywordORhashtag").val(),
				success:function(result){
					var studyroom="";
					if(result==""){
						studyroom+="검색 결과가 없습니다!";
					}else{
						$.each(result, function(index, item){
							studyroom+="<div class='hidden'>${pageContext.request.contextPath }/resources/upload/업체1.JPG</div>";
							studyroom+="<div class='col-sm-4'><div class='box box-services'><div>";
							studyroom+="<img src='${pageContext.request.contextPath }/resources/upload/업체1.JPG' style='width: 300px; height: 200px'>";
							studyroom+="</div><div><h4 class='heading'>";
							studyroom+=item.name;
							studyroom+="</h4></div><div id='showAddress' style='font-size: 14px; color: #AB8888; font-weight: bold;'>";
							studyroom+=item.addr1;
							studyroom+=" ";
							studyroom+=item.addr2;
							studyroom+=" ";
							studyroom+=item.addr3;
							studyroom+="</div><br><p>";
							studyroom+=item.intro;
							studyroom+="</p></div></div>";
						})
					}
					$("#studyroomList").html(studyroom);
				}
			});//ajax
		});
	});
</script>
<section class="signup-section text-center no-padding-bottom">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h3>스터디룸 검색</h3>
				<p class="lead text-gray-light">지금 당신에게 필요한 모든 스터디룸을 찾아보세요!</p>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<form
					action="${pageContext.request.contextPath}/recruit/findRecruitPostByCategoryAndKeyword"
					method="post">
					<table style="width: 600px; margin: 0 auto">
						<tr>
							<td>
								<select id="firstAddress" class="form-control">
									<option value="주소1">선택</option>
									<c:forEach items="${firstAddrList}" var="addr1">
										<option value="${addr1}">${addr1}</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<select id="secondAddress" class="form-control">
									<option value="주소2">선택</option>
								</select>
							</td>
							<td>
								<select id="thirdAddress" class="form-control">
									<option value="주소3">선택</option>
								</select>
							</td>
							<td>
								<input id="keywordORhashtag" type="text" class="form-control" placeholder="키워드&해쉬태그 입력" >
							</td>
							<td>
								<input type="button" id="searchBtn" value="검색" class="btn btn-primary">
							</td>
						</tr>
						<tr>
							<td><div id="hashTagView"></div></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</section>

      <section id="integrations" class="section-gray">
        <div class="container clearfix">
          <div class="row services">
            <div class="col-md-12">
              <h4 class="services-heading">Integrations</h4>
              <div class="row photo">
              	<div id="studyroomList">
	              	<c:forEach items="${allCompanyList }" var="clist">
	              		<div class="hidden">${pageContext.request.contextPath }/resources/upload/업체1.JPG</div>
		                <div class="col-sm-4">
		                  <div class="box box-services">
		                    <div>
		                    	<img src="${pageContext.request.contextPath }/resources/upload/업체1.JPG" style="width: 300px; height: 200px">
		                    </div>
		                    <div>
		                    	<h4 class="heading">${clist.name }</h4>
		                    </div>
		                    <div id="showAddress" style="font-size: 14px; color: #AB8888; font-weight: bold;">${clist.addr1 } ${clist.addr2 } ${clist.addr3 }</div><br>
		                    <p>${clist.intro }</p>
		                  </div>
		                </div>
	                </c:forEach>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>


<script>
	$(document).ready(function() {
		//작성: 김유란
		//기능: 대분류 번호에 따라 소분류 목록를 가져와 보여주기
		//로직: 대분류 셀렉트 박스의 선택값이 변경될 때마다 셀렉트 옵션의 value인 대분류 번호가 전송되고
		//	    번호로 검색한 소분류 목록이 로드되어 소분류 체크박스 메뉴가 변경된다.
		$("#bigCategory").change(function() {
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath}/ajax/getSmallCategoryList",
				dataType:"json",
				data:"bigCategoryNo="+$("#bigCategory").val(),
				success:function(data){
					var result = "";
					$.each(data, function(index, item) {
						result+= "<li>"
										+"<a href='#' class='dropdown-item'>"
										+"<input type='checkbox' name='category' value="+item.smallCategoryNo+">"
										+item.name
										+"</a>"
										"</li>";
					})//each
					$("#checkbox").html(result);
				}//success
			})//ajax
		})//change
		
	})//ready


	
	//작성: 김유란
	//기능: 상세글 보기로 이동
	//로직: 테이블의 특정 행을 클릭하면 글번호가 전송되어 해당 글의 상세페이지로 이동한다. 
	function findDetailRecruitPostInfoByRecruitNo(recruitNo) {
		location.href=
			"${pageContext.request.contextPath }/recruit/findDetailRecruitPostInfoByRecruitNo?recruitNo="+recruitNo;
	}
</script>