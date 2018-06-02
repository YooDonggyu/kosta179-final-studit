<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.formCategory{
	font-weight: bold;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$("#big_category").change(function(){
		$.ajax({
			type: "get",
			dataType: "json",
			url:"${pageContext.request.contextPath}/ajax/getSmallCategoryByBigCategoryAjax",
			data:"bigCategoryNo="+$("#big_category option:selected").val(),
			success:function(result){
				var smallCategory="<option value='0'>소분류</option>";
				$.each(result, function(index, item){
					smallCategory+="<option value='";
					smallCategory+=item.smallCategoryNo;
					smallCategory+="'>";
					smallCategory+=item.name;
					smallCategory+="</option>";			
				})
				$("#small_category").html(smallCategory);
			}
		});//ajax
	});//big_category
});//ready
function check(){
	if($("#title").val()==""){
		alert("제목을 입력하세요!");
		$("#title").focus();
		return false;
	}
	if($("#title").val().length > 33){
		alert("제목은 33글자까지 가능합니다.");
		return false;
	}
	if($("#capacity").val()==""){
		alert("희망인원을 입력하세요!");
		$("#capacity").focus();
		return false;
	}
	if($("#location").val()==""){
		alert("희망지역을 입력하세요!");
		$("#location").focus();
		return false;
	}
	if($("#location").val().length > 33){
		alert("지역은 33글자까지 가능합니다.");
		return false;
	}
	if($("#big_category option:selected").val()==0){
		alert("대분류를 선택하세요!");
		return false;
	}
	if($("#small_category option:selected").val()==0){
		alert("소분류를 선택하세요!");
		return false;
	}
	if($("input[name=days]:checked").size()==0){
		alert("요일을 선택하세요!");
		return false;
	}
	if($("#content").val()==""){
		alert("내용을 입력하세요!"); 
		return false;
	}
	if($("#content").val().length > 1332){
		alert("내용은 1300글자까지 가능합니다. 현재 "+$("#content").val().length+"글자 입니다."); 
		return false;
	}
	return true;
}
</script>

</head>
<body>

<div class="col-sm-3" ></div>
	<div class="col-sm-6">
            <form method="post" action="${pageContext.request.contextPath }/recruit/createRecruitPost" class="form-horizontal" role="form" onsubmit="return check()">
                <div style="padding-top: 30px; padding-bottom: 20px;"><h3>모집글 작성</h3></div>
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label formCategory">제목</label>
                    <div class="col-sm-9">	
                        <input type="text" id="title" name="title" placeholder="제목을 입력하세요" class="form-control" maxlength="33" autofocus>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="capacity" class="col-sm-3 control-label formCategory">희망인원</label>
                    <div class="col-sm-9">
                        <input type="number" id="capacity"  name= "capacity" class="form-control" min="1" max="1000">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="location" class="col-sm-3 control-label formCategory">희망지역</label>
                    <div class="col-sm-9">
                        <input type="text" id="location"  name="location" class="form-control" placeholder="판교">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="category" class="col-sm-3 control-label formCategory">카테고리</label>
                    <div class="col-sm-9">
                        <select id="big_category">
							<option value="0">대분류</option>
							<c:forEach items="${requestScope.cList }" var="cList">
								<option value="${cList.bigCategoryNo }">${cList.name }</option>
							</c:forEach>
						</select>
					
						<select id="small_category" name="smallCategoryVO.smallCategoryNo">
						<option value="0">소분류</option>
						</select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="days" class="col-sm-3 control-label formCategory">모집요일</label>
                    <div class="col-sm-9">
                    	<input type="checkbox" name="days" value="월"> 월
						<input type="checkbox" name="days" value="화"> 화
						<input type="checkbox" name="days" value="수"> 수
						<input type="checkbox" name="days" value="목"> 목
						<input type="checkbox" name="days" value="금"> 금
						<input type="checkbox" name="days" value="토"> 토
						<input type="checkbox" name="days" value="일"> 일
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="content" class="col-sm-3 control-label formCategory" >내용</label>
                    <div class="col-sm-9">
                        <pre><textarea style="width:100%; height: 250px;" placeholder="내용을 입력하세요!" id="content" name="content"></textarea></pre>
                    </div>
                </div>
                
                <div class="form-group">
                    <div class="col-sm-9 col-sm-offset-3">
                        <input type="submit" value="작성"> &nbsp;
                        <a href="${pageContext.request.contextPath}/recruit/getRecruitPostList?pageNo=1" class="btn" style="color: black;"><u>목록</u></a>
                    </div>
                </div>
            </form> <!-- /form -->
        </div> <!-- ./container -->
        <div class="col - sm- 3" ></div>
			
