<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
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
<section>
<div class="col-sm-12">
<h3>스터디 통합 관리</h3>
	<div class="row" style="padding-left: 150px; padding-right: 150px; margin-bottom: 100px; margin-top: 50px">
	<a href="#" id="bookmark">즐겨찾기만 보기 </a>&nbsp;&nbsp;&nbsp;
	<a href="#" id="edit"> 편집</a>
		<div class="MultiCarousel" data-items="1,3,4,5" data-slide="1" id="MultiCarousel"  data-interval="1000">
            <div class="MultiCarousel-inner">
            <div class="item">
              <div class="pad15" style="background-color: white;">
              	<br>
              	<p class="lead"><b>진행중인 스터디</b></p>
              	<p>신청,개설,참여중인 스터디를 모두 확인할 수 있습니다.</p>
              </div>
            </div>
            <form action="${pageContext.request.contextPath}/group/groupHome" method="post" id="myPageForm"> 
           	 <input type="hidden" name="sgNo" id="sgNo">  
            <c:forEach items="${groupList}" var="g">
            <c:choose>
            <c:when test="${g.state eq 'show'}">
                 <div class="item" style="cursor: pointer;" onclick="return goGroup(${g.groupVO.groupNo})">
                    <div class="pad15 my">
                    <input type="checkbox" class="checkbox-inline checkBookmark" id="checkBookmark" value="${g.groupMemberNo}" style="position: relative; float: right; width: 70px">
                    	<br>
                    	<p class="lead">${g.groupVO.name}</p>
						<c:if test="${g.position eq '팀장'}">
							<i class="fas fa-crown fa-2x" style="color: #ffcc00"></i>
							<i class="fas fa-star" style="color: #ffcc00"></i>
						</c:if>
						<br><br><br>
                    </div>
                     
                </div>
            </c:when>
            <c:otherwise>
                 <div class="item uncheckedItem" style="cursor: pointer;"  onclick="return goGroup(${g.groupVO.groupNo})">
                    <div class="pad15 my">
                    <input type="checkbox" class="checkbox-inline checkBookmark" id="checkBookmark" value="${g.groupMemberNo}" style="position: relative; float: right; width: 70px">
                    	<br>
                    	<p class="lead">${g.groupVO.name}</p>
						<c:if test="${g.position eq '팀장'}">
							<i class="fas fa-crown fa-2x" style="color: #ffcc00"></i>
						</c:if>
						<br><br><br>
                    </div>
                </div>
            </c:otherwise>
                     </c:choose>
            </c:forEach>
            </form>
            </div>
            <button class="btn btn-primary leftLst"><</button>
            <button class="btn btn-primary rightLst">></button>
        </div>
	</div>
</div>
<a href="${pageContext.request.contextPath}/group/findGroupMemberView?groupNo=1">그룹</a>

<div class="col-sm-10" style="text-align: right">예약대기 및 미승인 상태에서 취소할 수 있습니다.</div>
<div class="col-sm-2"></div>
<div class="col-sm-1"></div>
<div class="col-sm-10" style="padding-bottom: 40px;"> 
<ul class="nav nav-tabs">
  <li class="active" style="width: 50%"><a data-toggle="tab" href="#home"><b>스터디 신청 현황</b></a></li>
  <li style="width: 50%"><a data-toggle="tab" href="#menu1"><b>스터디룸 신청 현황</b></a></li>
</ul>

