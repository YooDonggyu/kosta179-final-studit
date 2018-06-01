<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.add {
	background-color: rgb(96, 201, 255);
	color: rgb(255, 255, 255);
}

.formCategory{
	font-weight: bold;
}

.tag{
	border-radius: 40%;
}

.picFile{
	width: 100%;
}

.tab-head{
	height: 150px;
}

.srfunction{
	text-align: left;
}

.noresize {
  resize: none; /* 사용자 임의 변경 불가 */
}

.map{
	display: view;
}
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7089f989ad92f0b98ff8257f8cc869ef&libraries=services"></script>
<script>
		// 작성: 변태섭
		// 기능: 우편번호 API Sciprt
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                /* document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용 */
                document.getElementById('sample6_address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('addrDetail').focus();
            }
        }).open();
    }
</script>

<script>
	// 작성: 변태섭
	// 기능: 업체 등록 체크
	// 로직: 사업자등록번호 체크, 연락처 체크, 영업정보 체크, Submit 시 모든 조건 체크
	
	var addrFlag = false;
	var telFlag = false;
	var licenseFlag = false;
	var companyNameFlag = false;
	var urlFlag = false;
	var introFlag = false;
	$(document).ready(function(){
		
		// Business Time Check Setting
		$("#timeSelect1 option:eq(${cvo.open})").attr("selected", "selected");
		$("#timeSelect2 option:eq(${cvo.close})").attr("selected", "selected");
		console.log('open, end: ${cvo.open}, ${cvo.close}');
		
		// Days Setting
		var $days = new Array();
			$days = '${days}';
		console.log($days);
		console.log($days.length);
		for(var d=0; d<$days.length; d++){
			if($days[d] == $('#monBtn').val()){
				$('#monBtn').addClass('add');
				$('#days').children('span').addClass('월');
				console.log();
			}
			if($days[d] == $('#tueBtn').val()){
				$('#tueBtn').addClass('add');
				$('#days').children('span').addClass('화');
			}
			if($days[d] == $('#wenBtn').val()){
				$('#wenBtn').addClass('add');
				$('#days').children('span').addClass('수');
			}
			if($days[d] == $('#thuBtn').val()){
				$('#thuBtn').addClass('add');
				$('#days').children('span').addClass('목');
			}
			if($days[d] == $('#friBtn').val()){
				$('#friBtn').addClass('add');
				$('#days').children('span').addClass('금');
			}
			if($days[d] == $('#satBtn').val()){
				$('#satBtn').addClass('add');
				$('#days').children('span').addClass('토');
			}
			if($days[d] == $('#sunBtn').val()){
				$('#sunBtn').addClass('add');
				$('#days').children('span').addClass('일');
			}
			$("#day").val($('#days').children('span').attr('class'));
			console.log('#day: '+$('#days').val());
		}
		
		// open time에 따라 close time을 동적 할당
		$("#timeSelect1").change(function(){
			var endTime = '';
			$("#timeSelect2").html('');
			console.log("timeSelect1 val: "+$(this).val());
			console.log("timeSelect1 parsInt: "+parseInt($(this).val(),10));
			for(var i=parseInt($(this).val(),10)+1; i<25; i++){
				if(i<10){
					endTime+="<option value=0"+i+">"+"0"+i+"</option>";
				}else{
					endTime+="<option value="+i+">"+i+"</option>";
				}
			}
			$("#timeSelect2").html(endTime);
		});//change
		
		$('#timeSelect2').on('change',function(){
			console.log('timeSelect2 change');
			var openFlag = parseInt($('#timeSelect1').val(),10);
			var endFlag = parseInt($('#timeSelect2').val(),10);
			if(openFlag >= endFlag){
				alert("종료 시간은 시작 시간보다 늦어야 합니다.");
				$('#timeSelect2 option:eq(${cvo.close})').attr('selected', 'selected');
			}
		});//change

	    $("#intro").keyup(function(){
	    	var textlength = $(this).val().length;
	    	$("#max-intro").html(textlength+"/980");
	    	if(textlength == 981){
	    		alert("글자수가 초과하였습니다.");
	    	}
		});//keyup
		
		/* var days='${days}';
		for(var i=0; i<days.length; i++){
			
		} */
		// 선택 요일 데이터 받기
		var $daysBtn = $('#days .btn');
		console.log('Test: '+$daysBtn.length);
		for(var i=0; i<$daysBtn.length; i++){
			console.log($daysBtn[i]);
		}
		$daysBtn.on('click',function(){
			var $this = $(this);
			var $span = $this.parents().children('span');
			$this.toggleClass('add');
			$span.toggleClass($this.val());
			$("#day").val($span.attr('class'));
			console.log($("#day").val());
		});//on
		
		// 해시태그 입력
		$("#hashtag").on('keyup',function(){
			var $tagsplit = '';
			var $maxtag = '';
			var $this = $(this);
			var keycount = ($this.val().match(/,/g) || []).length;
			if(keycount>2){
					alert('해시태그는 최대 3개 가능합니다.');
					$maxtag = $this.val().substring(0,$this.val().length-1);
					$this.val($maxtag);
					console.log($maxtag);
			}
			console.log(keycount);
			
			var $tagtrim = $this.val().replace(' ','');
			$this.val($tagtrim);
			var $overTag = $this.val().split(',');
			var $tag = '';
				for(var i=0; i<$overTag.length; i++){
					if($overTag[i].length>8){
						alert('해시태그는 최대 8글자까지 가능합니다.');
						$tag = $overTag[i].substring(0,8);
						console.log('before tag maxtag: '+$maxtag);
					}else{
						$tag = $overTag[i];
					}
					if(i == 0){
						$maxtag = $tag;
						$tag='';
						console.log('i==0 maxtag: '+$maxtag);
					}else{
						$maxtag += ','+$tag;
						console.log('else maxtag: '+$maxtag);
						$tag='';
					}
						$this.val($maxtag);
					console.log('after maxtag: '+$maxtag);
				$tagsplit+="<input type='button' class='btn btn-success tag' value='#"+$this.val().split(',')[i]+"'>&emsp;";
			}
			if($tagsplit == "<input type='button' class='btn btn-success tag' value='#'>&emsp;"){
				$('#tag-ex').html('');	
			}else{
				$('#tag-ex').html($tagsplit);
			}
			$tagsplit = '';
			$maxtag = '';
		});//on keyup
		
		//사진 업로드 추가(업체)
		var picmax = 0;
		$('#fileBtn').on('click',function(){
			console.log('클릭됨');
			if(picmax>1){
				alert('더 이상 추가할 수 없습니다.');
			}else{
				$('div .picDiv').append('<br><input type="file" id="picFile" name="companyPicFile" placeholder="추가 사진" class = "form-control picFile">');
				picmax++;
			}
		});
		
		// 연락처 체크
		$("#tel").keyup(function(){
			$(this).val($(this).val().trim());
			if(isNaN($(this).val())||$(this).val()==""){
				$("#checkTelView").html("연락처가 잘못되었습니다.").css("color","red");
				telFlag = false;
			}else{
				$("#checkTelView").html("OK").css("color","blue");
				telFlag = true;
			}
		});// keyup
		
		//사업자 등록번호 체크
		$("#license").keyup(function(){
			var $this = $(this);
			$this.val($this.val().trim());
			if(isNaN($this.val())||$this.val()==""){
				$("#checkLicenseView").html("잘못된 입력입니다.").css("color","red");
				licenseFlag = false;
			}else if($this.val().length<10){
				$("#checkLicenseView").html("사업자 등록번호 10자리를 입력해주세요.").css("color","red");
				licenseFlag = false;
			}else{
				var licenseArray= ($this.val()+'').match(/\d{1}/g);
				
				// 합 / 체크키
				var sum = 0, key = [1, 3, 7, 1, 3, 7, 1, 3, 5];
				
				// 0 ~ 8 까지 9개의 숫자를 체크키와 곱하여 합에더합니다.
				for (var i = 0 ; i < 9 ; i++) { sum += (key[i] * Number(licenseArray[i])); }
				
				// 각 8번배열의 값을 곱한 후 10으로 나누고 내림하여 기존 합에 더합니다.
				// 다시 10의 나머지를 구한후 그 값을 10에서 빼면 이것이 검증번호 이며 기존 검증번호와 비교하면됩니다.
				if(10 - ((sum + Math.floor(key[8] * Number(licenseArray[8]) / 10)) % 10) == Number(licenseArray[9])){
					//$("#checkLicenseView").html("OK").css("color","blue");
					$.ajax({
						type:"get",
						dateType:"json",
						url:"${pageContext.request.contextPath}/ajax/findCheckByLicense",
						data:"license="+$this.val(),
						success:function(data){
						console.log("data: "+data);
							if(data==true){
								$("#checkLicenseView").html("OK").css("color","blue");
								licenseFlag = true;
							}else{
								$("#checkLicenseView").html("이미 등록된 사업자 입니다.").css("color","red");
								licenseFlag = false;
							}
						}//callback
					});//ajax
				}else{
					$("#checkLicenseView").html("잘못된 사업자 등록 번호 입니다.").css("color","red");
					licenseFlag = false;
				}
			}
		});// key up
		
		// 주소 입력 체크
		// 기본 주소 + 상세주소를 hidden에 담아 controller로 전달할 때 사용
		var addr = '';
		$("#addrDetail").keyup(function(){
			if($("#sample5_address").val()==""){
				alert("먼저 [주소 찾기]를 진행해주세요.");
				$("#addrDetail").val("").focus();
			}else{
			console.log("addr1: "+$("#sample5_address").val());
			console.log("addDetail: "+$("#addrDetail").val());
			addr = $("#sample5_address").val()+" "+$("#addrDetail").val();
			console.log("addr: "+addr);
			var addr4='';
			for(var i=0; i<addr.split(' ').length; i++){
				if(i<2){
					$('#addr'+(i+1)).val(addr.split(' ')[i]);
				}else if(i==2){
					if(addr.split(' ')[i].substring(addr.split(' ')[i].length-1) == '구' ){
						$('#addr'+(i+1)).val(addr.split(' ')[i]);					
					}else{
						$('#addr'+(i+1)).val('-');
						addr4 = addr.split(' ')[i];
					}
				}else{
					addr4+=addr.split(' ')[i]+' ';
				}
			}
			$('#addr4').val(addr4);
			console.log($('#addr1').val()+', '+$('#addr2').val()+', '+$('#addr3').val()+', '+$('#addr4').val());
			addrFlag = true;
			};
		}); //keyup
		
		//상호명 체크
		$('#companyName').on('keyup',function(){
			if($(this).val().trim()==''){
				console.log($(this).val().trim());
				companyNameFlag = false;
				console.log('cnFlag: '+companyNameFlag);
			}else{
				console.log($(this).val().trim());
				companyNameFlag = true;
				console.log('cnFlag: '+companyNameFlag);
			}
		});//on
		
		//url 체크
		$('#url').on('keyup',function(){
			if($(this).val().trim()==''){
				console.log($(this).val().trim());
				urlFlag = false;
				console.log('urlFlag: '+urlFlag);
			}else{
				console.log($(this).val().trim());
				urlFlag = true;
				console.log('urlFlag: '+urlFlag);
			}
		});//on
		
		//intro 체크
		$('#intro').on('keyup',function(){
			if($(this).val().trim()==''){
				console.log($(this).val().trim());
				introFlag = false;
				console.log('introFlag: '+introFlag);
			}else{
				console.log($(this).val().trim());
				introFlag = true;
				console.log('introFlag: '+introFlag);
			}
		});//on
		
		$('#sample6_address').on('change',function(){
		/* 	console.log($('#map').attr('map')); */
		console.log('change');
			mapAddr = $(this).val();
		});
		
		$('.step').on('click',function(){
			console.log('tab click:'+$(this).html().substring(5));
			var stepNo=$(this).html().substring(5);
			if(stepNo<3){
				$('.tab-head').html('<h2>STUD-IT 업체 등록</h2><p>Step1 ~ Step3 까지 내용을 다 채운 뒤 등록을 누르면, 관리자가 확인 후 승인해드립니다.</p>');
			}else{
				$('.tab-head').html('<h2>STUD-IT 스터디룸 등록</h2><p>Step3. 업체에서 보유 중인 스터디룸의 정보를 입력해주세요.<br>추가적인 스터디룸은 업체 등록 후 업체 관리에서 등록 가능합니다.</p>');
			}
		});
	});//ready

	// submit Btn
	function registerFlag(){
		if(!companyNameFlag){
			alert("상호명을 확인해주세요.");
			return false;
		}else if(!addrFlag){
			alert("상세주소를 확인해주세요.");
			return false;
		}else if(!telFlag){
			alert("전화번호를 확인해주세요.");
			return false;
		}else if(!urlFlag){
			alert("업체 url을 확인해주세요.");
			return false;
		}else if($("#day").val()==''){
			alert("영업요일을 선택해주세요.");
			return false;
		}else if(!introFlag){
			alert("업체 소개를 확인해주세요.");
			return false;
		}else if($("#hashtag").val()==''){
			alert("해시태그를 등록해주세요.");
			return false;
		}else{
			return true;
		}
	}
	
