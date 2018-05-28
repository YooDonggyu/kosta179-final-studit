<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="signup-section text-center no-padding-bottom">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h3>임시 비밀번호 발급</h3>
				<p class="lead text-gray-light">이메일 : ${memberInfo.memberEmail }</p>
			</div>   
		</div> 
	</div>
</section>


<section id="features" class="section">
	<div class="container">
	<table class="table table-hover">
		<tbody>
			<tr>
				<td>임시 비밀번호 : </td>
				<td><input type="text" value="${memberInfo.newPassword }"></td>
			</tr>
			<tr>
				<td colspan="2"><a data-toggle="modal" href="#loginModal"><input type="button" value="로그인"></a></td>
			</tr>
		</tbody>
	</table>
	</div>
</section>