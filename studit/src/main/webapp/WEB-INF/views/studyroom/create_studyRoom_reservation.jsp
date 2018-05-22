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
    max-width: 600px;
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
		<div id="timeTable" style="float: left; margin-top:50px; padding:50px; max-width: 500px">
			
		</div>
	</div>
</div>

<script>

$(document).ready(function() {

	    $('#calendar').fullCalendar({

	      schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',	
	      defaultView: 'month',
	      defaultDate: moment(),
	      allDaySlot: false,
	      editable: false,
	      selectable: true,
	      eventLimit: true,
	      dayRender: function (date, cell) {
              if(date<moment()){
            	  cell.addClass("fc-nonbusiness");
                  cell.addClass("fc-bgevent");
              }
         },
	      businessHours: {
	    	  dow: ${businessDay.dow}, 
	    	},
	      header: {
	        left: 'prev,next today',
	        center: 'title',
	        right: 'month'
	      },
        	selectConstraint: "businessHours", //영업일이 아니면 클릭할 수 없도록 제약
            select: function(start, end, jsEvent, view) {
              if (start.isAfter(moment())) {//오늘보다 과거의 시간은 클릭 가능한 대신 조건문으로 제약
                	alert(start.format('YYYY-MM-DD'));
                	getTimeTable(start);
              } else {
                alert('이미 지나간 날들...');
              }
            }
	    }); //fullCalendar
})//ready

function getTimeTable(selectedDate){
	$.ajax({
		type:"post",
		url:"${pageContext.request.contextPath}/ajax/getSmallCategoryList",
		dataType:"json",
		data:"studyRoomNo="+${studyRoomVO.studyRoomNo}+"&selectedDate="+selectedDate,
		success:function(data){
			//$("#timeTable")  시간표 보여주기
		}//success
	})//ajax
};
</script>	    