<div class="tab-content">
  <div id="home" class="tab-pane fade in active">
  <c:choose>
  	<c:when test="${empty studyConditionList.list}">
  	<br><br><br><br><br>
  	아직 신청한 스터디가 없습니다.
  	<br><br><br><br><br>
  	</c:when>
  	<c:otherwise>
  	<table class="table table-hover">
		<thead>
			<tr>
				<th>분류</th>
				<th>지역</th>
				<th>제목</th>
				<th>팀장</th>
				<th>신청일</th>
				<th>상태/취소</th>
			</tr>
		</thead>
		<tbody id="recruitAjaxResult">
			<c:forEach items="${studyConditionList.list }" var="list">
				<tr>
					<td>${list.recruitPostVO.smallCategoryVO.name }</td>
					<td>${list.recruitPostVO.location }</td>
					<td><a href=
			"${pageContext.request.contextPath }/recruit/findDetailRecruitPostInfoByRecruitNo?recruitNo=${list.recruitPostVO.recruitPostNo}">${list.recruitPostVO.title }</a></td>
					<td>${list.memberVO.name }</td>
					<td>${list.regdate}</td>
					<!-- warning 주황, default 흰색, primary 핑크?, sucess 초록, danger 빨강, info 하늘 -->
					<td><button id="cancelBtn1" value="${list.studyConditionNo}" class="btn btn-default">${list.state}</button></td>
				</tr>
			</c:forEach>
		</tbody>
		<c:set var="recruitpb" value="${studyConditionList.pagingBean}" />
		<c:if test="${recruitpb.nextPage == true}">
			<tr>
				<td colspan="7"><input type="button" id="recruitpbBtn"  value="더보기"></td>
			</tr>
		</c:if>
	</table>
  	</c:otherwise>
  </c:choose> 
  </div>

  <div id="menu1" class="tab-pane fade">
  <c:choose>
  	<c:when test="${empty srcListVO.list}">
  	<br><br><br><br><br>
  	스터디룸 예약 내역이 없습니다.
  	<br><br><br><br><br>
  	</c:when>
  	<c:otherwise>
	    <table class="table table-hover">
			<thead>
				<tr>
					<th>업체</th>
					<th>스터디룸</th>
					<th>사용일</th>
					<th>시작</th>
					<th>종료</th>
					<th>신청일</th>
					<th>상태/취소</th>
				</tr>
			</thead>
			<tbody id="roomAjaxResult">
				<c:forEach items="${srcListVO.list}" var="srlist">
					<tr>
						<td><a href="${pageContext.request.contextPath}/company/findDetailCompanyInfoByCompanyNo?companyNo=${srlist.studyRoomVO.companyVO.companyNo}">${srlist.studyRoomVO.companyVO.name }</a></td>
						<td>${srlist.studyRoomVO.name }</td>
						<td>${srlist.useDate }</td>
						<td>${srlist.startTime }</td>
						<td>${srlist.endTime }</td>
						<td>${srlist.regDate }</td>
						<td><button id="cancelBtn2" value="${srlist.studyRoomConditionNo }" class="btn btn-default">${srlist.state}</button></td>
					</tr>
				</c:forEach>
			</tbody>
			<c:set var="roompb" value="${srcListVO.pagingBean}" />
			<c:if test="${roompb.nextPage == true}">
				<tr>
					<td colspan="7"><input type="button" id="roompbBtn"  value="더보기"></td>
				</tr>
			</c:if>
		</table>
	</c:otherwise>
  </c:choose>
  </div>
 </div><!-- <div class="tab-content"> -->
</div>
	<div class="col-sm-1"></div>
</section>



