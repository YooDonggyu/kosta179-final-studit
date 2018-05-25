<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
    
    
    <section>
	<form class="updateRecruitForm" action="${pageContext.request.contextPath}/recruit/updateRecruitPostInfoByRecruitNo" 
	method="post" onsubmit="return checkSubmit()">
	  <!-- Category -->
	  <select name="smallCategoryVO.bigCategoryVO.bigCategoryNo" id="bigCategory" class="form-control">
 		<option value="">대분류</option> 
				<c:forEach	items="${bigCategoryList}" var="bc">
					<c:choose>
						<c:when test="${recruitInfo.detail.smallCategoryVO.bigCategoryVO.name == bc.name}">
							<option value="${bc.bigCategoryNo}" selected="selected">${bc.name}</option>
						</c:when>
						<c:otherwise>
							<option value="${bc.bigCategoryNo}">${bc.name}</option> 
						</c:otherwise>
					</c:choose>
				</c:forEach>
	  </select>  
	  <select name="smallCategoryVO.smallCategoryNo" id="smallCategory" class="form-control">
 			<option value="">소분류</option> 
				<c:forEach	items="${smallCategoryList}" var="sc">
					<c:choose>
						<c:when test="${recruitInfo.detail.smallCategoryVO.name == sc.name}">
							<option value="${sc.smallCategoryNo}" selected="selected">${sc.name}</option>
						</c:when>
						<c:otherwise>
							<option value="${sc.smallCategoryNo}" >${sc.name}</option> 
						</c:otherwise>
					</c:choose>
				</c:forEach>
	  </select>
		<!-- recruitPostNo -->
		recruitPostNo : <input type="text" readonly="readonly" name="recruitPostNo" id="recruitPostNo"value="${recruitInfo.detail.recruitPostNo} ">
		&nbsp;
		<!-- title -->
		[수정] title : <input type="text" name="title" id="title" value="${recruitInfo.detail.title}">
		<br><br>
		<!-- content -->
		[수정] content : <input type="text" name="content" id="content"  value="${recruitInfo.detail.content}">
		<br><br>
		<!-- location -->
		[수정]location: <input type="text" name="location"  id="location" value="${recruitInfo.detail.location }">
		<br><br>
		<!-- capacity -->
		[수정] capacity : <input type="text" name="capacity"  id="capacity" value="${recruitInfo.detail.capacity}">
		<br><br>
		<!-- memberName -->
		name : <input type="text" readonly="readonly"value="${recruitInfo.detail.memberVO.name } ">
		<br><br>
	<%-- </form>
	<form class="updateRecruitForm" action="${pageContext.request.contextPath}/recruit/updateRecruitPostInfoByRecruitNo" method="post"> --%>
		<!-- day -->
		[수정] day : 
		<!--<input type="text" name=""  value="${recruitInfo.day} ">
		 <a class="btn btn-primary">월</a> -->
		 <label class="checkbox-inline">
			<input type="checkbox" name="day" value="월" >월
		</label>
		<label class="checkbox-inline">
			<input type="checkbox" name="day" value="화">화
		</label>
		<label class="checkbox-inline">
			<input type="checkbox" name="day" value="수">수
		</label>
		<label class="checkbox-inline">
			<input type="checkbox" name="day" value="목">목
		</label>
		<label class="checkbox-inline">
			<input type="checkbox" name="day" value="금">금
		</label>
		<label class="checkbox-inline">
			<input type="checkbox" name="day" value="토">토
		</label>
		<label class="checkbox-inline">
			<input type="checkbox" name="day" value="일">일요일
		</label>
		<br><br>
		<input type="submit" class="btn btn-primary" value="수정" >
		<a href="${pageContext.request.contextPath}/recruit/findDetailRecruitPostInfoByRecruitNo?recruitNo=${recruitInfo.detail.recruitPostNo}" class="btn btn-primary" id="updateCancelBtn">취소</a>
		</form>
    
    </section>
    
    
    
    <script>
		$(document).ready(function() {
			//작성: 유동규
			//기능: 대분류 번호에 따라 소분류 목록를 가져와 보여주기
			//로직: 대분류 선택한 후 POST방식으로 선택된 값을 전송한다.
			//		 선택한 대분류에 따른 소분류를 리스트 형태로 가져오고
			//		 $.each문을 통해 소분류 목록에 추가한다.
			$("#bigCategory").change(function() {
				$("#smallCategory").empty();
				if($("#bigCategory option:selected").text() == "대분류"){
					$("#smallCategory").append(
							"<option>소분류 </option><option>대분류를 먼저 선택하세요. </option>"
					);
				}else{
					$.ajax({
						type:"post",
						url:"${pageContext.request.contextPath}/ajax/getSmallCategoryList",
						dataType:"json",
						data:"bigCategoryNo="+$("#bigCategory").val(),
						success:function(data){
							var result = "";
							$.each(data, function(index, item) {
								result +=	"<option value="+item.smallCategoryNo+">"+item.name+"</option>";
							})//each
							$("#smallCategory").append(result);
						}//success
					})//ajax
				}
			})//bigCategory change
			
	})//ready
	
	
	//작성: 유동규
	//기능: 다중 form 전송을 통해 
	//로직: 대분류 선택한 후 POST방식으로 선택된 값을 전송한다.
	//		 선택한 대분류에 따른 소분류를 리스트 형태로 가져오고
	//		 $.each문을 통해 소분류 목록에 추가한다.
	function checkSubmit(){
		//CheckBox 하나라도 체크된지 확인
		var checkBox = $(":checkbox[name='day']:checked");
		if( checkBox.length ==0 ){
			alert("요일을 선택하세요.");
			return false;
		}
		//category 선택 여부 확인 
		var bigCategory = $("#bigCategory option:selected").val();
		var smallCategory =  $("#smallCategory option:selected").val();
		if(bigCategory =="" || smallCategory == ""){
			alert("카테고리를 선택하세요");
			return false;
		}
		//필수 입력 값 확인
		var title = $("#title").val();
		var content = $("#content").val();
		var location = $("#location").val();
		var capacity = $("#capacity").val();
		if(title=="" || title== null || title.trim().length == 0){
			alert("제목을 입력하세요");
			return false;
		}
		if(content=="" || content== null || content.trim().length == 0){
			alert("내용을 입력하세요");
			return false;
		}
		if(location=="" || location== null || location.trim().length == 0){
			alert("지역을 입력하세요");
			return false;
		}
		if(capacity=="" || capacity== null || capacity.trim().length == 0){
			alert("희망인원을 입력하세요");
			return false;
		}
	}
</script>
    

    