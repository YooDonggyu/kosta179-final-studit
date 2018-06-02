<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
<style>
th{
	text-align: center;
}
  .calendarView {
    margin: 0;
    padding: 0;
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 800px;
    height: auto;
    float: left;
    padding: 50px;
  }
  
 .fc-day-top.fc-sun.fc-past, .fc-day-top.fc-sun.fc-today, 
 .fc-day-top.fc-sun.fc-future, .fc-day-header.fc-widget-header.fc-sun { color:#FF0000; }    /* 일요일 */

</style>

<div class="calendarView">
<div class="col-sm-12 col-sm-offset-1">
		<div id="calendar"></div>
		<div id="selectState" style="float: left; margin-top:50px; padding:50px; max-width:500px">
			<h2 id="companyName"></h2>
<ul class="nav nav-pills">
  <li class="active" style="width: 50%; color='white'';"><a data-toggle="pill" href="#home">오늘의 예약</a></li>
  <li style="width: 49%"><a data-toggle="pill" href="#menu1">승인 대기중인 예약</a></li>
</ul>
<div class="tab-content">
  <div id="home" class="tab-pane fade in active">
  <div class="panel panel-default">
  <div class="panel-body">
   <i class="fas fa-info-circle"></i>
  <p>달력에서 날짜를 선택하면 <br> 그 날의 예약내역이 나타납니다.<br>
    </p>
  	<b id="clickedDate"></b>
  	<p id="countView"></p>
  	
  	<table class="table" id="todayList">
			</table> 
  </div>
</div>
  </div>
  <div id="menu1" class="tab-pane fade">			
  <div class="panel panel-default">
  <div class="panel-body">
   <i class="fas fa-info-circle"></i>
    <p>해당 이벤트를 클릭하면 <br>예약을 승인할 수 있습니다.</p>
  	  <table class="table" id="waitList">
  	  	<tr><th>일자</th><th>대기건수</th></tr>
  	  <c:forEach items="${waitCountList}" var="day">
  	  <tr>
  	  	<td id='selectedDate'><a href='#'>${day.M}</a></td>
  	  	<td>${day.COUNT}</td>
  	  </tr>
  	  </c:forEach>
			</table> 
  </div>
  </div>
  </div>
</div>  		
			<span class="badge badge-primary" style="background-color: #379392; font-size: 15px">예약완료</span>
			<span class="badge badge-primary" style="background-color: #f7d83d; font-size: 15px">예약대기</span>
			<span class="badge badge-primary" style="background-color: #8c8c8a; font-size: 15px">예약불가</span>
			<span class="badge badge-primary" style="background-color: #000000; font-size: 15px">예약취소</span>
		</div>
	</div>
</div>

<script>
	var today = moment().format("YYYY-MM-DD");
	var studyRoomResource = ${studyRoomResource};
	var businessHour = ${businessHour};
	var studyRoomCondition;
	
	

$(document).ready(function() {
	
	$("#companyName").text(studyRoomResource[0].companyName);
	
	    $('#calendar').fullCalendar({
    	
	      schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',	
	      defaultView: 'month',
	      defaultDate: today,
	      allDaySlot: false,
	      editable: false,
	      selectable: true,
	      displayEventTime : false,
	      eventLimit: true, // allow "more" link when too many events
	      /* minTime: studyRoomResource[0].open,
	      maxTime: studyRoomResource[0].close, */
	      businessHours: {
	    	  // days of week. an array of zero-based day of week integers (0=Sunday)
	    	  dow: businessHour.dow, // Monday - Thursday

	    	  start:studyRoomResource[0].open+":00", // a start time 
	    	  end: studyRoomResource[0].close+":00", // an end time 
	    	},
	    	 dayRender: function (date, cell) {
	              if(date<moment()){
	            	  cell.addClass("fc-nonbusiness");
	                  cell.addClass("fc-bgevent");
	              }
	         },
	      header: {
	        left: 'prev,next today',
	        center: 'title',
	        right: 'month'
	      },
	      resources: studyRoomResource,
	      eventSources:[
	    	  {
	      events: function(start, end, timezone, callback){
	    	  var startDate = moment(start).format("YYYY-MM-DD");
	    	  var endDate = moment(end).format("YYYY-MM-DD");
	    		 $.ajax({
	    				type:"post",
	    				url:"${pageContext.request.contextPath}/ajax/findStudyRoomConditionByStudyRoomNoAndMonth",
	    				dataType:"json",
	    				async:false,
	    				data:"companyNo="+studyRoomResource[0].companyNo+"&startDate="+startDate+"&endDate="+endDate,
	    				success:function(data){
	    				 		studyRoomCondition = data.sort(function(a, b) {
	    					    return a.start -b.start;
	    					}) 
	    						 callback(data)		
	    						 getConditionListByDate(today);
	    				}//success	
	    			})//ajax
	      }
	    	  },
	    	 {
	    		  events: function(start, end, timezone, callback){
	    			  var date = $("#calendar").fullCalendar('getDate');
	    			  var year = moment(date).format("YYYY");
	    	    	  var month = moment(date).format("MM");
	    	    		 $.ajax({
	    	    			 type:"get",
	    	    				url:"${pageContext.request.contextPath}/ajax/findHolidayInfoByDate",
	    	    				dataType:"json",
	    	    				async:false,
	    	    				data:"year="+year+"&month="+month,
	    	    				success:function(data){
	    	    					 callback(data);			
	    	    						
	    	    				}//success	
	    	    			})//ajax
	    	      }, 
	    	      color: 'transparent',
	    	      textColor: 'red',
	   	    	 }
	      ],
	      eventRender: function (event, element, view) {
	    	  if(event.state!=null){
	              if (event.state=='예약완료') {
	                        element.css("border-color", "#379392");
	                        element.css("background-color", "#379392");
	              }else if(event.state=='예약불가'){
	            	  		element.css("border-color", "#8c8c8a");
	                 	    element.css("background-color", "#8c8c8a");
	              }else if(event.state=='예약대기'){
	            	 		 element.css("border-color", "#f7d83d");
               	   			 element.css("background-color", "#f7d83d");
	              }else if(event.state=='예약취소'){
	            	  		element.css("border-color", "#000000");
               	    		element.css("background-color", "#000000");
	              }
	              element.attr('data-toggle', 'modal');
	              element.attr('data-target', '#updateRoomConditionModal');
	              element.click(function() {
	                  $("#startTime").text(moment(event.start).format('HH'));
	                  $("#endTime").text(moment(event.end).format('HH'));
	                  $("#useDate").text(moment(event.start).format('YYYY-MM-DD'));
	                  $("#name").html('<b>예약자</b>'+event.title);
	                  $("#roomName").html('<b>스터디룸</b> '+event.resourceName);
	                  $("#state").val(event.state).prop("selected", true); 
	                  $("#studyRoomConditionNo").val(event.id); 
	              });
              
	    	  }
        	},
	      select: function(start, end, jsEvent, view, resource) {
	      },
	      dayClick: function(date, jsEvent, view, resource) {
	    	  getConditionListByDate(moment(date).format("YYYY-MM-DD"));
	    	  if(Object.keys(studyRoomResource).length<7){
	    		  $('#calendar').fullCalendar('changeView', 'agendaDay', date.format());
	    	  }else{
	    		  $('#calendar').fullCalendar('changeView', 'timelineDay', date.format()); 
	    	  }
	      }//dayClick
	    });//fullCalendar


	 $(document).on("click", "#selectedDate", function() {
		  if(Object.keys(studyRoomResource).length<7){
    		  $('#calendar').fullCalendar('changeView', 'agendaDay',$(this).text());
    	  }else{
    		  $('#calendar').fullCalendar('changeView', 'timelineDay',$(this).text());
    	  }
	});	   

})//ready

//작성: 김유란
//기능: 날짜에 따른 현황 목록 보여주기
//로직: 캘린더의 특정일 cell을 클릭하면 날짜값을 매개변수로 넘겨 전체 데이터 중에 날짜가 일치하는 항목만 테이블에 출력한다.
 function getConditionListByDate(date){
	var count = 0;
	$("#clickedDate").html(date);
	var conditionData = "<tr>"+
		"<th>"+"예약자"+"</th>"
		+"<th>"+"스터디룸"+"</th>"
		+"<th>"+"시작"+"</th>"
		+"<th>"+"종료"+"</th>"
		+"<th>"+"상태"+"</th>"
		+"</tr>";
		
	/* 	studyRoomCondition.sort(function(a, b) {
		    return parsInt(a.start) - parseInt(b.start);
		}) */
		
		$.each(studyRoomCondition, function(index, item) {
			if(date==item.start.split('T')[0]){
				count++;
			conditionData+="<tr>"
							+"<td>"+item.title+"</td>"
							+"<td>"+item.resourceName+"</td>"
							+"<td>"+item.start.split('T')[1]+"</td>"
							+"<td>"+item.end.split('T')[1]+"</td>"
							+"<td>"+item.state+"</td>"
							"</tr>";
			}//if
		})//each
		$("#todayList").html(conditionData);
		$("#countView").html("총 "+ count+"건의 예약")
}//getConditionListByDate */

</script>
<jsp:include page="update_studyRoom_condition.jsp" />