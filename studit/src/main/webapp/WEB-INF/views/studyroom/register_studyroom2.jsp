<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<div id="datepicker" class="left-box"></div>
<script>
    $('#datepicker').datepicker({
        altField : '#useDate',
        dateFormat : 'yy-mm-dd'
    });
    
 
	/*
	* 1. Button에 클래스 지정
	* 2. $(".클래스명").click(function(){
	*	
		})
		
		
		var startTime="";
		var endTime="";
		3. 클릭된 값을 넣기
			3-1. 첫 번째 클릭이면(startTime과 endTime = "") startTime, endTime에 넣기
			3-2. 두 번째 클릭부터 startTime과 크기 비교
				  3-2-1. startTime보다 작으면 기존 startTime을 endTime으로 지정 
				  			그 후 입력한 값을 startTime으로 지정
				  3-2-2. startTime보다 크면 endTime으로 지정
				  3-2-3. 같은 값을 클릭하면 startTime과 endTime중 어느 값인지 확인
				  		   3-2-3-1. 클릭한 값이 startTime이면 startTime에 endTime 넣기(endTime 유지) 
				  		   3-2-3-2. 클릭한 값이 endTime이면 endTime에 startTime 넣기(startTime 유지)
						   3-2-3-3. 색변경
			3-3. startTime부터 클릭한 값을 크기비교
				  3-3-1. startTime보다 작으면 입력한 값을 startTime으로 지정
				  3-3-2. startTime보다 크고 endTime보다 작으면 startTime으로 지정
				  3-3-3. 위의 조건보다 아니면 endTime
		
		
		
		3. 색상을 확인(클릭된지 확인)
	        3-1 클릭되어있지 않은 색이면 temp에 추가 temp += $(this).val() + ","
	             3-1-1 temp에 담고 색변경
	        3-2 클릭되어있는 색이면 temp에서 값을 빼자--> 방법 고안
	        	3-2-1 클릭되어있지 않은 색으로 변경
	    
	        
		
	* 3. 클릭되면 $(this).val()로 값을 가져와 temp += ㅇㄹㅇㄴㄹ+"," 로 추가
	*    3-1. 클릭되면 색을 변경
	*    3-2. 이미 색이 변경되있을수도있다! 
	*/

    
    
    $(document).ready(function(){
    	var startTime="";
    	var endTime="";
    	$("#timeTable td").click(function(){
    		var $this = $(this);
    		if(startTime==="" && endTime===""){
	    		startTime = $this.text();
	    		endTime = $this.text();
    		}else{
	    		if(parseInt(startTime, 10) > parseInt($this.text(),10)){
	    			endTime = startTime;
	    			startTime = $this.text();
	    		}else if(parseInt(startTime, 10) < parseInt($this.text(),10)){
	    			if(parseInt(endTime, 10) > parseInt($this.text(),10)){
	    				startTime = startTime;
	    			}else if(parseInt(endTime, 10) < parseInt($this.text(),10)){
		    			startTime = endTime;
	    			}
	    			endTime = $this.text();
	    		}else if(parseInt(startTime, 10) == parseInt($this.text(),10)){
	    			if(parseInt(startTime, 10) == parseInt($this.text(),10)){
	    				startTime = endTime;
	    			}else if(parseInt(endTime, 10) == parseInt($this.text(),10)){
	    				endTime = startTime;
	    			}
	    		}else if(parseInt(startTime, 10) >  parseInt($this.text(),10)){
	    			startTime = parseInt($this.text(),10);
	    		}else if(parseInt(startTime, 10) <  parseInt($this.text(),10) && parseInt(endTime, 10) >  parseInt($this.text(),10)){
	    			startTime = parseInt($this.text(),10); 
	    		}else{
	    			endTime = parseInt($this.text(),10);
	    		}
    		}
    		$("#startTime").val(startTime);
    		$("#endTime").val(endTime);
    	});//click
    });//ready
    function checkForm(){
    	if($("#startTime").val()==="" || $("#endTime").val()==="" || $("#useDate").val()===""){
    		alert("날짜와 시간을 확인해주세요.");
    		return false;
    	}
    	return true;
    }
</script>

<hr>
<table id="timeTable" class="r-table">
	<tr>
		<td class="r-td">01</td>
		<td class="r-td">02</td>
		<td class="r-td">03</td>
		<td class="r-td">04</td>
		<td class="r-td">05</td>
		<td class="r-td">06</td>
		<td class="r-td">07</td>
		<td class="r-td">08</td>
		<td class="r-td">09</td>
		<td class="r-td">10</td>
		<td class="r-td">11</td>
		<td class="r-td">12</td>
	</tr>
	<tr>
		<td class="r-td">13</td>
		<td class="r-td">14</td>
		<td class="r-td">15</td>
		<td class="r-td">16</td>
		<td class="r-td">17</td>
		<td class="r-td">18</td>
		<td class="r-td">19</td>
		<td class="r-td">20</td>
		<td class="r-td">21</td>
		<td class="r-td">22</td>
		<td class="r-td">23</td>
		<td class="r-td">24</td>
	</tr>
</table>

<form action="${pageContext.request.contextPath }/studyroom/registerStudyRoom" method="post"> 
신청날짜 : <input type="text" id="useDate" name="useDate" readonly="readonly"><br>
시작시간 : <input type="text" id="startTime" name="startTime" readonly="readonly"><br>
끝시간 : <input type="text" id="endTime" name="endTime"  readonly="readonly"><br>
<input type="hidden" id="studyRoomNo" name="studyRoomNo" value="1">
<input type="hidden" id="memberEmail" name="memberEmail" value="${memberVO.memberEmail}">
<input type="submit" onclick="return checkForm()" value="신청하기">
</form>








