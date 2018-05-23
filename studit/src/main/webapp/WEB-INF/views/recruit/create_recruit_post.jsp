<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	
</script>

</head>
<body>
	<form method="post" action="createRecruitPost" >
		<input type="text" placeholder="제목을 입력하세요" id="title" name="title"><br>
		희망인원 &nbsp; <input type="number" id="capacity" name="capacity">명<br>
		희망지역 &nbsp; <input type="text" id="location" name="location"><br>
		<select id="big_category">
			<option value="0">대분류</option>
			<c:forEach items="${requestScope.cList }" var="cList">
				<option value="${cList.bigCategoryNo }">${cList.name }</option>
			</c:forEach>
		</select> &nbsp;
		<select id="small_category" name="smallCategoryVO.smallCategoryNo">
			<option value="0">소분류</option>
		</select><br>
		<!-- 요일 선택 -->
		<input type="checkbox" name="Days" value="월">월
		<input type="checkbox" name="Days" value="화">화
		<input type="checkbox" name="Days" value="수">수
		<input type="checkbox" name="Days" value="목">목
		<input type="checkbox" name="Days" value="금">금
		<input type="checkbox" name="Days" value="토">토
		<input type="checkbox" name="Days" value="일">일
		<pre><textarea style="resize:none;" placeholder="내용을 입력하세요!" id="content" name="content"></textarea></pre><br>
		<input type="submit" value="작성">
	</form>

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	