<script>
	$(document).ready(function(){
		
		$(".checkBookmark").hide();
		
		var groupList = "${groupList}";
		$("#bookmark").click(function() {
			if($(this).text()=='전체보기'){
				$(this).text('즐겨찾기 보기');
				$(".uncheckedItem").show();
			}else{
				$(this).text('전체보기');
				$(".uncheckedItem").hide();
			}
		});//click
		
		var roomPageNo = 1;
		var recruitPageNo = 1;
		
		$("#roompbBtn").click(function(){
			roomPageNo += 1;
			$.ajax({
				type:"get",
				url:"${pageContext.request.contextPath}/ajax/findStudyRoomConditionByNowPage",
				data:"nowPage="+roomPageNo,
				success:function(data){
					var temp="";
				 	$.each(data.list, function(index, item) {
						temp += 
							"<tr>"+
							"<td><a href='${pageContext.request.contextPath}/company/findDetailCompanyInfoByCompanyNo?companyNo="+item.studyRoomVO.companyVO.companyNo+"'>"+item.studyRoomVO.companyVO.name+"</a></td>"+
							"<td>"+item.studyRoomVO.name+"</td>"+
							"<td>"+item.useDate+"</td>"+
							"<td>"+item.startTime+"</td>"+
							"<td>"+item.endTime+"</td>"+
							"<td>"+item.regDate+"</td>"+
							"<td>"+"<button id='cancelBtn2' value="+item.studyRoomConditionNo+" class='btn btn-default'>"+item.state+"</button>"+"</td>"
							+"</td>"
					})//each 
					$("#roomAjaxResult").append(temp);
				 	if(!data.pagingBean.nextPage){
				 		$("#roompbBtn").hide();
				 	}else{
				 		$("#roompbBtn").show();
				 	}
				}//success
			})//ajax
		})//click
		
		$("#recruitpbBtn").click(function(){
			recruitPageNo += 1;
			$.ajax({
				type:"get",
				url:"${pageContext.request.contextPath}/ajax/findStudyConditionByNowPage",
				data:"nowPage="+recruitPageNo,
				success:function(data){
					var temp="";
				 	$.each(data.list, function(index, item) {
						temp += 
							"<tr>"+
							"<td>"+item.recruitPostVO.smallCategoryVO.name +"</td>"+
							"<td>"+item.recruitPostVO.location +"</td>"+
							"<td><a href='${pageContext.request.contextPath }/recruit/findDetailRecruitPostInfoByRecruitNo?recruitNo="+item.recruitPostVO.recruitPostNo+"'>"+item.recruitPostVO.title+"</a></td>"+
							"<td>"+item.memberVO.name +"</td>"+
							"<td>"+item.regdate+"</td>"+
							"<td>"+"<button id='cancelBtn1' value="+item.studyConditionNo+" class='btn btn-default'>"+item.state+"</button>"+"</td>"
							+"</td>"
					})//each 
					$("#recruitAjaxResult").append(temp);
				 	if(!data.pagingBean.nextPage){
				 		$("#recruitpbBtn").hide();
				 	}else{
				 		$("#recruitpbBtn").show();
				 	}
				}//success
			})//ajax
		})//click
		
		//즐겨찾기 편집
		$("#edit").click(function() {
			$(".uncheckedItem").show();
			$(".checkBookmark").show();
			
		});
		
		$(document).on("click", "#cancelBtn1",function() {
			var email = "${memberVO.memberEmail}";
			if($(this).text()=="미승인"){
				if(confirm("신청을 취소할까요?")){
					 $.ajax({
			    		type:"post",
						url:"${pageContext.request.contextPath}/ajax/deleteStudyConditionByStudyConditionNo",
						data: "studyConditionNo="+$(this).val()+"&memberEmail="+email,
						success:function(data){
							alert("스터디 참여 신청이 취소되었습니다.");
							location.reload();
						}//success
					})//ajax
				}
			}else{
				alert("승인 이후 취소는 스터디 그룹 페이지에서 할 수 있습니다.");
			}
		})//on(calcelBtn1)
			
			$(document).on("click","#cancelBtn2", function(){
				var email = "${memberVO.memberEmail}";
				if($(this).text()=='예약대기'){
					if(confirm("예약을 취소할까요?")){
						 $.ajax({
				    		type:"post",
							url:"${pageContext.request.contextPath}/ajax/updateStudyRoomConditionByMember",
							data: "studyRoomConditionNo="+$(this).val()+"&memberEmail="+email,
							success:function(data){
								alert("예약신청이 취소되었습니다.");
								location.reload();
							}//success
						})//ajax
					}
				}else if($(this).text()=='예약취소'){
					alert("취소된 예약은 복구할 수 없습니다.");
				}else{
					alert("예약 완료 이후 상태 변경은 업체에 문의하세요.");
				}
		})//on(cancelBtn2)
		
		//carousel
		var itemsMainDiv = ('.MultiCarousel');
	    var itemsDiv = ('.MultiCarousel-inner');
	    var itemWidth = "";

	    $('.leftLst, .rightLst').click(function () {
	        var condition = $(this).hasClass("leftLst");
	        if (condition)
	            click(0, this);
	        else
	            click(1, this)
	    });

	    ResCarouselSize();

	    $(window).resize(function () {
	        ResCarouselSize();
	    });

	    //this function define the size of the items
	    function ResCarouselSize() {
	        var incno = 0;
	        var dataItems = ("data-items");
	        var itemClass = ('.item');
	        var id = 0;
	        var btnParentSb = '';
	        var itemsSplit = '';
	        var sampwidth = $(itemsMainDiv).width();
	        var bodyWidth = $('body').width();
	        $(itemsDiv).each(function () {
	            id = id + 1;
	            var itemNumbers = $(this).find(itemClass).length;
	            btnParentSb = $(this).parent().attr(dataItems);
	            itemsSplit = btnParentSb.split(',');
	            $(this).parent().attr("id", "MultiCarousel" + id);

	            if (bodyWidth >= 1200) {
	                incno = itemsSplit[3];
	                itemWidth = sampwidth / incno;
	            }
	            else if (bodyWidth >= 992) {
	                incno = itemsSplit[2];
	                itemWidth = sampwidth / incno;
	            }
	            else if (bodyWidth >= 768) {
	                incno = itemsSplit[1];
	                itemWidth = sampwidth / incno;
	            }
	            else {
	                incno = itemsSplit[0];
	                itemWidth = sampwidth / incno;
	            }
	            $(this).css({ 'transform': 'translateX(0px)', 'width': itemWidth * itemNumbers });
	            $(this).find(itemClass).each(function () {
	                $(this).outerWidth(itemWidth);
	            });

	            $(".leftLst").addClass("over");
	            $(".rightLst").removeClass("over");
	        });
	    }

	    //this function used to move the items
	    function ResCarousel(e, el, s) {
	        var leftBtn = ('.leftLst');
	        var rightBtn = ('.rightLst');
	        var translateXval = '';
	        var divStyle = $(el + ' ' + itemsDiv).css('transform');
	        var values = divStyle.match(/-?[\d\.]+/g);
	        var xds = Math.abs(values[4]);
	        if (e == 0) {
	            translateXval = parseInt(xds) - parseInt(itemWidth * s);
	            $(el + ' ' + rightBtn).removeClass("over");

	            if (translateXval <= itemWidth / 2) {
	                translateXval = 0;
	                $(el + ' ' + leftBtn).addClass("over");
	            }
	        }
	        else if (e == 1) {
	            var itemsCondition = $(el).find(itemsDiv).width() - $(el).width();
	            translateXval = parseInt(xds) + parseInt(itemWidth * s);
	            $(el + ' ' + leftBtn).removeClass("over");

	            if (translateXval >= itemsCondition - itemWidth / 2) {
	                translateXval = itemsCondition;
	                $(el + ' ' + rightBtn).addClass("over");
	            }
	        }
	        $(el + ' ' + itemsDiv).css('transform', 'translateX(' + -translateXval + 'px)');
	    }

	    //It is used to get some elements from btn
	    function click(ell, ee) {
	        var Parent = "#" + $(ee).parent().attr("id");
	        var slide = $(Parent).attr("data-slide");
	        ResCarousel(ell, Parent, slide);
	    }
	})//ready
	function goGroup(sgNo){
		$("#sgNo").val(sgNo);
		$("#myPageForm").submit();
	}
</script>




 