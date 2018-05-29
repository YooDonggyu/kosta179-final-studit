<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<input type="hidden" value="${checkInfo.passwordAnswer }" id="passwordAnswer">
<input type="hidden" value="${checkInfo.memberEmail }" id="email">
<section class="signup-section text-center no-padding-bottom">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h3>비밀번호 찾기</h3>
				<p class="lead text-gray-light">비밀번호 힌트&답변</p>
			</div>   
		</div> 
	</div>
</section>


<section id="features" class="section">
	<div class="container">
	<table class="table table-hover">
		<tbody>
			<tr>
				<td>Password Hint : </td>
				<td><input type="text" value="${checkInfo.passwordHint }" readonly="readonly"></td>
			</tr>
			<tr>
				<td>Password Answer : </td>
				<td><input type="text" id="answer" required="required" autofocus="autofocus"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" value="비밀번호찾기" id="findPasswordBtn"></td>
			</tr>
		</tbody>
	</table>
	</div>
</section>


<script type="text/javascript">
	$(document).ready(function(){
		var cnt=0;
		var answer=$("#passwordAnswer").val();
		$("#findPasswordBtn").click(function(){
			cnt+=1;
			if($("#answer").val()!=answer){
				if(cnt<3){
					alert("답변이 틀렸습니다.");
					$("#answer").focus();
				}else{
					alert("3회 틀리셨습니다. 홈으로 이동합니다.");
					location.href="${pageContext.request.contextPath}/";
				}
			}else{
				location.href="${pageContext.request.contextPath}/member/findPassword?memberEmail="+$("#email").val();
			}
		});
	});
</script>

