<%@page import="java.util.ArrayList"%>
<%@page import="org.kosta.studit.model.vo.CompanyVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<section class="signup-section text-center" style="padding-bottom:150px; padding-top:150px; background-image:url(../resources/assets/img/com-main.png); background-size: 80% 100%; background-position: center; background-repeat: no-repeat;">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1><strong>스터디룸 검색</strong></h1>
				<h3><p>지금 당신에게 필요한 모든 스터디룸을 찾아보세요!</p></h3>
			</div>
		</div>
		<div class="row" style="padding-top: 20px;">
			<div class="col-md-12">
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
			</div>
		</div>
	</div>
</section>

<div class="container clearfix">
  <div class="row services">
    <div class="col-md-12">
      <h4 class="services-heading">LookUp</h4>
      <div class="row photo">
      	<form action="${pageContext.request.contextPath }/company/findDetailCompanyInfoByCompanyNo" method="post" id="imgForm">
      		<input type="hidden" id="companyNo" name="companyNo">
      		<div id="studyroomList">
      			<c:forEach items="${allCompanyList }" var="clist">
          			<div class="col-sm-4 ">
           				<div class="box box-services">
              				<img src="${pageContext.request.contextPath }/resources/upload/${clist.profilePath}" style="width: 300px; height: 200px" onclick="return goDetail(${clist.companyNo})">
              				<div>
              					<h4 class="heading">${clist.name }</h4>
              				</div>
              				<div id="showAddress" style="font-size: 14px; color: #AB8888; font-weight: bold;">${clist.addr1 } ${clist.addr2 } ${clist.addr3 }</div><br>
              				<p style="text-overflow: ellipsis; overflow: hidden; height: 120px;white-space: pre;">${clist.intro }</p>
            			</div>
          			</div>
         		</c:forEach>
        	</div>
        </form>
      </div>
    </div>
  </div>
</div>


<c:set var="companypb" value="${pagingBean}" />
<c:if test="${companypb.nextPage == true}">
	<input type="button" class="btn btn-primary" id="companypbBtn"  value="더보기" style="margin-bottom: 60px;">
</c:if>

