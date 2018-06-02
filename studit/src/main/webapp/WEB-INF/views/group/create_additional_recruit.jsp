<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
    
    
    <section style="padding: 100px">
	<div class="col-sm-8" style="float:left">
	<form class="updateRecruitForm" action="${pageContext.request.contextPath}/group/createAdditionalRecruit" 
		method="post" onsubmit="return checkSubmit()">
			<input type="hidden" name="recruitPostNo"  value="${recruitInfo.detail.recruitPostNo}">
			<div class="form-group">
				<div class="col-sm-8">
					<h3><i class="fas fa-plus"></i> 스터디 추가 모집</h3>
					<br><br>
				</div>
			</div><!-- title from-group -->
			<div class="form-group" >
				<label for="title" class="col-sm-3 control-label">카테고리</label>
				<div class="col-sm-9">
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
					</select><!-- 대분류 --> 
				</div><!-- 대분류 col -->
				<div class="col-sm-9">
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
				</select><!-- 소분류 --> 
				</div><!-- 소분류 col -->
			</div><!-- 카테고리 form-group -->
			<br>
			<div class="form-group">
				<label for="title" class="col-sm-3">제목</label>
				<div class="col-sm-9">
                        <input type="text" name="title" id="title" class="form-control" value="[추가모집] ${recruitInfo.detail.title}">
                    </div>
			</div><!-- title from-group -->
			<div class="form-group">
				<label for="title" class="col-sm-3">내용</label>
				<div class="col-sm-9">
                         <textarea style="width: 100%; height: 300px;" name="content" id="content"  class="form-control" >${recruitInfo.detail.content}</textarea>
                    </div>
			</div><!-- content from-group -->
			<div class="form-group">
				<label for="title" class="col-sm-3">지역</label>
				<div class="col-sm-9">
                         <input type="text" name="location"  id="location" class="form-control"  value="${recruitInfo.detail.location }">
                    </div>
			</div><!-- location from-group -->
			<div class="form-group">
				<label for="title" class="col-sm-3">희망인원</label>
				<div class="col-sm-9">
                        <input type="text" name="capacity"  id="capacity" class="form-control" value="${recruitInfo.detail.capacity}">
                    </div>
			</div><!-- capacity from-group -->
			
			<div class="form-group">
                    <label for="day" class="col-sm-3 control-label">모집요일</label>
                    <div class="col-sm-8">
						<label class="checkbox-inline">
							<input type="checkbox" name="day" value="월" >월&nbsp;
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="day" value="화">화&nbsp;
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="day" value="수">수&nbsp;
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="day" value="목">목&nbsp;
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="day" value="금">금&nbsp;
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="day" value="토">토&nbsp;
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="day" value="일">일&nbsp;
						</label>
                    </div>
                </div>
				
			<div class="form-group">
				<div class="col-sm-3"></div>
				<div class="col-sm-9">
				<div class="row" align="right">
					<div class="col-sm-4"><input type="submit" class="btn btn-primary" value="확인" ></div>
					<div class="col-sm-4"><a href="${pageContext.request.contextPath}/group/findGroupMemberView" class="btn btn-default" id="updateCancelBtn">취소</a></div>
				</div>
				</div>
			</div>			
	</form><!-- form -->
	</div><!-- col-8 -->
	
    </section>
    <div style="width: 300px; float:left; padding:20px;">
    <div style="text-align: center;"><i class="fas fa-info-circle" style="text-align: center"></i><br><br></div>
 	 	<ul>
 	 	<li>추가모집글은 스터디 모집 게시판에 최신글로 등록됩니다.</li>
 	 	<li>모집글의 수정 및 모집 완료는 기존 방식과 동일하며, 모집글 삭제는 불가능합니다.</li></ul> 
	</div>
    
    
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
    

    