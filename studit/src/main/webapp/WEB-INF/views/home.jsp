<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	.none{
		display:none
	}
	.navi{
		float:left;
	}
	.block {
		height:30px; 
		overflow:hidden; 
		}
	.block ul,
	.block li {
		font-size:25px;
		height: 40px;
		margin:0; 
		padding:0; 
		list-style:none;
	}
	.block li a {
		display:block; 
		height:20px; 
		line-height:20px; 
		padding: 7px;
		color:#555; 
		text-decoration:none;
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
		<div class="container section background-gray-lightest" >
			<h3>최근 등록된 스터디</h3>
			<div class="col-sm-4"></div>
			<div class="col-sm-4">
			<div class="row block ">
					<ul id="ticker">
						<c:forEach items="${keywordList}" var="kList" begin="0" end="4" varStatus="cnt">	 
							<li ><a href="javacript:void(0);">${cnt.count}. ${kList}</a></li>
						</c:forEach>
					</ul>
			</div>
			</div>
			<div class="col-sm-4">
			<div class="navi">
					    <a href="javascaript:void(0);" class="btn btn-xs-default prev"><i class="material-icons">keyboard_arrow_up</i></a>
					    <a href="javascaript:void(0);" class="btn btn-xs-default next"><i class="material-icons">keyboard_arrow_down</i></a>
					    <a href="javascript:void(0);" class="btn btn-xs-default "><i class="material-icons"  id="pause" > pause </i></a>
					</div>
				</div>
		</div>
	</section>



      <section id="contact" class="section background-gray-lightest"> 
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
</script>
