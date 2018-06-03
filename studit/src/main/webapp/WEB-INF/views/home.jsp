<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	.none{
		display:none
	}
	.navi{
		float:right;
		padding-left: 40px;
		padding-top: 5px;
	}
	.block {
		height:30px; 
		overflow:hidden; 
		}
	.block ul,
	.block li {
		font-size:23px;
		height: 40px;
		margin:0; 
		padding:0; 
		list-style:none;
	}
	.block li a {
		text-align: right;
		display:block; 
		height:20px; 
		line-height:20px; 
		padding: 9px;
		color:#555; 
		text-decoration:none;
	}
	
	.key-a{
		padding: 2px;
	}
	.key-col{
		width: auto;
		text-align: left;
		padding: 0;
	}
	.key-button{
		width: 10%;
	}
	
</style>


	<section id="intro" class="text-intro no-padding-bottom">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <h1>This could be your perfect <!-- <span class="rotate">startup intro site, landing page, bootstrap template</span> --> </h1>
              <h3 class="weight-300">It is SEO friendly, responsive and free.</h3>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <p>500,000 users have already trusted <a href="http://bootstrapious.com">Bootstrapious templates</a>.<br />Try it for yourself.</p>
         <!--      <form class="form-inline margin-top sign-up-form">
                <input id="email_intro" type="email" placeholder="name@company.com" class="form-control">
                <input id="submit_intro" type="submit" value="Get started for FREE" class="btn btn-primary">
              </form> -->
            </div>
            <div class="col-md-12 col-lg-8 col-lg-offset-2">
              <p class="margin-bottom--zero"><img alt="" src="${pageContext.request.contextPath }/resources/assets/img/features3.png" class="img-responsive"></p>
            </div>
          </div>
        </div>
      </section>
	<section>
		<div class="container section background-gray-lightest">
			<h3><strong>최근 등록된 스터디</strong></h3>
			<%--스터디 모집 인기검색어 시작 --%>
			<div class="row" style="text-align: right;">
				<div class="col-sm-12" style="padding-right: 30px;"> 
					<strong>인기 검색어 TOP5</strong>
				</div>
			</div>
			<div class="row" style="padding-bottom: 15px;">
				<div class="col-sm-4"></div>	
				<div class="col-sm-6">
					<div class="row block ">
							<ul id="ticker">
								<c:forEach items="${keywordList}" var="kList" begin="0" end="4" varStatus="cnt">	 
									<li ><a href="${pageContext.request.contextPath}/recruit/findRecruitPostListByKeyword?keyword=${kList.KEYWORD}" >${kList.RANK}. ${kList.KEYWORD}</a></li>
								</c:forEach>
							</ul>
					</div>
				</div>
				<div class="col-sm-2 key-col" style="width: auto;">
					<div class="navi">
						<a href="javascaript:void(0);" class="btn btn-xs-default prev key-a"><i class="material-icons">keyboard_arrow_up</i></a>
						<a href="javascaript:void(0);" class="btn btn-xs-default next key-a"><i class="material-icons">keyboard_arrow_down</i></a>
						<a href="javascript:void(0);" class="btn btn-xs-default key-a"><i class="material-icons"  id="pause" > pause </i></a>
					</div>
				</div><%--col --%>
			</div><%--row --%>
		
			<%--스터디 모집 인기검색어 끝 --%>
			<%--최근 모집 글 5개 시작 --%>
			<div class="row">
					<table class="table table-hover">
						<thead>
							<tr>
								<td>번호</td>
								<td>카테고리</td>
								<td>제목</td>
								<td>지역</td> 
								<td>작성자</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${recruitPostList}" var="rpList" varStatus="cnt">
								<tr onclick="findDetailRecruitPostInfoByRecruitNo(${rpList.recruitPostNo})">
									<td>${rpList.recruitPostNo}</td>
									<td>[${rpList.smallCategoryVO.bigCategoryVO.name}/${rpList.smallCategoryVO.name}]</td>
									<td>${rpList.title}</td>
									<td>${rpList.location}</td>
									<td>${rpList.memberVO.name}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
			</div><%--row --%>
		<%--최근 모집 글 5개 끝 --%>
		</div>
		<div class="row" style="padding-top: 20px;">
			<div class="col-sm-2"></div>
			<div class="col-sm-8">
				<button onclick="createRecruitPost()" class="btn btn-warning">새 스터디 모집</button>
			</div>
			<div class="col-sm-2"></div>
		</div><%--row --%>
		<%--container --%>
	</section>
	
	
	<%--인기 업체 3곳 조회 --%>
	<section class="section testimonails background-gray-lightest">
		<div class="container">
			<h2 class="text-center" style="padding-bottom: 50px;"><strong>인기 스터디 룸 TOP3</strong></h2>
			<div class="row">
				<form action="${pageContext.request.contextPath }/company/findDetailCompanyInfoByCompanyNo" method="post" id="imgForm">
				<input type="hidden" id="companyNo" name="companyNo">
	      			<c:forEach items="${companyList }" begin="0" end="2" var="clist">
	          			<div class="col-sm-4 ">
	           				<div class="box box-services">
	           					<h5 style="text-align: right;"><span class="label label-danger">HIT ${clist.hit}</span></h5>
	              				<img src="${pageContext.request.contextPath }/resources/upload/${clist.profilePath}" style="width: 300px; height: 200px" onclick="return goDetail(${clist.companyNo})">
	              				<div class="text-center" style="font-size: 30px;">
	              					<strong>${clist.name }</strong> 
	              				</div>
	              				<div style="font-size: 14px; color: #AB8888; font-weight: bold;">${clist.addr1 } ${clist.addr2 } ${clist.addr3 }</div><br>
	              				<p>${clist.intro }</p>
	            			</div>
	          			</div>
	         		</c:forEach>
         		</form>
			</div><%--row --%>
		</div><%--container --%>
	</section>
	
	<%-- --%>
      <section id="contact" > 
        <div class="container">
          <div class="row">
            <div class="col-md-4">
              <div class="box-simple">
                <div class="icon"><i class="pe-7s-map-2"></i></div>
                <h3>Address</h3>
                <p>13/25 New Avenue<br>New Heaven, 45Y 73J<br>England, <strong>Great Britain</strong></p>
              </div> 
            </div>
            <div class="col-md-4">
              <div class="box-simple">
                <div class="icon"><i class="pe-7s-phone"></i></div>
                <h3>Call center</h3>
                <p class="text-muted">This number is toll free if calling from Great Britain otherwise we advise you to use the electronic form of communication.</p>
                <p><strong>+33 555 444 333</strong></p>
              </div>
            </div>
            <div class="col-md-4">
              <div class="box-simple">
                <div class="icon"><i class="pe-7s-mail-open-file"></i></div>
                <h3>Electronic support</h3>
                <p class="text-muted">Please feel free to write an email to us or to use our electronic ticketing system.</p>
                <p><strong><a href="mailto:">info@bootstrap.com</a></strong></p>
              </div>
            </div>
          </div>
        </div>
      </section>
		
		

