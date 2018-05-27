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

.stateBtn{
    font-size: 60%;
    width: 100%;
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
		<div class="MultiCarousel" data-items="1,3,4,5" data-slide="1" id="MultiCarousel"  data-interval="1000">
            <div class="MultiCarousel-inner">
            <div class="item">
                    <div class="pad15" style="background-color: white;">
                    	<br>
                    	<p class="lead"><b>진행중인 스터디</b></p>
                    	<p>신청,개설,참여중인 스터디를 모두 확인할 수 있습니다.</p>
                    </div>
                </div>
            <c:forEach items="${groupList}" var="g">
              <div class="item" style=" cursor: pointer;" onclick="location.href='#'">
                    <div class="pad15 my">
                    	<br>
                    	<p class="lead">${g.groupVO.name}</p>
						<c:if test="${g.position eq '팀장'}">
							<i class="fas fa-crown fa-2x" style="color: #ffcc00"></i>
						</c:if>
						<br><br><br>
                    </div>
                </div>
            </c:forEach>
            </div>
            <button class="btn btn-primary leftLst"><</button>
            <button class="btn btn-primary rightLst">></button>
        </div>
	</div>
</div>

<div class="col-sm-1"></div>
<div class="col-sm-10">
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
				<th>No</th>
				<th>Category</th>
				<th>Location</th>
				<th>Title</th>
				<th>Writer</th>
				<th>regDate</th>
				<th>Status</th>
			</tr>
		</thead>
		<tbody id="recruitAjaxResult">
			<c:forEach items="${studyConditionList.list }" var="list">
				<tr>
					<td>${list.studyConditionNo }</td>
					<td>${list.recruitPostVO.smallCategoryVO.name }</td>
					<td>${list.recruitPostVO.location }</td>
					<td>${list.recruitPostVO.title }</td>
					<td>${list.memberVO.name }</td>
					<td>${list.regdate}</td>
					<!-- warning 주황, default 흰색, primary 핑크?, sucess 초록, danger 빨강, info 하늘 -->
					<c:choose>
						<c:when test="${'미승인' eq list.state}">
							<td><input type="button" value="${list.state }" class="btn btn-default stateBtn"></td>
						</c:when>
						<c:when test="${'승인' eq list.state}">
							<td><input type="button" value="${list.state }" class="btn btn-sucess stateBtn"></td>
						</c:when>
						<c:when test="${'거절' eq list.state}">
							<td><input type="button" value="${list.state }" class="btn btn-danger stateBtn"></td>
						</c:when>
						<c:when test="${'진행중' eq list.state}">
							<td><input type="button" value="${list.state }" class="btn btn-warning stateBtn"></td>
						</c:when>
						<c:when test="${'삭제' eq list.state}">
							<td><input type="button" value="${list.state }" class="btn btn-danger stateBtn"></td>
						</c:when>
					</c:choose>
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
				<th>companyName</th>
				<th>studyroomName</th>
				<th>useDate</th>
				<th>startTime</th>
				<th>endTime</th>
				<th>regDate</th>
				<th>state</th>
			</tr>
		</thead>
		<tbody id="roomAjaxResult">
			<c:forEach items="${srcListVO.list}" var="srlist">
				<tr>
					<td>${srlist.studyRoomVO.companyVO.name }</td>
					<td>${srlist.studyRoomVO.name }</td>
					<td>${srlist.useDate }</td>
					<td>${srlist.startTime }</td>
					<td>${srlist.endTime }</td>
					<td>${srlist.regDate }</td>
					<td><input type="button" value="${srlist.state }" class="btn btn-secondary"></td>
<%-- 					<c:choose>
						<c:when test="${'예약대기' eq srlist.state}">
							<td><input type="button" value="${srlist.state }" class="btn btn-default stateBtn"></td>
						</c:when>
						<c:when test="${'예약완료' eq srlist.state}">
							<td><input type="button" value="${srlist.state }" class="btn btn-sucess stateBtn"></td>
						</c:when>
						<c:when test="${'예약불가' eq list.state}">
							<td><input type="button" value="${srlist.state }" class="btn btn-danger stateBtn"></td>
						</c:when>
						<c:when test="${'예약취소' eq list.state}">
							<td><input type="button" value="${srlist.state }" class="btn btn-warning stateBtn"></td>
						</c:when>
					</c:choose> --%>
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
							"<td>"+item.studyRoomVO.companyVO.name+"</td>"+
							"<td>"+item.studyRoomVO.name+"</td>"+
							"<td>"+item.useDate+"</td>"+
							"<td>"+item.startTime+"</td>"+
							"<td>"+item.endTime+"</td>"+
							"<td>"+item.regDate+"</td>"+
							"<td>"+"<input type='button' value="+item.state+" class='btn btn-secondary'>"+"</td>"
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
							"<td>"+item.studyRoomVO.companyVO.name+"</td>"+
							"<td>"+item.studyRoomVO.name+"</td>"+
							"<td>"+item.useDate+"</td>"+
							"<td>"+item.startTime+"</td>"+
							"<td>"+item.endTime+"</td>"+
							"<td>"+item.regDate+"</td>"+
							"<td>"+"<input type='button' value="+item.state+" class='btn btn-secondary'>"+"</td>"
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
</script>




 