<script type="text/javascript">
	$(document).ready(function(){
		var companyPage=1;
		var firstAddrSelectedVal="";
		var secondAddrSeleceteVal="";
		
		$("#companypbBtn").click(function(){
			companyPage += 1;
			$.ajax({
				type:"get",
				dataType: "json",
				url:"${pageContext.request.contextPath}/ajax/findCompanyListByConditionAjax",
				data:"addr1="+$("#firstAddress option:selected").val()+"&addr2="+$("#secondAddress option:selected").val()+"&addr3="+$("#thirdAddress option:selected").val()+"&keywordORhashtag="+$("#keywordORhashtag").val()+"&nowPage="+companyPage,
				success:function(data){
					var studyroom="";
				 	$.each(data.list, function(index, item) {
						studyroom+="<div class='col-sm-4'><div class='box box-services'><div>";
						studyroom+="<img src='${pageContext.request.contextPath }/resources/upload/";
						studyroom+=item.profilePath;
						studyroom+="' style='width: 300px; height: 200px' onclick='return goDetail(";
						studyroom+=item.companyNo;
						studyroom+=")'>";
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
					})//each 
					$("#studyroomList").append(studyroom);
				 	if(!data.pagingBean.nextPage){
				 		$("#companypbBtn").hide();
				 	}else{
				 		$("#companypbBtn").show();
				 	}
				}//success
			});//ajax
		});//click
		
		$("#firstAddress").change(function(){
			companyPage=1;
			$("#keywordORhashtag").val("");
			$.ajax({
				type: "get",
				dataType: "json",
				url:"${pageContext.request.contextPath}/ajax/findCompanyListByConditionAjax",
				data:"addr1="+$("#firstAddress option:selected").val(),
				success:function(result){
					var studyroom="";
						$.each(result.list, function(index, item){
							studyroom+="<div class='col-sm-4'><div class='box box-services'><div>";
							studyroom+="<img src='${pageContext.request.contextPath }/resources/upload/";
							studyroom+=item.profilePath;
							studyroom+="' style='width: 300px; height: 200px' onclick='return goDetail(";
							studyroom+=item.companyNo;
							studyroom+=")'>";
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

					$("#studyroomList").html(studyroom);
					if(result.pagingBean.nextPage){
				 		$("#companypbBtn").show();
				 	}else{
				 		$("#companypbBtn").hide();
				 	}
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
						
					})
					$("#secondAddress").html(temp);
					$("#thirdAddress").html("<option value='주소3'>선택</option>");
				}
			});//ajax
		});//firstAddress
		$("#secondAddress").change(function(){
			companyPage=1;
			$("#keywordORhashtag").val("");
			$.ajax({
				type: "get",
				dataType: "json",
				url:"${pageContext.request.contextPath}/ajax/findCompanyListByConditionAjax",
				data:"addr2="+$("#secondAddress option:selected").val(),
				success:function(result){
					var studyroom="";
					if(result.list==""){
						studyroom+=firstAddrSelectedVal;
					}else{
						$.each(result.list, function(index, item){
							studyroom+="<div class='col-sm-4'><div class='box box-services'><div>";
							studyroom+="<img src='${pageContext.request.contextPath }/resources/upload/";
							studyroom+=item.profilePath;
							studyroom+="' style='width: 300px; height: 200px' onclick='return goDetail(";
							studyroom+=item.companyNo;
							studyroom+=")'>";
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
					if(result.pagingBean.nextPage){
				 		$("#companypbBtn").show();
				 	}else{
				 		$("#companypbBtn").hide();
				 	}
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
					})
					$("#thirdAddress").html(temp);
				}
			});//ajax
		});//secondAddress
		
		$("#thirdAddress").change(function(){
			companyPage=1;
			$("#keywordORhashtag").val("");
			$.ajax({
				type: "get",
				dataType: "json",
				url:"${pageContext.request.contextPath}/ajax/findCompanyListByConditionAjax",
				data:"addr3="+$("#thirdAddress option:selected").val(),
				success:function(result){
					var studyroom="";
					if(result.list==""){
						studyroom+=secondAddrSelectedVal;
					}else{
						$.each(result.list, function(index, item){
							studyroom+="<div class='col-sm-4'><div class='box box-services'><div>";
							studyroom+="<img src='${pageContext.request.contextPath }/resources/upload/";
							studyroom+=item.profilePath;
							studyroom+="' style='width: 300px; height: 200px' onclick='return goDetail(";
							studyroom+=item.companyNo;
							studyroom+=")'>";
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
					if(result.pagingBean.nextPage){
				 		$("#companypbBtn").show();
				 	}else{
				 		$("#companypbBtn").hide();
				 	}
				}
			});//ajax
		});//thirdAddress
		
		$("#searchBtn").click(function(){
			companyPage=1;
			$.ajax({
				type: "get",
				dataType: "json",
				url:"${pageContext.request.contextPath}/ajax/findCompanyListByConditionAjax",
				data:"addr1="+$("#firstAddress option:selected").val()+"&addr2="+$("#secondAddress option:selected").val()+"&addr3="+$("#thirdAddress option:selected").val()+"&keywordORhashtag="+$("#keywordORhashtag").val(),
				success:function(result){
					var studyroom="";
					if(result.list==""){
						studyroom+="검색 결과가 없습니다!";
					}else{
						$.each(result.list, function(index, item){
							studyroom+="<div class='col-sm-4'><div class='box box-services'><div>";
							studyroom+="<img src='${pageContext.request.contextPath }/resources/upload/";
							studyroom+=item.profilePath;
							studyroom+="' style='width: 300px; height: 200px' onclick='return goDetail(";
							studyroom+=item.companyNo;
							studyroom+=")'>";
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
					if(result.pagingBean.nextPage){
				 		$("#companypbBtn").show();
				 	}else{
				 		$("#companypbBtn").hide();
				 	}
				}
			});//ajax
		});//searchBtn
		
		$("#keywordORhashtag").keypress(function(e){
			if(e.which == 13)
				$("#searchBtn").click();
		});
	});
	
	function goDetail(compNo){
		$("#companyNo").val(compNo);
		$("#imgForm").submit();
	}
</script>
