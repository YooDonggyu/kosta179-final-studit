<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<style>

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
<div class="col-sm-12">
		<div id="calendar"></div>
		<div id="selectState" style="float: left; margin-top:50px; padding:50px; max-width: 500px">
			<span class="badge badge-primary" style="background-color: #379392;" onclick="getConditionListByState('예약완료')">예약완료</span>
			<span class="badge badge-primary" style="background-color: #f7d83d" onclick="getConditionListByState('예약대기')">예약대기</span>
			<span class="badge badge-primary" style="background-color: #8c8c8a" onclick="getConditionListByState('예약불가')">예약불가</span>
			<br>
			<br>
			<table class="table table-hover" style="max-width: 500px;">
				<thead id="head">
				</thead>
				<tbody id="todayList">
				</tbody>
			</table>
		</div>
	</div>
</div>

<script>
	var day = new Date();
	var today = day.toLocaleDateString();
	var studyRoomResource = ${studyRoomResource};
	var studyRoomCondition = ${studyRoomCondition};
	var businessHour = ${businessHour};
$(document).ready(function() {

		getConditionListByDate(today);
		
		
	    $('#calendar').fullCalendar({

	      schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',	
	      defaultView: 'month',
	      defaultDate: today,
	      allDaySlot: false,
	      editable: false,
	      selectable: true,
	      eventLimit: true, // allow "more" link when too many events
	      /* minTime: studyRoomResource[0].open,
	      maxTime: studyRoomResource[0].close, */
	      businessHours: {
	    	  // days of week. an array of zero-based day of week integers (0=Sunday)
	    	  dow: businessHour.dow, // Monday - Thursday

	    	  start:studyRoomResource[0].open, // a start time 
	    	  end: studyRoomResource[0].close, // an end time 
	    	},
	      header: {
	        left: 'prev,next today',
	        center: 'title',
	        right: 'month'
	      },

	      resources: studyRoomResource,
	      eventSources:[
	    	  {
	    		  googleCalendarApiKey: "AIzaSyB8sRKhOUgN1A2R-FLcxmWkQYAgVnguO4M",
	    		  googleCalendarId: "ko.south_korea#holiday@group.v.calendar.google.com"
	              , className : "koHolidays"
	              , color : "#ff7473"
	              , textColor : "#FFFFFF"
	              , selectable: false
	    	  },
	    	  {
	    		  events:studyRoomCondition,
	    		  color:"#f7d83d"
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
	              }
	              element.attr('data-toggle', 'modal');
	              element.attr('data-target', '#updateRoomConditionModal');
	              element.click(function() {
	                  $("#startTime").val(moment(event.start).format('HH:mm'));
	                  $("#endTime").val(moment(event.end).format('HH:mm'));
	                  $("#useDate").attr({'min': moment().format('YYYY-MM-DD')}).val(moment(event.start).format('YYYY-MM-DD'));
	                  $("#name").html('<b>예약자</b>'+event.title);
	                  $("#roomName").html('<b>스터디룸</b> '+event.resourceName);
	                  $("#state").val(event.state).prop("selected", true); 
	                  $("#studyRoomConditionNo").val(event.id); 
	              });
              
	    	  }
        	},
	      select: function(start, end, jsEvent, view, resource) {
	        console.log(
	          'select',
	          start.format(),
	          end.format(),
	          resource ? resource.id : '(no resource)'
	        );
	      },
	      dayClick: function(date, jsEvent, view, resource) {
	    	  
	    	  getConditionListByDate(date.format());
	    	 	    	
	    	  if(Object.keys(studyRoomResource).length<7){
	    		  $('#calendar').fullCalendar('changeView', 'agendaDay', date.format());
	    	  }else{
	    		  $('#calendar').fullCalendar('changeView', 'timelineDay', date.format()); 
	    	  }
	    	  
	        console.log(
	          'dayClick',
	          date.format(),
	          resource ? resource.id : '(no resource)'
	        );
	      },//dayClick
	      eventDragStop: function(event, jsEvent, ui, view) {
	    	  	alert('event.start: ' + event.start);
		  },
		  eventResize: function( event, delta, revertFunc, jsEvent, ui, view ) { 
			    alert(event.start);
		  },
		  eventClick: function( event, jsEvent, view ) { 
			  /* if (confirm('이 예약을 수정할까요?')) {
		            
		          } */
		  }
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
	var conditionData = "<tr>"+
		"<th style='text-align: center'>"+"예약자"+"</th>"
		+"<th style='text-align: center'>"+"스터디룸"+"</th>"
		+"<th style='text-align: center'>"+"시작"+"</th>"
		+"<th style='text-align: center'>"+"끝"+"</th>"
		+"<th style='text-align: center'>"+"상태"+"</th>"
		+"</tr>";

		$.each(studyRoomCondition, function(index, item) {
			if(date==item.start.split('T')[0]){
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
}//getConditionListByDate

//작성: 김유란
//기능: 예약 상태에 따른 현황 목록 보여주기
//로직: 우측 상단의 특정 상태 라벨을 클릭하면 상태값을 매개변수로 넘겨 전체 데이터 중에 상태가 일치하는 항목만 테이블에 출력한다.
function getConditionListByState(state){
	var conditionData = "<tr>"+
	"<th style='text-align: center'>"+"예약자"+"</th>"
	+"<th style='text-align: center'>"+"스터디룸"+"</th>"
	+"<th style='text-align: center'>"+"예약일"+"</th>"
	+"<th style='text-align: center'>"+"시작"+"</th>"
	+"<th style='text-align: center'>"+"끝"+"</th>"
	+"<th style='text-align: center'>"+"상태"+"</th>"
	+"</tr>";

		$.each(studyRoomCondition, function(index, item) {
			if(item.state==state){
			conditionData+="<tr>"
							+"<td>"+item.title+"</td>"
							+"<td>"+item.resourceName+"</td>"
							+"<td id='selectedDate'><a href='#'>"+item.start.split('T')[0]+"</a></td>"
							+"<td>"+item.start.split('T')[1]+"</td>"
							+"<td>"+item.end.split('T')[1]+"</td>"
							+"<td>"+item.state+"</td>"
							"</tr>";
			}//if
		})//each
		$("#todayList").html(conditionData);
}//getConditionListByState


</script>
<jsp:include page="update_studyRoom_condition.jsp" />