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
		<div id="time" style="float: left; margin-top:50px; padding:50px; max-width: 500px">
		<h1>${studyRoomVO.companyVO.name} </h1><h3> ${studyRoomVO.name}</h3>
		<h5>수용인원: ${studyRoomVO.capacity}</h5>
		<h5 id="selectedDate"></h5>
		<span id="totalPrice"></span>
		<span id="start"></span>
		<span id="end"></span>
		<br>
			<table id="timeTable" class="table table-hover">
			</table>
		</div>
	</div>
</div>
<script>

var open = "${studyRoomVO.companyVO.open}"
var close="${studyRoomVO.companyVO.close}"
var openTime=parseInt(open.split(':')[0], 10);
var closeTime=parseInt(close.split(':')[0], 10);

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
              if (start || start.isAfter(moment())) {//오늘보다 과거의 시간은 클릭 가능한 대신 조건문으로 제약
                	getTimeTable(start.format('YYYY-MM-DD'));
              } else {
                alert('이미 지나간 날들...');
              }
            }
	    }); //fullCalendar
	    
	    $(document).on("click", "#timeTable td", function(e) {
	    	var newNum = $("#timeTable td").index($(e.target))+openTime;
	    	
	    	if($("#start").text()==""&&$("#end").text()==""){
	    		$("#start").html(newNum);
		    	$("#end").html(newNum);
	    	}else{
	    		var startNum = parseInt($("#start").text(), 10);
	    		var endNum = parseInt($("#end").text(), 10);
	    		if(startNum<newNum && endNum!=newNum){
	    			(alert("@@1111"))
	    			$("#end").html(newNum);
	    		}else if(startNum>newNum){
	    			(alert("@@222"))
	    			$("#start").html(newNum);
	    		}else if(startNum==newNum){
	    			(alert("@@333"))
	    			$("#startNum").html(endNum);
	    		}else if(endNum==newNum){
	    			(alert("@@444"))
	    			$("#endNum").html(startNum);
	    		}
	    	}
	    })//on
})//ready

function getTimeTable(selectedDate){
	$("#selectedDate").html(selectedDate)
	$.ajax({
		type:"post",
		url:"${pageContext.request.contextPath}/ajax/findStudyRoomConditionByStudyRoomNoAndDate",
		dataType:"json",
		data:"studyRoomNo="+${studyRoomVO.studyRoomNo}+"&selectedDate="+selectedDate,
		success:function(data){
			var timeTable='';
			for(var i=openTime; i<=closeTime; i++){
				timeTable+="<td>"+i+"</td>"
			}//for(timeTable)
			$("#timeTable").html("<tr>"+timeTable+"</tr>");
			var tdLength = $("#timeTable td").length;
				$.each(data, function(index, item){
				for(var j=item.startTime; j<=item.endTime; j++){
				 	for(var i=0; i<tdLength; i++){
						if($("#timeTable td:eq("+i+")").text()==j){
							$("#timeTable td:eq("+i+")").css("background-color", 'gray')
						}//if 
					}//for(table loof) 
				}//for 
				}) //each 
		}//success 
	})//ajax
};
</script>	    