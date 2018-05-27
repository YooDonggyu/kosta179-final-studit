<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
	.left{
		text-align: left;
	}
	.studit-color{
		background-color: #FFBC9B;
		border-color: #FFBC9B;
	}
	.pre-custom{
		border: 0;
		background-color: #ffffff;
	}
	.img-size{
		width: 300px;
		height: 300px;
	}
	.carousel-control {
  		padding-top:10%;
 		 width:5%;
	}
	.row-padding{
		padding-bottom: 10px;
	}
	.join-button{
		border-color: #FFBC9B;
		background-color: #FFBC9B;
	}
				
</style>
<script>
	$(document).ready(function() {
		$('#myCarousel').carousel({
			interval: 10000
		})
	    
	    $('#myCarousel').on('slid.bs.carousel', function() {
	    	//alert("slid");
		});
	});
</script>
<!-- 사진 클릭시 새창 띄우기 위한 함수 -->
	<script type="text/javascript">
		var imgCommonPreview = new Image();
		function showPicture(imgSrc) {
			var img = "${pageContext.request.contextPath}/resources/upload/"+imgSrc;
			imgCommonPreview.src = img;
			setTimeout("createPreviewWin(imgCommonPreview)", 100);
		}
		function createPreviewWin(imgCommonPreview) {
			if (! imgCommonPreview.complete) {
			setTimeout("createPreviewWin(imgCommonPreview)", 100);
			return;
		}
		var scrollsize = 17;
		var swidth = screen.width - 10;
		var sheight = screen.height - 90;
		var wsize = imgCommonPreview.width
		var hsize = imgCommonPreview.height;
		 
		if(wsize < 50) wsize = 50;     // 가로 최소 크기
		if(hsize < 50) hsize = 50;     // 세로 최소 크기
		if(wsize > swidth) wsize = swidth;     // 가로 최대 크기
		if(hsize > sheight) hsize = sheight;     // 세로 최대 크기
		//세로가 최대크기를 초과한경우 세로스크롤바 자리 확보
		if((wsize < swidth-scrollsize) && hsize >= sheight) wsize += scrollsize;
		//가로가 최대크기를 초과한경우 가로스크롤바 자리 확보
		if((hsize < sheight-scrollsize) && wsize >= swidth) hsize += scrollsize;
		// IE 6,7 전용 : 가로세로 크기가 보통일때 세로 스크롤바 자리 확보
		if((wsize < swidth-scrollsize) && hsize < sheight && (navigator.userAgent.indexOf("MSIE 6.0") > -1 ||
				navigator.userAgent.indexOf("MSIE 7.0") > -1))
			wsize += scrollsize; 
		imageWin = window.open("", "winPreviewImg", "top=0,left=0,width=" + wsize+ ",height=" + hsize +",scrollbars=yes,resizable=yes,status=no");
		imageWin.document.write("<html><title>Preview</title><body style='margin:0;cursor:pointer;' title='Close' onclick='window.close()'>");
		imageWin.document.write("<img src='" + imgCommonPreview.src + "'>");
		imageWin.document.write("</body><html>");
	}
	</script>
	


<c:set value="${com.companyVO}" var="cVO" scope="request" />
<c:set value="${com.comPicList}" var="cPicList" scope="request" />
<c:set value="${com.comHashTagList}" var="cTagList" scope="request" />
<c:set value="${com.comDayList}" var="cDayList" scope="request" />
<c:set value="${com.studyList}" var="sList" scope="request" />
<c:set value="${com.studyPicList}" var="sPicList" scope="request" />
<c:set value="${com.studyFunctionList}" var="sFunctionList" scope="request" />


<div class="container ">
	<!-- 최상단 소개 -->
	<div class="blog-header left">
		<h1 class="blog-title">${cVO.name}</h1>
		<p class="lead blog-description">
			<!-- 해시태그, -->
			<c:forEach items="${cTagList}" var="tag">
				<input type="button" class="btn btn-danger btn-xs tag studit-color" value="${fn:substring(tag.CONTENT,1,tag.CONTENT.length())}">
			</c:forEach>
		</p>
	</div>

