<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.add {
	background-color: rgb(96, 201, 255);
	color: rgb(255, 255, 255);
}

.tag{
	border-radius: 40%;
}

.picFile{
	width: 100%;
}

.noresize {
  resize: none; /* 사용자 임의 변경 불가 */
}
</style>
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
	$(document).ready(function(){
		$("#license").keyup(function(){
			$("#licenseCheck").html($(this).val());
		});
		
		// open time에 따라 close time을 동적 할당
		$("#timeSelect1").change(function(){
			console.log("timeSelect1 val: "+$(this).val());
			console.log("timeSelect1 parsInt: "+parseInt($(this).val(),10));
			var endTime = "";
			for(var i=parseInt($(this).val(),10)+1; i<25; i++){
				if(i<10){
					endTime+="<option value=0"+i+">"+"0"+i+"</option>";
				}else{
					endTime+="<option value="+i+">"+i+"</option>";
				}
			}
			$("#timeSelect2").html(endTime);
		});//change

	    $("#intro").keyup(function(){
	    	var textlength = $(this).val().length;
	    	$("#max-intro").html(textlength+"/980");
	    	if(textlength == 981){
	    		alert("글자수가 초과하였습니다.");
	    	}
		});//keyup
		
		// 선택 요일 데이터 받기
		var $daysBtn = $('#days .btn');
		var $days = "";
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
			for(var i=0; i<$this.val().split(',').length; i++){
				$tagsplit+="<input type='button' class='btn btn-success tag' value='#"+$this.val().split(',')[i]+"'>&emsp;";
			}
			if($tagsplit == "<input type='button' class='btn btn-success tag' value='#'>&emsp;"){
				$('#tag-ex').html('');	
			}else{
				$('#tag-ex').html($tagsplit);
			}
			$tagsplit = '';
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
		
		//사진 업로드 추가(스터디룸)
		var studyRoomPicmax = 0;
		$('#studyRoomFileBtn').on('click',function(){
			console.log('클릭됨');
			if(studyRoomPicmax>1){
				alert('더 이상 추가할 수 없습니다.');
			}else{
				$('div .studyRoomPicDiv').append('<br><input type="file" id="studyRoomPicFile" name="studyRoomPicFile" placeholder="추가 사진" class = "form-control studyRoomPicFile">');
				studyRoomPicmax++;
			}
		});
		
		// 연락처 체크
		$("#tel").keyup(function(){
			$(this).val($(this).val().trim());
			if(isNaN($(this).val())||$(this).val()==""){
				$("#checkTelView").html("연락처가 잘못되었습니다.").css("color","red");
			}else{
				$("#checkTelView").html("OK").css("color","blue");
			}
		});// keyup
		
		//사업자 등록번호 체크
		$("#license").keyup(function(){
			var $this = $(this);
			$this.val($this.val().trim());
			if(isNaN($this.val())||$this.val()==""){
				$("#checkLicenseView").html("잘못된 입력입니다.").css("color","red");
			}else if($this.val().length<10){
				$("#checkLicenseView").html("사업자 등록번호 10자리를 입력해주세요.").css("color","red");
			}else{
				var licenseArray= ($this.val()+'').match(/\d{1}/g);
				
				// 합 / 체크키
				var sum = 0, key = [1, 3, 7, 1, 3, 7, 1, 3, 5];
				
				// 0 ~ 8 까지 9개의 숫자를 체크키와 곱하여 합에더합니다.
				for (var i = 0 ; i < 9 ; i++) { sum += (key[i] * Number(licenseArray[i])); }
				
				// 각 8번배열의 값을 곱한 후 10으로 나누고 내림하여 기존 합에 더합니다.
				// 다시 10의 나머지를 구한후 그 값을 10에서 빼면 이것이 검증번호 이며 기존 검증번호와 비교하면됩니다.
				if(10 - ((sum + Math.floor(key[8] * Number(licenseArray[8]) / 10)) % 10) == Number(licenseArray[9])){
					$("#checkLicenseView").html("OK").css("color","blue");
					/* $.ajax({
						type:"get",
						dateType:"json",
						url:"${pageContext.request.contextPath}/ajax/findCheckByLicense",
						data:"license="+$this.val(),
						success:function(data){
						console.log("data: "+data);
							if(data==true){
								$("#checkLicenseView").html("OK").css("color","blue");
							}else{
								$("#checkLicenseView").html("이미 등록된 사업자 입니다.").css("color","red");
							}
						}//callback
					});//ajax */
				}else{
					$("#checkLicenseView").html("잘못된 사업자 등록 번호 입니다.").css("color","red");
				}
			}
		});// key up
		
		// 주소 입력 체크
		// 기본 주소 + 상세주소를 hidden에 담아 controller로 전달할 때 사용
		var addr = '';
		$("#addrDetail").keyup(function(){
			if($("#sample6_address").val()==""){
				alert("먼저 [우편번호 찾기]를 진행해주세요.");
				$("#addrDetail").val("").focus();
			}else{
			console.log("addr1: "+$("#sample6_address").val());
			console.log("addDetail: "+$("#addrDetail").val());
			addr = $("#sample6_address").val()+" "+$("#addrDetail").val();
			console.log("addr: "+addr);
			var addr3='';
			for(var i=0; i<addr.split(' ').length; i++){
				if(i==0||i==1){
					$('#addr'+(i+1)).val(addr.split(' ')[i]);
				}else{
					addr3+=addr.split(' ')[i]+' ';
				}
			}
			$('#addr3').val(addr3);
			console.log($('#addr1').val()+', '+$('#addr2').val()+', '+$('#addr3').val());
			};
		});
	});//ready
	
	
	
