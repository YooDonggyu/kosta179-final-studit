
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
 .fc-day-top.fc-sun.fc-future, .fc-day-header.fc-widget-header.fc-sun { color:#FF0000; }    /* 일요일은 붉은색으로 표시 */

.selected{ /* 선택된 시간 버튼 */
 background-color: #ff4b4a;
}
</style>

<div class="calendarView">
<div class="col-sm-12">
      <div id="calendar"></div><!-- 캘린더 -->
      <div id="time" style="float: center; margin-top:50px; padding:50px;">
      <!-- 예약정보를 보여주는 구역 -->
         <h1>${studyRoomVO.companyVO.name} </h1><h3> ${studyRoomVO.name}</h3>
         <input type="hidden" id="hiddenComName" value="${studyRoomVO.companyVO.name} ">
         <input type="hidden" id="hiddenStudyRoomName" value="${studyRoomVO.name}">
         <input type="hidden" id="hiddenBuyerName" value="${memberVO.name}">
         <input type="hidden" id="hiddenBuyerEmail" value="${memberVO.memberEmail}">
                  <h5>수용인원: ${studyRoomVO.capacity}</h5>
         <h5 id="selectedDate"></h5>
         총<span id="totalPrice"> 0</span>원
         <br>
         <div class="form-group">
                  <label for="" class="control-label formCategory"></label><br>
                       <div id="times" class="btn-group" role="group" aria-label="..."></div>
            </div>
            <form method="post" id="reserveForm" action="${pageContext.request.contextPath}/studyroom/createStudyRoomCondition">
               <input type="hidden" id="startTime" name="startTime">
               <input type="hidden" id="endTime" name="endTime">
               <input type="hidden" id="useDate" name="useDate">
               <input type="hidden" name="studyRoomVO.studyRoomNo" value="${studyRoomVO.studyRoomNo}">
               <input type="hidden" name="memberVO.memberEmail" value="${memberVO.memberEmail}">
                 <!-- <input type="button" class="btn btn-info" value="예약 신청하기" id="okBtn"> -->
                 <input type="button" class="btn btn-info" value="예약 신청하기" onclick="requestPay()"><%-- id="okBtn"  --%>
            </form>
      </div><!-- <div id="time"> -->
   </div><!-- <div class="col-sm-12"> -->
</div><!--<div class="calendarView">  -->




<script>

//결제에 사용할 변수들
var IMP = window.IMP; 
IMP.init("imp13613726"); 
var comName = $("#hiddenComName").val();
var studyRoomName = $("#hiddenStudyRoomName").val();
var buyerEmail = $("#hiddenBuyerEmail").val();
var buyerName = $("#hiddenBuyerName").val();


//영업시간 정보를 변수에 담아둠
var open = "${studyRoomVO.companyVO.open}" 
var close="${studyRoomVO.companyVO.close}"
//ajax로 전송받은 선택 날짜의 예약정보 data를 저장해 둘 변수(ajax  success 외부에서 사용할 목적) 
var result;

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
              if (start.isAfter(moment())) {//영업일이지만 오늘보다 과거인 날은 클릭 가능한 대신 조건문으로 제약
                   getTimeTable(start.format('YYYY-MM-DD'));//날짜 바뀔 때마다 시간선택표 새로 불러오기
              } else {
                alert('이미 지나간 날들...');
              }
            }
       }); //fullCalendar

     //작성: 김유란
     //기능: 사용자가 선택한 시간만큼 가격을 산정하여 보여주는 함수
     //로직: 스터디룸 가격 정보를 가져와 시간이 선택되면 값을 더하고, 선택이 해제되면 값을 뺀다.
     var price = parseInt(${studyRoomVO.price}, 10); //스터디룸 가격 정보를 숫자 타입으로 변환
     $(document).on("click","#times" ,function(e) {
        var index = $("#times").children($("#time")).index($(e.target));
        $("#times").children("#time").eq(index).toggleClass('selected');
       
           if($("#totalPrice").text()=="0"){
              $("#totalPrice").text(price);
           }else{
              if( $("#times").children("#time").eq(index).hasClass('selected')){
                 $("#totalPrice").text(parseInt($("#totalPrice").text(),10)+price)
              }else{
               $("#totalPrice").text(parseInt($("#totalPrice").text(),10)-price)
            }
           }
       })//on(가격정보)
})//ready


//작성: 김유란
//기능: 사용자가 선택한 예약시간(start, end) 사이에 기존 예약시간이 포함되지 않는지 검증
//로직: 선택된 날짜의 기존 예약시간과 사용자가 선택한 예약시간이 하나라도 일치하면 false, 일치하지 않으면 true를 리턴
function checkAvailable(start, end){
   var flag = true;
   $.each(result, function(index, item){
          for(var i=start; i<=end; i++){
             for(var j=item.startTime; j<=item.endTime; j++){
                if(i==j){
                   flag=false;
                   break;
                }//if
             }//for(each문에서 하나씩 꺼낸 예약현황 정보(item)의 시작시간부터 끝시간까지 loop)
          }//for(사용자가 선택한 예약 시작시간부터 끝시간까지 loop)          
   })//each (선택된 날짜의 기존 예약현황 정보(result의 item)를 하나씩 꺼내어 loop)
   return flag;
}//checkAvailable 


