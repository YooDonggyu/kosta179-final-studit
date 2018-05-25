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

<div class="col-sm-3" ></div>
	<div class="col-sm-6">
            <form method="post" action="${pageContext.request.contextPath }/recruit/createRecruitPost" class="form-horizontal" role="form">
                <div style="padding-top: 30px; padding-bottom: 20px;"><h3>모집글 작성</h3></div>
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">제목</label>
                    <div class="col-sm-9">	
                        <input type="text" id="title" name="title" placeholder="제목을 입력하세요" class="form-control" autofocus>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="capacity" class="col-sm-3 control-label">희망인원</label>
                    <div class="col-sm-9">
                        <input type="number" id="capacity"  name= "capacity" class="form-control">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="location" class="col-sm-3 control-label">희망지역</label>
                    <div class="col-sm-9">
                        <input type="text" id="location"  name="location" class="form-control">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="category" class="col-sm-3 control-label">카테고리</label>
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
                    <label for="days" class="col-sm-3 control-label">모집요일</label>
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
                    <label for="content" class="col-sm-3 control-label" >내용</label>
                    <div class="col-sm-9">
                        <pre><textarea style="resize:none; width: 700px; height: 250px;" placeholder="내용을 입력하세요!" id="content" name="content"></textarea></pre>
                    </div>
                </div>
                
                <div class="form-group">
                    <div class="col-sm-9 col-sm-offset-3">
                        <input type="submit" value="작성">
                    </div>
                </div>
            </form> <!-- /form -->
        </div> <!-- ./container -->
        <div class="col - sm- 3" ></div>
			

