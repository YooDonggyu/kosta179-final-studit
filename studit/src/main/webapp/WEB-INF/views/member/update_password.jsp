<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.form-group{
	padding: 20px;
}
</style>
<section>
	<h2>비밀번호 변경</h2>
		<div class="col-sm-offset-4 col-sm-6">
                <form id="updatePasswordForm" method="post" action="${pageContext.request.contextPath}/member/updatePassword">
	            
	                <div class="form-group">
	                   
	                    <div class="col-sm-8">
	                        <input type="password" id="nowPassword" name="nowPassword" class="form-control" required="required" placeholder="현재 비밀번호">
	                    </div>
	                </div>
	            
	                 <div class="form-group">
	                    
	                    <div class="col-sm-8">
	                        <input type="password" id="newPassword" name="newPassword" class="form-control" required="required" placeholder="새 비밀번호">
	                    </div>
	                </div>
	            
	                 <div class="form-group">
	                    
	                    <div class="col-sm-8">
	                        <input type="password" id="repeatPassword" name="repeatPassword" class="form-control" required="required" placeholder="비밀번호 확인">
	                    </div>
	                    <input type="hidden" id="checkEmail" name="checkEmail" value="${memberVO.memberEmail}">
	                </div>
	
  			</form>
  			<div class="form-group">
               <div class="col-sm-8">
                     <button  id="updateBtn" class="btn btn-primary btn-block" onclick="updatePassword()">변경</button>
                </div>
    	  </div>
        
        <br><br><br>
       </div>
</section>
<script type="text/javascript">
	//작성: 김유란
	//기능: 비밀번호 변경 전 입력 내용 점검
	//로직: 변경 버튼을 누르면
	//			1. 현재 비밀번호를 ajax 통해 DB 정보와 비교하여 일치하면 true, 불일치하면 false 반환하여 false면 alert
	//			2. 새 비밀번호와 비밀번호 확인이 불일치하면 alert
	//			3. 1,2 조건이 모두 충족되어야 form 제출 
	function updatePassword(){
				$.ajax({
					type:"post",
					url:"${pageContext.request.contextPath}/ajax/checkPassword",
					dataType:"json",
					data:"memberEmail="+$("#checkEmail").val()+"&nowPassword="+$("#nowPassword").val(),
					success:function(data){
						 if(!data){
							alert("현재 비밀번호를 확인하세요.");
						}else{ 
							if($("#newPassword").val()!=$("#repeatPassword").val()){
								alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
							}else if($("#newPassword").val()==""){
								alert("새 비밀번호를 입력하세요.");
							}else if($("#nowPassword").val().length<8){
								alert("비밀번호는 8자 이상 입력하세요.");
							}else if($("#nowPassword").val()==$("#newPassword").val()){
								alert("현재 비밀번호와 새 비밀번호가 같습니다.");
							}else{
								$("#updatePasswordForm").submit();
							}
						 }//else 
					}//success
				})//ajax
}//updatePassword
</script>