<div class="row">
	<!-- 메인 시작 -->
	<div class="col-sm-8 blog-main left">
		<div class="blog-post">
			<hr>
			
			
			<!-- 공간소개 시작 -->
			<h2 class="blog-post-title row-padding">공간소개</h2>
			<p class="blog-post-meta">#1 INFO</p>
			<blockquote >
				<p class="blog-post-meta">
					TEL : ${cVO.tel } <br>
					BUSINESS DAY : 
						<c:forEach items="${cDayList}" var="days" varStatus="cnt">
							<c:choose>
								<c:when test="${cnt.count ==1 }">${days}요일</c:when>
								<c:otherwise>, ${days}요일</c:otherwise>
							</c:choose>
						</c:forEach><br>
					BUSINESS HOURS : ${cVO.open } - ${cVO.close }<br>
					WORK IN HOLIDAY : 
						<c:choose><c:when test="${cVO.holiday== true}">정상영업</c:when><c:otherwise>휴무</c:otherwise></c:choose>
					<br>
					ADDRESS : ${cVO.primaryAddr} ${cVO.detailAddr}
					<input type="hidden" value="${cVO.detailAddr}" id="hiddenAddr">
				</p>
			</blockquote>
			<p class="blog-post-meta">#2 DETAIL</p>
				<pre class="pre-custom">${cVO.intro} </pre>
			<hr>
			<!-- 공간소개 끝-->
			
			
			<!-- 사진 시작 -->
           	<fmt:parseNumber var="mainCnt"  integerOnly="true" type="number" value="${cPicList.size()/3}" />
           	<fmt:parseNumber var="lastCnt"  integerOnly="true" type="number" value="${cPicList.size()%3}" />
           	<fmt:parseNumber var="startCnt"  integerOnly="true" type="number" value="0" />
           	<fmt:parseNumber var="endCnt"  integerOnly="true" type="number" value="2" />
           	<fmt:parseNumber var="nowCnt"  integerOnly="true" type="number" value="1" />
           	<c:set var="cntFlag" value="true" />
           	<div class="row row-padding" >
	           	<div class="col-sm-6 "><h2 class="blog-post-title">사진</h2></div>
	           	<div class="col-sm-6"><p class="blog-post-meta" style="text-align: right; font-size: 13px; padding-top: 10px;">사진을 누르시면 확대됩니다</p></div>
           	</div>
			<div class="well">
			<c:choose>
			<c:when test="${cPicList != null && cPicList.size() != 0 }">
            <div id="myCarousel" class="carousel slide">
                <!-- Carousel items -->
				<div class="carousel-inner">
					<%-- 아래 warning은 무시 --%>
						<c:forEach items="${cPicList}" begin="1" end="${mainCnt}" varStatus="count" >
						<c:choose>
							<c:when test="${count.count == 1 }"><div class="item active"></c:when>
							<c:otherwise><div class="item"></c:otherwise>
						</c:choose>
								<div class="row">
									<c:if test="${cntFlag}">
										<c:forEach items="${cPicList}" var="pic" begin="${startCnt}" end="${endCnt}">
											<div class="col-sm-4"><a href="#x"><img src="${pageContext.request.contextPath}/resources/upload/${pic.PATH}" alt="Image" class="img-responsive" onclick="showPicture('${pic.PATH}')"></a></div>
										</c:forEach>
									</c:if>
									<c:if test="${nowCnt >= mainCnt}">
										<c:set var="cntFlag"  value="false" />
									</c:if>
									<fmt:parseNumber var="startCnt"  integerOnly="true" type="number" value="${endCnt+1}" />
									<fmt:parseNumber var="endCnt"  integerOnly="true" type="number" value="${endCnt+3}" />
									<fmt:parseNumber var="nowCnt"  integerOnly="true" type="number" value="${nowCnt+1}" />
								</div><!-- row -->
							</div><!--/item-->
						</c:forEach>
						<div class="item" >
							<div class="row">
								<c:forEach items="${cPicList}" begin="${startCnt}" end="${endCnt}" var="pic">
									<div class="col-sm-4"><a href="#x"><img src="${pageContext.request.contextPath}/resources/upload/${pic.PATH}" alt="Image" class="img-responsive"></a></div>
								</c:forEach>
							</div>
						</div>
				</div>
				<!--/carousel-inner--> 
				<a class="left carousel-control" href="#myCarousel" data-slide="prev">‹</a>
				<a class="right carousel-control" href="#myCarousel" data-slide="next">›</a>
			</div>
			</c:when>
			<%--사진 없을 때 --%>
			<c:otherwise>
				<p style="text-align: center;">No Pictures</p>
			</c:otherwise>
			</c:choose>
            <!--/myCarousel-->
        </div>
		<hr>
		<!-- 사진 끝 -->	
		
		
		<!-- 지도 시작 -->
		<div class="row">
			<div class="col-sm-9"><h2 class="blog-post-title row-padding" >위치</h2></div>
			<div class="col-sm-3"><a href="http://map.daum.net/link/search/${cVO.detailAddr}" style="font-size: 13px; color:#999; text-align: right; ">길안내 바로가기</a></div>
		</div>
		<div id="map" style="width:100%;height:400px;"></div>
		<!-- 지도 끝 -->
		
		
		</div><!-- blog-post -->
	</div><!-- row-->
	
	<!-- 오른쪽 배너 -->
	<div class="col-sm-3 col-sm-offset-1 blog-sidebar" >
		<div class="sidebar-module sidebar-module-inset" style="background-color: #ffffff;">
			<div class="row">
				<div class="col-sm-6"><button class="studit-color btn btn-xs" data-toggle="tooltip" title="${cVO.tel}">연락하기</button></div>
				<c:if test="${cVO.url != null }">
					<div class="col-sm-6"><button class="studit-color btn btn-xs" data-toggle="tooltip" title="${cVO.url}">개인 홈페이지</button></div>
				</c:if>
			</div><%--row --%>
			<c:if test="${sList != null && sList.size() != 0 }">
				<span style="border: 2px; border-color: #FFBC9B; border-radius: 4px; ">
				<c:forEach items="${sList}" var="list">
					<div class="row" style="padding-top: 10px; padding-bottom: 10px;">
						<div class="col-sm-5">${list.name}</div>
						<div class="col-sm-6"><a href="" class="btn btn-default btn-xs tag">${list.price}</a><a href="" class="btn btn-default btn-xs tag">${list.capacity}</a></div>
						<div class="col-sm-1"></div>
					</div>
				</c:forEach>
				</span>
			</c:if>
		</div>
	</div>
</div>

</div><!-- container -->




<!-- 지도 생성을 위한 script -->
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new daum.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('제주특별자치도 제주시 첨단로 242', function(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === daum.maps.services.Status.OK) {
	
	        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new daum.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new daum.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+$("#hiddenAddr").val()+'</div>'
	        });
	        infowindow.open(map, marker);
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});    
</script>

