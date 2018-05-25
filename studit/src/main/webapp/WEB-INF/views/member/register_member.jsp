<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.formCategory{
	font-weight: bold;
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
		// 기능: 회원가입 체크
		// 로직: 주소입력체크, 이메일 형식 및 중복 체크, 비밀번호 일치 여부 체크, 연락처 체크, Submit 시 모든 조건 체크

		// submit 시 확인하는 flag
		var emailFlag = "";
		var retypePassFlag = "";
		var phoneFlag="";
		var addrFlag="";
		
	$(document).ready(function(){
		// 주소 입력 체크
		// 기본 주소 + 상세주소를 hidden에 담아 controller로 전달할 때 사용
		$("#addrDetail").keyup(function(){
			if($("#sample6_address").val()==""){
				alert("먼저 [우편번호 찾기]를 진행해주세요.");
				$("#addrDetail").val("").focus();
				addrFlag="";
			}else{
			console.log("addr1: "+$("#sample6_address").val());
			console.log("addDetail: "+$("#addrDetail").val());
			$("#addr").val($("#sample6_address").val()+" "+$("#addrDetail").val());
			console.log("addr: "+$("#addr").val());
			addrFlag=true;
			}
		});
		
		// 이메일 형식 및 중복 체크
		$("#memberEmail").keyup(function(){
			var curEmail = $(this).val();
			if(!$(this).val().match("@")){
				$("#checkEmailView").html("이메일 형식이 아닙니다.").css("color","red");
			}else{
				$.ajax({
					type:"get",
					dateType:"json",
					url:"${pageContext.request.contextPath}/ajax/findCheckByEmail",
					data:"memberEmail="+curEmail,
					success:function(data){
					console.log("data: "+data);
						if(data==true){
							$("#checkEmailView").html("OK").css("color","blue");
							emailFlag=true;
						}else{
							$("#checkEmailView").html("이미 가입된 이메일 입니다.").css("color","red");
							emailFlag="";
						}
					}//callback
				});//ajax
			}
		});
		
		// 비밀번호 일치 여부 체크
		$("#passwordCheck").keyup(function(){
			if($("#passwordCheck").val()!=$("#password").val()){
				$("#checkPasswordView").html("일치하지 않습니다.").css("color","red");
				retypePassFlag = "";
			}else{
				$("#checkPasswordView").html("OK").css("color","blue");
				retypePassFlag = true;
			}
		});
		
		// 연락처 체크
		$("#phone").keyup(function(){
			$(this).val($(this).val().trim());
			if(isNaN($(this).val())||$(this).val()==""){
				$("#checkPhoneView").html("연락처가 잘못되었습니다.").css("color","red");
				phoneFlag = "";
			}else{
				$("#checkPhoneView").html("OK").css("color","blue");
				phoneFlag = true;
			}
		});
		
	});
	// submit Btn
	function registerFlag(){
		var checkBox = $('[name=checkAccept]').is(':checked');
		console.log("checkBox: "+checkBox+", aF: "+addrFlag+", pF: "+phoneFlag+", pF: "+retypePassFlag+", eF: "+emailFlag);
		if(!emailFlag){
			alert("E-mail을 확인해주세요.");
			return false;
		}else if(!retypePassFlag){
			alert("비밀번호가 다릅니다.");
			return false;
		}else if(!addrFlag){
			alert("상세주소를 확인해주세요.");
			return false;
		}else if(!phoneFlag){
			alert("전화번호를 확인해주세요.");
			return false;
		}else if(!checkBox){
			alert("개인정보 수집을 동의해주세요.");
			return false;
		}else{
			return true;
		}
	}
</script>
	<section>
                <h2>STUD-IT 회원가입</h2><br><br>
	<div class="col-sm-3" ></div>
	<div class="col-sm-6">
            <form action="${pageContext.request.contextPath }/member/registerMember" method="post" class="form-horizontal" role="form" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="memberEmail" class="col-sm-2 control-label formCategory">이메일</label>
                    <div class="col-sm-9">	
                        <input type="email" id="memberEmail" name="memberEmail" placeholder="E-mail" class="form-control" autofocus><br>
                        <!-- <span class="help-block">Last Name, First Name, eg.: Smith, Harry</span> -->
                        <div id="checkEmailView"></div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password" class="col-sm-2 control-label formCategory">비밀번호</label>
                    <div class="col-sm-9">
                        <input type="password" id="password"  name= "password" placeholder="password" class="form-control">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="passwordCheck" class="col-sm-2 control-label formCategory">비밀번호 확인</label>
                    <div class="col-sm-9">
                        <input type="password" id="passwordCheck"  name="passwordCheck" placeholder="retype password" class="form-control"><br>
                        <div id="checkPasswordView"></div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="name" class="col-sm-2 control-label formCategory">이름</label>
                    <div class="col-sm-9">
                        <input type="text" id="name" name="name" placeholder="홍길동" class="form-control" required="required">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="addrSerchBtn" class="col-sm-2 control-label formCategory">주소</label>
                    <div class="col-sm-9">
                       <!--  <input type="text" id="sample6_postcode" placeholder="우편번호"> -->
						<input type="button" name="addrSerchBtn" id="addrSerchBtn" onclick="sample6_execDaumPostcode()" value="주소 찾기"  class="col-sm-12 control-label btn btn-default" style="text-align:center;">
						<input type="text" id="sample6_address" readonly="readonly"   placeholder="기본 주소" class="form-control"><br>
						<input type="text" id="addrDetail" placeholder="상세 주소" class="form-control" required="required">
						<input type="hidden" id="addr" name="addr">
                       <!--  <input type="text" id="addr" name="addr" placeholder="검색 후 상세주소를 입력하세요" class="form-control"> -->
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="phone" class="col-sm-2 control-label formCategory" >전화번호</label>
                    <div class="col-sm-9">
                        <input type="text" id="phone" name="phone" maxlength="11" placeholder="01012345678" class="form-control"><br>
                        <div id="checkPhoneView"></div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="passwordHint" class="col-sm-2 control-label formCategory">비밀번호 힌트</label>
                    <div class="col-sm-9">
                        <input type="text" id="passwordHint" name="passwordHint" placeholder="자주 가는 곳은?" class="form-control" required="required">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="passwordAnswer" class="col-sm-2 control-label formCategory">비밀번호 정답</label>
                    <div class="col-sm-9">
                        <input type="text" id="passwordAnswer" name="passwordAnswer" placeholder="studit" class="form-control" required="required">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="picFile" class="col-sm-2 control-label formCategory">프로필 사진</label>
                    <div class="col-sm-9">
                        <input type="file" id="picFile" name="picFile" class="form-control">
                    </div>
                </div>
                
                <div class="form-group">
                    <div class="col-sm-9 col-sm-offset-2">
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="checkAccept" id="checkAccept">개인정보 활용 방침에 동의합니다.  <a data-toggle="modal" data-target="#myModal">내용 보기</a>
                            </label>
                        </div>
                    </div>
                </div> <!-- /.form-group -->
                
				<!-- Modal -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content" style="border-radius: 5px; width: 750px;">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				        <h4 class="modal-title" id="myModalLabel">STUD-IT 개인정보 활용 방침</h4>
				      </div>
				      <div class="modal-body text-left"><br>
				     &emsp;고객님이 입력한 개인정보는 ‘정보통신망 이용촉진 및 정보보호 등에 관한 법률’에 따라 STUD-IT이<br>
				     &emsp;수집, 활용 및 취급 위탁 시 본인의 동의를 얻어야 하는 정보입니다. 입력하신 개인정보는 아래의<br>
				     &emsp;목적 이외의 다른 용도로는 활용되지 않습니다.<br><br>
				        <ul>
						    <li>
						    	1. 개인정보의 수집 및 이용목적 - 회사는 수집한 개인정보를 다음의 목적을 위해 이용합니다.
							    <ul>
								    <li>가. 컨텐츠 서비스 제공</li>
								    <li>나. 상품 설명 및 상담</li>
								    <li>다. 사생활 침해</li>
								    <li>라. 고객 혜택 지속제공 (제휴상품/서비스 제공) 등</li>
							    </ul>
						    </li>
  						</ul>	<br>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
				      </div>
				    </div>
				  </div>
				</div>
                
                <div class="form-group">
                    <div class="col-sm-9 col-sm-offset-2">
                        <button type="submit" class="btn btn-primary btn-block" onclick="return registerFlag()">가입하기</button>
                    </div>
                </div>
            </form> <!-- /form -->
        </div> <!-- ./container -->
        <div class="col - sm- 3" ></div>
        </section>