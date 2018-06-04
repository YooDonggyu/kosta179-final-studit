<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="all,follow">
  <title><%-- <tiles:insertAttribute name="title" ignore="true" /> --%>STUD-IT</title> 
  	<!-- favicon -->
  	<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/assets/img/favicon.ico">
    <!-- Meterial Icon-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons"  rel="stylesheet">
    <!-- Bootstrap-->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/bootstrap.min.css">
    <!-- Google fonts - Open Sans-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,300,700,800,400italic">
    <!-- Stroke 7 font by Pixeden (http://www.pixeden.com/icon-fonts/stroke-7-icon-font-set)-->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/pe-icon-7-stroke.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/helper.css">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/style.default.css" id="theme-stylesheet">
    <!-- owl carousel-->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/owl.carousel.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/owl.theme.css">
    <!-- plugins-->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/simpletextrotator.css">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/custom.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/blog.css">
  	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
  	<!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
   <script type="text/javascript" src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
    <!-- Javascript files-->
    <script src="${pageContext.request.contextPath }/resources/assets/js/bootstrap.min.js"> </script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/jquery.cookie.js"> </script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/ekko-lightbox.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/jquery.simple-text-rotator.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/jquery.scrollTo.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/front.js"></script>
 
 <style>
.memoForm{
	width: 500px;
}
.box-container {
	height: 300px;
}
#container4{
	height: 150px;
}
.box-item {
	width: 100%;
	z-index: 1000
}
.noresize {
  resize: none; /* 사용자 임의 변경 불가 */
}
.popover {max-width:400px;}

#popover-content-logout > * {
  background-color:#ff0000 !important;
}
</style>
</head>
<body style="background-color: #F6F6F6" style="padding: 30px">
    <div class="container-fluid">
      <div class="title" style="text-align: center">
    		<h2><b>${groupMemberVO.groupVO.name}</b> 일정 관리</h2>
    		Kanban으로 스터디 일정을 관리하세요!
    		<a href="#"  data-html="true"  id="info" data-toggle="popover" data-container="body" data-placement="right"><i class="fas fa-question-circle"></i></a>
    		<br><br>
      </div>
     
      <div class="row">
      	<div class="dragForms">
	        <div class="col-sm-4">
	          <div class="panel panel-secondary">
	            <div class="panel-heading">
	              <h1 class="panel-title" data-toggle="modal" data-target="#Modal-ToDo">To Do</h1>
	            </div>
	            <div id="container1" class="panel-body box-container">
	             	<c:forEach items="${memoList }" var="memo">
	             		<c:if test="${memo.position eq 'todo' }">
				              <div itemid="itm-${memo.sgMemoNo }" class="btn btn-${memo.color } box-item">${memo.content }</div>
	             		</c:if>
	             	</c:forEach>
	            </div>
	          </div>
	        </div>
	        
	        <div class="col-sm-4">
	          <div class="panel panel-secondary">
	            <div class="panel-heading">
	              <h1 class="panel-title" data-toggle="modal" data-target="#Modal-ToDo">Doing</h1>
	            </div>
	            <div id="container2" class="panel-body box-container">
	            	<c:forEach items="${memoList }" var="memo">
	             		<c:if test="${memo.position eq 'doing' }">
				              <div itemid="itm-${memo.sgMemoNo }" class="btn btn-${memo.color } box-item">${memo.content }</div>
	             		</c:if>
	             	</c:forEach>
	            </div>
	          </div>
	        </div>
	        
	         <div class="col-sm-4">
	          <div class="panel panel-secondary">
	            <div class="panel-heading">
	              <h1 class="panel-title" data-toggle="modal" data-target="#Modal-ToDo">Done</h1>
	            </div>
	            <div id="container3" class="panel-body box-container">
	            	<c:forEach items="${memoList }" var="memo">
	             		<c:if test="${memo.position eq 'done' }">
				              <div itemid="itm-${memo.sgMemoNo }" class="btn btn-${memo.color } box-item">${memo.content }</div>
	             		</c:if>
	             	</c:forEach>
	            </div>
	          </div>
	        </div>
	        
	         <div class="col-sm-12 text-right" style="text-align: center">
	         	<button type="button" id="container4" class="btn btn-transparent">Garbage Collector<br><br><i class="far fa-trash-alt fa-2x"></i></button>
	        </div>
	        
	        <!-- Modal ToDo-->
				<div class="modal fade" id="Modal-ToDo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content" style="border-radius: 5px; width: 600px;">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				        <h4 class="modal-title" id="myModalLabel">메모 등록하기</h4>
				      </div>
				      <form action="${pageContext.request.contextPath }/group/registerMemo" method="post">
					      <div class="modal-body text-center"><br>
					      		<p>내용을 입력해주세요.(최대 30자)</p>
					      		<input type="text" name="content" class="memoForm" maxlength="30" required="required"><br><br><br>
					      		<p>메모의 색상을 정해주세요</p>
					      		<label><input type='radio' name='color' value='default' checked='checked'/> <span class="label label-default">&emsp;</span></label>&emsp;
								<label><input type='radio' name='color' value='primary' /> <span class="label label-primary">&emsp;</span></label>&emsp;
								<label><input type='radio' name='color' value='success' /> <span class="label label-success">&emsp;</span></label>&emsp;
								<label><input type='radio' name='color' value='info' /> <span class="label label-info">&emsp;</span></label>&emsp;
								<label><input type='radio' name='color' value='warning' /> <span class="label label-warning">&emsp;</span></label>&emsp;
								<label><input type='radio' name='color' value='danger' /> <span class="label label-danger">&emsp;</span></label>
								<input type="hidden" name="position" value="todo">
								<input type="hidden" id="sgNo" name="sgNo" value="${groupMemberVO.groupVO.groupNo}">
					      </div>
					      <div class="modal-footer">
					        <button type="submit" class="btn btn-primary">확인</button>
					      </div>
				      </form>
				    </div>
				  </div>
				</div>
				
        </div>
      </div>
    </div>
     <div id="popover-content-info">
      <ul>
      	<li>각 영역의 상단을 클릭하면 새 일정을 등록할 수 있습니다. </li>
      	<li>drag&drop으로 일정 진행상태를 변경하세요.</li>
      	<li>불필요한 일정은 garbage collector에 맡겨주세요!</li>
      </ul>
      </div>
