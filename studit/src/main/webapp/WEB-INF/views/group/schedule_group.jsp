<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
<section>
    <div class="container-fluid">
      <div class="title">
    		<h2>${groupMemberVO.groupVO.name} 일정 관리</h2>
    		<p>Kanban을 이용하여 스터디 일정이 관리하세요!</p><br><br>
      </div>
      <div class="row">
      	<div class="dragForms">
	        <div class="col-sm-3 col-sm-offset-2">
	          <div class="panel panel-primary">
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
	        
	        <div class="col-sm-3">
	          <div class="panel panel-primary">
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
	        
	         <div class="col-sm-3">
	          <div class="panel panel-primary">
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
	        
	         <div class="col-sm-12 text-right">
	         	<input type="button" id="container4" class="btn btn-warning" value="Garbage Collector">
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
					      		<input type="text" name="content" class="memoForm" maxlength="30"><br><br><br>
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
    </section>
  </body>
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
</style>
<script type="text/javascript" src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script>
$(document).ready(function() {
	  
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
	  
	});//ready
</script>