//작성: 김유란
//기능: 사용자가 선택한 날짜의 시간선택표를 뷰에 보여주는 함수
//로직: 영업시간을 제외한 시간선택표를 생성한 후,
//       사용자가 선택한 날짜에 해당하는 예약현황 정보를 ajax로 받아와 
//         예약되어 있는 시간은 클릭할 수 없게+회색 처리
function getTimeTable(selectedDate){
   //날짜 바뀔 때마다 뷰에 보이는 예약 정보를 변경하기
   $("#selectedDate").html(selectedDate)//선택된 날짜를 뷰에 보여줌
   $("#totalPrice").html("0");//가격 정보 리셋
   $.ajax({
      type:"post",
      url:"${pageContext.request.contextPath}/ajax/findStudyRoomConditionByStudyRoomNoAndDate",
      dataType:"json",
      data:"studyRoomNo="+${studyRoomVO.studyRoomNo}+"&selectedDate="+selectedDate,
      success:function(data){
         result=data;//ajax로 받아온 정보를 외부에서도 사용할 수 있게 변수에 저장
         //시간선택표 생성작업
         var timeTable='';
         for(var i=open; i<=close; i++){
            timeTable+=  "<input type='button' id='time' class='btn btn-default' value='"+i+"'>"
         }//for(timeTable)
         $("#times").html(timeTable);
         
         //기존 예약정보 표시 및 클릭 제어
         var $times =  $("#times").children("#time");
         var length = $times.length;
            $.each(data, function(index, item){
            for(var j=item.startTime; j<=item.endTime; j++){
                for(var i=0; i<length; i++){
                   //당일 예약일 경우 현재 시간 이후만 가능하도록 제한---테스트 후 추가
                   // || moment().format("YYYY-MM-DD")==selectedDate&&moment().hour()>=$times.eq(i).val()
                  if($times.eq(i).val()==j){
                     $times.eq(i).attr("disabled", true);
                     $times.eq(i).css("background-color", "gray");
                  }//if 
               }//for 
            }//for 
            })//each 
      }//success 
   })//ajax
};//getTimeTable



//작성 :유동규
//기능 : 조건을 확인한 후 카카오페이 간편결제 신청
function requestPay() {
   //조건확인
   if(checkToRegister() == false){
      return false;
   }
    IMP.request_pay({ // param
       pay_method : 'card', // 'card'만 지원
       merchant_uid : 'merchant_' + new Date().getTime(),
       name : 'STUDIT',
       amount : $("#totalPrice").text(), 
       customer_uid : 'test', //customer_uid 파라메터가 있어야 빌링키 발급이 정상적으로 이뤄집니다.
       buyer_email: buyerEmail,
       buyer_name : buyerName,
    }, function (rsp) { // callback
        if (rsp.success) { 
           // 결제 성공 시 DB 등록
           $("#reserveForm").submit();
           } else {
               alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
           }
    });
}

//작성: 김유란
//기능: 예약버튼을 클릭하면 예약정보를 form에 넣어 전송하는 함수
function checkToRegister(){
   var $times =  $("#times").children("#time"); 
   var length = $times.length;
   var arr=[];
          for(var i=0; i<length; i++){
            if($times.eq(i).hasClass('selected')){
                  arr.push($times.eq(i).val());
               }
          }//선택된 시간만 배열에 넣기(시간 순서대로) 
          
   //form에 예약정보 넣기       
   $("#startTime").val(arr[0]); //배열의 첫 값(최소값)
   $("#endTime").val(arr[arr.length-1]);//배열의 끝값(최대값)
   $("#useDate").val($("#selectedDate").text());
   
   //예약시간 사이에 공백이 없는지 확인하기 위한 변수(배열길이-1=endTime-startTime)
   var duration = parseInt(arr[arr.length-1],10)-parseInt(arr[0],10)
   
   if($("#useDate").val()==""){
      alert("날짜를 선택하세요.");
      return false;
   }else if($("#startTime").val()==""){
      alert("시간을 선택하세요.");
      return false;
   }else if(!checkAvailable($("#startTime").val(), $("#endTime").val()) || arr.length-1!=duration){
      alert("연속된 시간만 선택할 수 있습니다.");
      return false;
   }else{
      if(confirm("${studyRoomVO.name}"+" "+$("#useDate").val()+" "+$("#startTime").val()+"시 - "+$("#endTime").val()+"시50분 \n"+"결제를 진행하겠습니다!")){
         return true;
      }else{
         return false;
      }
   }
   
}

</script>       