</script>

<section>
	<div class="col-sm-6" style="padding-left:0px;">
            <form action="${pageContext.request.contextPath }/company/updateCompany" method="post" class="form-horizontal" role="form" enctype="multipart/form-data">
  <div class="container">
	  <div class="tab-head">
		  <h2>STUD-IT 업체 정보 수정</h2>
	  </div>
  <ul class="nav nav-tabs">
    <li class="active"><a class="step" data-toggle="tab" href="#step1">Step 1</a></li>
    <li><a data-toggle="tab" class="step" href="#step2">Step 2</a></li>
  </ul>

  <div class="tab-content">
    <div id="step1" class="tab-pane fade in active"><br><br>
    	<input type="hidden" name="companyNo" value="${cvo.companyNo }">
    	 <div class="form-group">
         	<label for="companyName" class="col-sm-2 control-label formCategory">상호명</label>
            	 <div class="col-sm-6">	
                	 <input type="text" id="companyName" name="name" value="${cvo.name }" required="required" class="form-control" autofocus><br>
                 </div>
         </div>
                
		        		 <div class="form-group">
		                    <label for="addrSerchBtn" class="col-sm-2 control-label formCategory">주소</label>
		                    <div class="col-sm-6">
								<input type="button" name="addrSerchBtn" id="addrSerchBtn" onclick="sample5_execDaumPostcode()" value="주소 찾기"  class="col-sm-12 control-label btn btn-default" style="text-align:center;">
								<input type="text" id="sample5_address" name="primaryAddr" readonly="readonly" value="${cvo.primaryAddr }" class="form-control"><br>
								<input type="text" id="addrDetail" name="detailAddr" value="${cvo.detailAddr }" class="form-control" required="required">
								<input type="hidden" id="addr" name="addr">
								<input type="hidden" id="addr1" name="addr1">
								<input type="hidden" id="addr2" name="addr2">
								<input type="hidden" id="addr3" name="addr3">
								<input type="hidden" id="addr4" name="addr4">
								<div id="map" style="height:300px;margin-top:10px;display:none"></div>
		                    </div>
		                </div>
		                
		          <div class="form-group">
		         		<label for="tel" class="col-sm-2 control-label formCategory" >전화번호</label>
		                	 <div class="col-sm-6">
		                        <input type="text" id="tel" name="tel" maxlength="11" required="required" value="${cvo.tel }" class="form-control"><br>
		                      <div id="checkTelView"></div>
		                 </div>
		          </div>
		                
		          <div class="form-group">
		          	 <label for="license" class="col-sm-2 control-label formCategory">사업자등록번호</label>
		            	 <div class="col-sm-6">	
		                	 <input type="text" readonly="readonly" value="${cvo.license }" class="form-control" autofocus><br>
			         </div>
			   	 </div>
		   </div><!-- step1 --> 
		    <div id="step2" class="tab-pane fade"><br><br>
		    		<div class="form-group">
		            		<label for="url" class="col-sm-2 control-label formCategory">업체 URL</label>
		                    <div class="col-sm-6">	
		                        <input type="text" id="url" name="url" placeholder="http://www.stud-it.com" value="${cvo.url }" required="required" class="form-control" autofocus><br>
		                    </div>
		            	</div>
		            	
		            	<div class="form-group">
		            		<label for="" class="col-sm-2 control-label formCategory">영업요일</label>
		                    <div class="col-sm-6">	
		                    	<div id="days" class="btn-group" role="group" aria-label="...">
									<input type="button" id="monBtn" class="btn btn-default" value="월" >
							        <input type="button" id="tueBtn" class="btn btn-default" value="화" >
							        <input type="button" id="wenBtn" class="btn btn-default" value="수" >
							        <input type="button" id="thuBtn" class="btn btn-default" value="목">
							        <input type="button" id="friBtn" class="btn btn-default" value="금" >
							        <input type="button" id="satBtn" class="btn btn-default" value="토" >
							        <input type="button" id="sunBtn" class="btn btn-default" value="일" >
							        <input type="hidden" id="day" name="day">
							        <span></span>
								</div>
		                    </div>
		            	</div>
		            	
		            	<div class="form-group">
		            		<label for="" class="col-sm-2 control-label formCategory">영업 시간</label>
		                    <div class="col-sm-6">
		                    	시작 시간
		                    	 <select id="timeSelect1" name="open">
		       							<option value="00"> 00 </option>
		       							<option value="01"> 01 </option>
		       							<option value="03"> 03 </option>
		       							<option value="04"> 04 </option>
		       							<option value="05"> 05 </option>
		       							<option value="06"> 06 </option>
		       							<option value="07"> 07 </option>
		       							<option value="08"> 08 </option>
		       							<option value="09"> 09 </option>
		       							<option value="10"> 10 </option>
		       							<option value="11"> 11 </option>
		       							<option value="12"> 12 </option>
		       							<option value="13"> 13 </option>
		       							<option value="14"> 14 </option>
		       							<option value="15"> 15 </option>
		       							<option value="16"> 16 </option>
		       							<option value="17"> 17 </option>
		       							<option value="18"> 18 </option>
		       							<option value="19"> 19 </option>
		       							<option value="20"> 20 </option>
		       							<option value="21"> 21 </option>
		       							<option value="22"> 22 </option>
		       							<option value="23"> 23 </option>
		  					  </select>
		  					  &emsp;&emsp;
		  					  마감 시간
		                    	 <select id="timeSelect2" name="close">
		                    	 		<option value="00"> 00 </option>
		       							<option value="01"> 01 </option>
		       							<option value="02"> 02 </option>
		       							<option value="03"> 03 </option>
		       							<option value="04"> 04 </option>
		       							<option value="05"> 05 </option>
		       							<option value="06"> 06 </option>
		       							<option value="07"> 07 </option>
		       							<option value="08"> 08 </option>
		       							<option value="09"> 09 </option>
		       							<option value="10"> 10 </option>
		       							<option value="11"> 11 </option>
		       							<option value="12"> 12 </option>
		       							<option value="13"> 13 </option>
		       							<option value="14"> 14 </option>
		       							<option value="15"> 15 </option>
		       							<option value="16"> 16 </option>
		       							<option value="17"> 17 </option>
		       							<option value="18"> 18 </option>
		       							<option value="19"> 19 </option>
		       							<option value="20"> 20 </option>
		       							<option value="21"> 21 </option>
		       							<option value="22"> 22 </option>
		       							<option value="23"> 23 </option>
		       							<option value="24"> 24 </option>
		  					  	</select>
		                    </div>
		            	</div>
		            	
		            	<div class="form-group">
		            		<label for="" class="col-sm-2 control-label formCategory">공휴일 영업 유무</label>
		                    <div class="col-sm-6">	
								<label><input type='radio' name='holiday' value='영업' checked='checked'/>영업</label>&emsp;&emsp;
								<label><input type='radio' id="test" name='holiday' value='휴업' />휴업</label>
		                    </div>
		            	</div>
		            	
		            	<div class="form-group text-right">
		            		<label for="intro" class="col-sm-2 control-label formCategory">업체 소개</label>
		            		<div class="col-sm-6">
		                    	<span id="max-intro">0/980</span>
		                    </div><br>
		                    <div class="col-sm-6 text-left">	
		                    	<textarea id="intro" name="intro" class="noresize" rows="20" cols="67" required="required" maxlength="980" placeholder="업체에 대해 소개해주세요. (ex_분위기, 특별한 점 등)">${cvo.intro }</textarea>
		                    </div>
		            	</div>
		            	
		            	<div class="form-group">
		                    <label for="picFile" class="col-sm-2 control-label formCategory">업체 사진</label>
		                    <div class="col-sm-6 picDiv">
		                        <input type="file" id="picFile" name="companyPicFile" placeholder="대표 사진" class = "form-control picFile">
		                    </div>
		                    <div class="col-sm-1"><input type="button" id="fileBtn" value="추가" class = "btn btn-default"></div>
		                </div>
		                
		                <div class="form-group">
		                    <label for="hashtag" class="col-sm-2 control-label formCategory">해시태그</label>
		                    <div class="col-sm-4">
		                    
		                    	<c:set var="hashtag" value=""/>
		                    	<c:forEach items="${hashtags }" var="tag" varStatus="info">
		                    		<c:choose>
			                    		<c:when test="${info.count eq 1 }">
				                    		<c:set var="hashtag" value="${tag.CONTENT }"/>
			                    		</c:when>
			                    		<c:otherwise>
				                    		<c:set var="hashtag" value="${hashtag },${tag.CONTENT }"/>
			                    		</c:otherwise>
		                    		</c:choose>
		                    	</c:forEach>
		                    	
		                        <input type="text" id="hashtag" name="hashtag" value="${hashtag }" placeholder="독서, 로맨틱, 성공적 (최대 3가지)" class="form-control"><br>
		                        </div>
		                         <div class="col-sm-5 text-left">
		                        <span id="tag-ex"></span>
		                    </div>
		                </div>
		                
		                <div class="form-group">
				          	 <div class="col-sm-6 col-sm-offset-2">
				                        <button type="submit" class="btn btn-primary btn-block" onclick="return registerFlag()">수정하기</button>
				             </div>
				         </div>
					</div>
				</div> <!-- Container -->           
            </div>
            </form> <!-- /form -->
        </div> <!-- /container -->
     <div class="col - sm- 2" ></div>  
</section>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7089f989ad92f0b98ff8257f8cc869ef&libraries=services"></script>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });

    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = fullAddr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    }
                });
            }
        }).open();
    }
</script>