</body>
<script>
$(document).ready(function() {
	
	//안내문구 영역 감추기
	$("#popover-content-info").hide();
	  
	  //register memo
	  $('div .panel-heading').on('click',function(){
		  console.log('panel_heading click: '+$(this).children('h1').text());
	  });
	  
	  
	  //drag&drop function0
	  $('.box-item').draggable({
	    cursor: 'move',
	    helper: "clone"
	  });
	  //drag&drop function1
	  $("#container1").droppable({
	    drop: function(event, ui) {
	      var itemid = $(event.originalEvent.toElement).attr("itemid");
	      $('.box-item').each(function() {
	        if ($(this).attr("itemid") === itemid) {
	          $(this).appendTo("#container1");
	          console.log('todo: '+$(this).text());
	          location.href='${pageContext.request.contextPath}/group/updateStudyGroupMemoPosition?memoNo='+itemid.replace('itm-','')+'&position=todo&studyGroupNo='+$('#sgNo').val();
	        }
	      });
	    }
	  });//droppable1
	  
	  //drag&drop function2
	  $("#container2").droppable({
	    drop: function(event, ui) {
	      var itemid = $(event.originalEvent.toElement).attr("itemid");
	      $('.box-item').each(function() {
	        if ($(this).attr("itemid") === itemid) {
	          $(this).appendTo("#container2");
	          console.log('doing: '+$(this).text());
	          console.log('반복체크: '+$(this).text());
	          location.href='${pageContext.request.contextPath}/group/updateStudyGroupMemoPosition?memoNo='+itemid.replace('itm-','')+'&position=doing&studyGroupNo='+$('#sgNo').val();
	        }
	      });
	    }
	  });//droppable2
	  
	  //drag&drop function3
	  $("#container3").droppable({
		    drop: function(event, ui) {
		      var itemid = $(event.originalEvent.toElement).attr("itemid");
		      $('.box-item').each(function() {
		        if ($(this).attr("itemid") === itemid) {
		          $(this).appendTo("#container3");
		          console.log('done: '+$(this).text());
		          location.href='${pageContext.request.contextPath}/group/updateStudyGroupMemoPosition?memoNo='+itemid.replace('itm-','')+'&position=done&studyGroupNo='+$('#sgNo').val();
		        }
		      });
		    }
		  });//droppable3
		  
		//drag&drop function4
		  $("#container4").droppable({
			    drop: function(event, ui) {
			      var itemid = $(event.originalEvent.toElement).attr("itemid");
			      $('.box-item').each(function() {
			        if ($(this).attr("itemid") === itemid) {
			          $(this).appendTo("#container4");
			          console.log('done: '+$(this).text());
			          location.href='${pageContext.request.contextPath}/group/deleteStudyGroupMemo?memoNo='+itemid.replace('itm-','')+'&studyGroupNo='+$('#sgNo').val();
			        }
			      });
			    }
			  });//droppable4
	  
		  //popover 설정(물음표 아이콘) 
		  $("[data-toggle=popover]").each(function(i, obj) {
			  $(this).popover({
				    html: true,
				    content: function() {
				      var id = $(this).attr('id')
				      return $('#popover-content-' + id).html();
				    }
			 	 });//popover
			  });//each	  
	});//ready
</script>
</html>