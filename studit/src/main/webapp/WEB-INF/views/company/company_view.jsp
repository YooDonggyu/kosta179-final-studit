<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.companyBtn{
		border-radius: 8px;
	    background-color: #ff7473;
    	border: none;
    	color: white;
    	padding: 20px;
    	text-align: center;
    	text-decoration: none;
    	display: inline-block;
    	font-size: 16px;
    	font-weight: bold;
    	margin: 4px 2px;
    	cursor: pointer;
    	width: 180px;
    	height: 150px;
	}
</style>
 <section>
<h3>Host Page</h3><br><br>
<a href="${pageContext.request.contextPath }/company/registerCompanyView"><input type="button" value="업체 등록 하기" class="companyBtn" ></a>&emsp;&emsp;&emsp;
<%-- <a href="${pageContext.request.contextPath }/studyroom/createStudyRoomConditionView"><input type="button" value="내 업체 관리" class="companyBtn" ></a> --%>
<!-- <input type="button" value="내 업체 관리" class="companyBtn" > -->
<a href="#"><input type="button" value="내 업체 관리" class="companyBtn" ></a>&emsp;&emsp;&emsp;
</section>