</script>

<section>
<div class="col-sm-2" ></div>
	<div class="col-sm-6">
            <form action="${pageContext.request.contextPath }/company/registerCompany" method="post" class="form-horizontal" role="form" enctype="multipart/form-data">
  <div class="container">
  <h2>STUD-IT 업체 등록</h2>
  <p>Step1 ~ Step3 까지 내용을 다 채운 뒤 등록을 누르면, 관리자가 확인 후 승인해드립니다.</p>
  <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#step1">Step1</a></li>
    <li><a data-toggle="tab" href="#step2">Step 2</a></li>
    <li><a data-toggle="tab" href="#step3">Step 3</a></li>
  </ul>

  <div class="tab-content">
    <div id="step1" class="tab-pane fade in active"><br><br>
    	 <div class="form-group">
         	<label for="companyName" class="col-sm-3 control-label">상호명</label>
            	 <div class="col-sm-9">	
                	 <input type="text" id="companyName" name="companyVO.name" placeholder="Company Name" required="required" class="form-control" autofocus><br>
                 </div>
         </div>
                
         <div class="form-group">
                    <label for="addrSerchBtn" class="col-sm-3 control-label">주소</label>
                    <div class="col-sm-9">
                       <!--  <input type="text" id="sample6_postcode" placeholder="우편번호"> -->
						<input type="button" name="addrSerchBtn" id="addrSerchBtn" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"  class="control-label btn btn-default">
						<input type="text" id="sample6_address" readonly="readonly"   placeholder="주소" class="form-control"><br>
						<input type="text" id="addrDetail" placeholder="상세주소" class="form-control" required="required">
						<input type="hidden" id="addr" name="addr">
						<input type="hidden" id="addr1" name="companyVO.addr1">
						<input type="hidden" id="addr2" name="companyVO.addr2">
						<input type="hidden" id="addr3" name="companyVO.addr3">
						<input type="hidden" id="addr4" name="companyVO.addr4" value="임시">
						
						<!-- map 위도, 경도 임시 -->
						<input type="hidden" name="companyVO.latitude" value="10">
						<input type="hidden" name="companyVO.longitude" value="20">
                    </div>
                </div>
                
          <div class="form-group">
         		<label for="tel" class="col-sm-3 control-label" >전화번호</label>
                	 <div class="col-sm-9">
                        <input type="text" id="tel" name="companyVO.tel" maxlength="11" placeholder="021234567" class="form-control"><br>
                      <div id="checkTelView"></div>
                 </div>
          </div>
                
          <div class="form-group">
          	 <label for="license" class="col-sm-3 control-label">사업자등록번호</label>
            	 <div class="col-sm-9">	
                	 <input type="text" id="license" name="companyVO.license" maxlength="10" placeholder="사업자 등록번호 10자리" class="form-control" autofocus><br>
                 <div id="checkLicenseView"></div>
         </div>
   	 </div>
   </div><!-- step1 --> 
    <div id="step2" class="tab-pane fade"><br><br>
    		<div class="form-group">
            		<label for="url" class="col-sm-3 control-label">업체 URL</label>
                    <div class="col-sm-9">	
                        <input type="text" id="url" name="companyVO.url" placeholder="http://www.stud-it.com" class="form-control" autofocus><br>
                    </div>
            	</div>
            	
            	<div class="form-group">
            		<label for="" class="col-sm-3 control-label">영업일</label>
                    <div class="col-sm-9">	
                    	<div id="days" class="btn-group" role="group" aria-label="...">
							<input type="button" class="btn btn-default" value="월" >
					        <input type="button" class="btn btn-default" value="화" >
					        <input type="button" class="btn btn-default" value="수" >
					        <input type="button" class="btn btn-default" value="목 ">
					        <input type="button" class="btn btn-default" value="금" >
					        <input type="button" class="btn btn-default" value="토" >
					        <input type="button" class="btn btn-default" value="일" >
					        <input type="hidden" id="day" name="day">
					        <span></span>
						</div>
                    </div>
            	</div>
            	
            	<div class="form-group">
            		<label for="" class="col-sm-3 control-label">영업 시간</label>
                    <div class="col-sm-9">
                    	시작 시간
                    	 <select id="timeSelect1" name="companyVO.open">
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
       							<option value="24"> 24 </option>
  					  </select>
  					  &emsp;&emsp;
  					  마감 시간
                    	 <select id="timeSelect2" name="companyVO.close">
       							<option value=""> --- </option>
  					  </select>
                    </div>
            	</div>
            	
            	<div class="form-group">
            		<label for="" class="col-sm-3 control-label">공휴일 영업 유무</label>
                    <div class="col-sm-9">	
						<label><input type='radio' name='companyVO.holiday' value='정상 영업' checked='checked'/>정상 영업</label>&emsp;&emsp;
						<label><input type='radio' id="test" name='companyVO.holiday' value='휴무' />휴무</label>
                    </div>
            	</div>
            	
            	<div class="form-group text-right">
            		<label for="intro" class="col-sm-3 control-label">업체 소개</label><span id="max-intro">0/980</span><br>
                    <div class="col-sm-9">	
                    	<textarea id="intro" name="companyVO.intro" class="noresize" rows="20" cols="100" maxlength="980" placeholder="업체에 대해 소개해주세요. (ex_분위기, 특별한 점 등)"></textarea>
                    </div>
            	</div>
            	
            	<div class="form-group">
                    <label for="picFile" class="col-sm-3 control-label">업체 사진</label>
                    <div class="col-sm-8 picDiv">
                        <input type="file" id="picFile" name="companyPicFile" placeholder="대표 사진" class = "form-control picFile">
                    </div>
                    <div class="col-sm-1"><input type="button" id="fileBtn" value="추가" class = "btn btn-default"></div>
                </div>
                
                <div class="form-group">
                    <label for="hashtag" class="col-sm-3 control-label">해시태그</label>
                    <div class="col-sm-4">
                        <input type="text" id="hashtag" name="hashtag" placeholder="독서, 로맨틱, 성공적 (최대 3가지)" class="form-control"><br>
                        </div>
                         <div class="col-sm-5">
                        <span id="tag-ex"></span>
                    </div>
                </div>
    </div>
    
    <div id="step3" class="tab-pane fade"><br><br>
    	<h3>스터디룸 등록</h3><br><br>
    	
    	 <div class="form-group">
	          	 <label for="studyRoomName" class="col-sm-3 control-label">스터디룸 명</label>
	             <div class="col-sm-9">
	                 <input type="text" id="studyRoomName" name="name" placeholder="무궁화, 나팔꽃" class = "form-control">
	             </div>
	         </div>
                
          <div class="form-group">
              <label for="capacity" class="col-sm-3 control-label">수용 인원</label>
              <div class="col-sm-2">
                  <input type="number" id="capacity" name="capacity" placeholder="6" class = "form-control">
              </div>
              <label for="price" class="col-sm-2 control-label">이용 가격</label>
              <div class="col-sm-2">
                  <input type="number" id="price" name="price" placeholder="시간당 가격" class = "form-control">
                  </div>
                  <div class="col-sm-1">
                  원/시간
              </div>
          </div>
          
          <div class="form-group">
              <label for="content" class="col-sm-3 control-label">내용</label>
              <div class="col-sm-8">
                  <textarea id="content" name="content" class="noresize" rows="6" cols="60" maxlength="179" placeholder="스터디룸에 대해 소개해주세요. (ex_이용인원, 목적 등)"></textarea>
              </div>
          </div>
          
          <div class="form-group">
              <label for="studyRoomPicFile" class="col-sm-3 control-label">스터디룸 사진</label>
              <div class="col-sm-8 studyRoomPicDiv">
                  <input type="file" id="studyRoomPicFile" name="studyRoomPicFile" placeholder="대표 사진" class = "form-control studyRoomPicFile">
              </div>
               <div class="col-sm-1"><input type="button" id="studyRoomFileBtn" value="추가" class = "btn btn-default"></div>
          </div>
          
          <div class="form-group">
          	 <div class="col-sm-5 col-sm-offset-3">
                        <button type="submit" class="btn btn-primary btn-block" onsubmit="return true">등록하기</button>
             </div>
          </div>
    </div>
 </div> <!-- Container -->           
            </div>
            </form> <!-- /form -->
        </div> <!-- /container -->
     <div class="col - sm- 3" ></div>  
</section>