<script>
$(document).ready(function(){
		var ticker = function(){
			timer = setTimeout(function(){
				$('#ticker li:first').animate( {marginTop: '-20px'}, 400, function(){
					$(this).detach().appendTo('ul#ticker').removeAttr('style');
				});
				ticker();
			}, 3000);         
		};
		// 0번. 이전 기능
		$(document).on('click','.prev',function(){
			$('#ticker li:last').hide().prependTo($('#ticker')).slideDown();
			clearTimeout(timer);
			ticker();
			if($('#pause').text() == 'play_arrow'){
				$('#pause').text('pause');
			};
		}); // 0번 기능 끝
			  
		// 1. 클릭하면 다음 요소 보여주기
		$(document).on('click','.next',function(){
			$('#ticker li:first').animate( {marginTop: '-20px'}, 400, function(){
				$(this).detach().appendTo('ul#ticker').removeAttr('style');
			});
			clearTimeout(timer);
			ticker();
			//3 함수와 연계 시작
			if($('#pause').text() == 'play_arrow'){
				$('#pause').text('pause');
			}; //3 함수와 연계
		}); // next 끝
	
		// 2. 재생정지 함수 시작. 
		var autoplay =true;
		$(document).on('click', '#pause', function(){
			$this = $(this);
			if(autoplay==true){
				$this.text('play_arrow');
				clearTimeout(timer);
				autoplay=false; 
			}else {
				 ticker();
				$this.text('pause');
				autoplay=true;
			}
		})
		
		//3. 마우스를 올렸을 때 기능 정지
		var tickerover = function(){
			$('#ticker').mouseover(function(){
				clearTimeout(timer);
			});
			$('#ticker').mouseout(function(){
				ticker();
			});  
		};
		tickerover();
		
		// 4 끝
		ticker();
	});
	
	
	
	
	//작성: 유동규
	//기능: 상세글 보기로 이동
	//로직: 테이블의 행을 클릭하여 해당 글의 상세페이지로 이동한다. 
	function findDetailRecruitPostInfoByRecruitNo(recruitNo) {
		 location.href= "${pageContext.request.contextPath }/recruit/findDetailRecruitPostInfoByRecruitNo?recruitNo="+recruitNo+"&nowPage=1";  
	}
	
	
	//작성: 유동규
	//기능: 새 스터디 모집 이동
	function createRecruitPost(){
		location.href="${pageContext.request.contextPath}/recruit/createRecruitPostView";
	}
 	
	//작성: 유동규
	//기능 : 업체 상세보기 페이지로 이동(POST)
	function goDetail(compNo){
		$("#companyNo").val(compNo);
		$("#imgForm").submit();
	}
	
</script>
