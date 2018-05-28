<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	$(document).ready(function(){
		$("#ok").click(function(){
			if($("#memberEmail").val()==null||$("#memberEmail").val()==""){
				alert("이메일을 입력하세요.");
				$("#memberEmail").focus();
			}else{
				location.href="${pageContext.request.contextPath}/member/checkPasswordHintAndAnswer?memberEmail="+$("#memberEmail").val();
			}
		});
	});
</script>

<section class="signup-section text-center no-padding-bottom">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h3>비밀번호 찾기</h3>
				<p class="lead text-gray-light">회원 이메일을 입력하세요.</p>
			</div>   
		</div> 
	</div>
</section>


<section id="features" class="section">
	<div class="container">
	<table class="table table-hover">
		<tbody>
			<tr>
				<td>Email : </td>
				<td><input type="text" name="memberEmail" required="required" id="memberEmail" autofocus="autofocus"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" value="확인" id="ok"></td>
			</tr>
		</tbody>
	</table>
	</div>
</section>