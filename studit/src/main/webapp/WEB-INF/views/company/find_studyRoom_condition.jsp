<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
			<h2 id="companyName"></h2>
			<table>
				<thead>
					<tr>
						<th></th>
						<th><span class="badge badge-primary" style="background-color: #379392; font-size: 15px">예약완료</span></th>
						<th><span class="badge badge-primary" style="background-color: #f7d83d; font-size: 15px">예약대기</span></th>
						<th><span class="badge badge-primary" style="background-color: #8c8c8a; font-size: 15px">예약불가</span></th>
						<th><span class="badge badge-primary" style="background-color: #000000; font-size: 15px">예약취소</span></th>
					</tr>
					</thead>
				<tbody>
				</tbody>
			</table>
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
	      eventLimit: true, // allow "more" link when too many events
	      /* minTime: studyRoomResource[0].open,
	      maxTime: studyRoomResource[0].close, */
	      businessHours: {
	    	  // days of week. an array of zero-based day of week integers (0=Sunday)
	    	  dow: businessHour.dow, // Monday - Thursday

	    	  start:studyRoomResource[0].open+":00", // a start time 
	    	  end: studyRoomResource[0].close+":00", // an end time 
	    	},
	      header: {
	        left: 'prev,next today',
	        center: 'title',
	        right: 'month'
	      },
	      resources: studyRoomResource,
	      events: function(start, end, timezone, callback){
	    	  var startDate = moment(start).format("YYYY-MM-DD");
	    	  var endDate = moment(end).format("YYYY-MM-DD");
	    		 $.ajax({
	    				type:"post",
	    				url:"${pageContext.request.contextPath}/ajax/findStudyRoomConditionByStudyRoomNoAndMonth",
	    				dataType:"json",
	    				data:"companyNo="+studyRoomResource[0].companyNo+"&startDate="+startDate+"&endDate="+endDate,
	    				success:function(data){
	    					studyRoomCondition = data;
	    						callback(data)		
	    				}//success	
	    			})//ajax
	      },
	      eventRender: function (event, element, view) {
	    	  if(event.state!=null){
	              if (event.state=='예약완료') {
	                        element.css("border-color", "#379392");
	                        element.css("background-color", "#379392");
	              }else if(event.state=='예약불가'){
	            	  		element.css("border-color", "#8c8c8a");
	                 	    element.css("background-color", "#8c8c8a");
	              }else{
	            	 		 element.css("border-color", "#f7d83d");
               	   			 element.css("background-color", "#f7d83d");
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
	      },
	      dayClick: function(date, jsEvent, view, resource) {
	    	 	    	
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


/* //작성: 김유란
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
}//getConditionListByDate */


</script>
<jsp:include page="update_studyRoom_condition.jsp" />