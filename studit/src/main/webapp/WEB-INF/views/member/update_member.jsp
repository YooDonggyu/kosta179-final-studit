<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.formCategory{
	font-weight: bold;
}	
#picDiv{
	width: 150px;
 	/* margin-top: 50px;  */
}
#picDiv img{
	max-width: 100%;
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
    $(document).ready(function() {
	var selFile;
	//작성: 김유란
	//기능: 사진파일 선택시 미리 보여주기	
		$("#picFile").on("change", function(e){
			var files = e.target.files;
			var filesArr = Array.prototype.slice.call(files);
			
			filesArr.forEach(function(f) {
				if(!f.type.match("image.*")){
					alert("이미지 파일을 선택하세요.");
					return false;
				}
				
				selFile = f;
				
				var reader = new FileReader();
				reader.onload = function(e){
					$("#picView").attr("src", e.target.result);
				}
				reader.readAsDataURL(f);
			})//each
		})//on
		
		$("#submitBtn").click(function(){
			 if($("#name").val()==""){
				 alert("이름을 입력하세요.");
				 return false;
			 }else if($("#addrDetail").val()==""){
				 alert("주소를 입력하세요.");
				 return false;
			 }else if($("#phone").val()==""){
				 alert("전화번호를 입력하세요.");
				 return false;
			 }else if($("#passwordHint").val()==""){
				 alert("비밀번호 힌트를 입력하세요.");
				 return false;
			 }else if($("#passwordAnswer").val()==""){
				 alert("비밀번호 답변을 입력하세요.");
				return false;
			} 
			$("#updateForm").submit();
		})//click
	})//ready
</script>

<div class="col-sm-3"></div>
<div class="col-sm-6">
	<form class="form-horizontal" role="form" method="post" action="${pageContext.request.contextPath }/member/updateMember"
		enctype="multipart/form-data" id="updateForm">
		<br>
		<h2>회원정보 수정</h2>
		<br>
		<div class="form-group">
			<label for="memberEmail" class="col-sm-2 control-label formCategory">이메일</label>
			<div class="col-sm-9">
				<input type="email" id="memberEmail" name="memberEmail"
					class="form-control" readonly="readonly" value="${rMemberVO.memberEmail}">
				<!-- <span class="help-block">Last Name, First Name, eg.: Smith, Harry</span> -->
			</div>
		</div>
		
		<div class="form-group">
			<label for="name" class="col-sm-2 control-label formCategory">이름</label>
			<div class="col-sm-9">
				<input type="text" id="name" name="name" value="${rMemberVO.name}"
					class="form-control">
			</div>
		</div>

		 <div class="form-group">
                    <label for="addrSerchBtn" class="col-sm-2 control-label formCategory">주소</label>
                    <div class="col-sm-9">
                       <!--  <input type="text" id="sample6_postcode" placeholder="우편번호"> -->
						<input type="button" name="addrSerchBtn" id="addrSerchBtn" onclick="sample6_execDaumPostcode()" value="주소 찾기"  class="col-sm-12 control-label btn btn-default" style="text-align:center;">
						<input type="text" id="sample6_address" name="primaryAddr" readonly="readonly"   value="${rMemberVO.primaryAddr}" class="form-control"><br>
						<input type="text" id="addrDetail" name="detailAddr" value="${rMemberVO.detailAddr}" class="form-control" required="required">
                    </div>
                </div>

		<div class="form-group">
			<label for="phone" class="col-sm-2 control-label formCategory">전화번호</label>
			<div class="col-sm-9">
				<input type="text" id="phone" name="phone" value="${rMemberVO.phone}"
					class="form-control">
			</div>
		</div>

		<div class="form-group">
			<label for="passwordHint" class="col-sm-2 control-label formCategory">비밀번호 힌트</label>
			<div class="col-sm-9">
				<input type="text" id="passwordHint" name="passwordHint"
					value="${rMemberVO.passwordHint}" class="form-control">
			</div>
		</div>

		<div class="form-group">
			<label for="passwordAnswer" class="col-sm-2 control-label formCategory">비밀번호 정답</label>
			<div class="col-sm-9">
				<input type="text" id="passwordAnswer" name="passwordAnswer"
					value="${rMemberVO.passwordAnswer}" class="form-control">
			</div>
		</div>

		<div class="form-group">
			<label for="birthDate" class="col-sm-2 control-label formCategory">프로필 사진</label>
			<div class="col-sm-5">
				<input type="file" id="picFile" name="picFile" class="form-control" value="${rMemberVO.picPath}">
			</div>
			<div class="col-sm-4" id="picDiv">
				<img id="picView" src="${pageContext.request.contextPath}/resources/upload/${rMemberVO.picPath}"
					width="100px">
			</div>
		</div>

		<div class="form-group">
			<div class="col-sm-9 col-sm-offset-2">
				<button type="button" id="submitBtn" class="btn btn-primary btn-block">수정</button>
			</div>
		</div>
	</form>
	<!-- /form -->
</div>
<!-- ./container -->
<div class="col - sm- 3"></div>
