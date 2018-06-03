<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="dashboard-counts section-padding">
        <div class="container-fluid">
          <div class="row">
          	<div class="col-xl-1 col-md-4 col-6"></div>
            <div class="col-xl-2 col-md-4 col-6">
              <div class="wrapper count-title d-flex">
                <div class="icon"><i class="icon-user"></i></div>
                <div class="name"><strong class="text-uppercase">LEADER</strong><span>${leader.memberEmail }</span>
                  <div class="count-number" style="font-size: 30px; margin-top: 15px;">${leader.name }</i></div>
                </div>	
              </div>
            </div>
            <div class="col-xl-2 col-md-4 col-6">
              <div class="wrapper count-title d-flex">
                <div class="icon"><i class="icon-padnote"></i></div>
                <div class="name"><strong class="text-uppercase">GROUP MEMBER</strong><span>Last 5 days</span>
                  <div class="count-number" align="center">${GroupMemberCount }</div>
                </div>
              </div>
            </div>
            <div class="col-xl-2 col-md-4 col-6">
              <div class="wrapper count-title d-flex">
                <div class="icon"><i class="icon-check"></i></div>
                <div class="name"><strong class="text-uppercase">TO DO LIST</strong><span>Last 2 months</span>
                  <div class="count-number">342</div>
                </div>
              </div>
            </div>
            <div class="col-xl-2 col-md-4 col-6">
              <div class="wrapper count-title d-flex">
                <div class="icon"><i class="icon-bill"></i></div>
                <div class="name"><strong class="text-uppercase">DOING LIST</strong><span>Last 2 days</span>
                  <div class="count-number">123</div>
                </div>
              </div>
            </div>
            <div class="col-xl-2 col-md-4 col-6">
              <div class="wrapper count-title d-flex">
                <div class="icon"><i class="icon-list"></i></div>
                <div class="name"><strong class="text-uppercase">DONE LIST</strong><span>Last 3 months</span>
                  <div class="count-number">92</div>
                </div>
              </div>
            </div>
             <div class="col-xl-1 col-md-4 col-6">
             <!--  <div class="wrapper count-title d-flex">
                <div class="icon"><i class="icon-list-1"></i></div>
                <div class="name"><strong class="text-uppercase">New Cases</strong><span>Last 7 days</span>
                  <div class="count-number">70</div>
                </div>
              </div> -->
            </div> 
          </div>
        </div>
      </section>

      <!-- Header Section-->
      <section class="dashboard-header section-padding">
        <div class="container-fluid">
          <div class="row d-flex align-items-md-stretch">
            <!-- To Do List-->
            <div class="col-lg-3 col-md-6">
              <div class="wrapper to-do" style="border:1px solid; border-color: #BDBDBD;">
                <header style="margin: 20px;">
                  <h2 class="display h4" style="text-align: center;">Register Schedule</h2>
                  <p>Click the "SCHEDULER" tap for checking whole schedule</p>
                </header>
                <table class="table">
                	<thead>
                		<tr>
                			<th>
                				<select id="kanban" name="kanban" class="form-control">
                					<option value="todo">TO DO</option>
                					<option value="doing">DOING</option>
                					<option value="done">DONE</option>
                				</select>
                			</th>
                			<th><input type="text" name="title" id="title" placeholder="제목을 입력하세요!" class="form-control"></th>
                		</tr>
                	</thead>
                	<tbody>
                		<tr>
                			<td colspan="2">
                				<pre><textarea style="width:100%; resize:none; height: 100px;" placeholder="내용을 입력하세요!" id="content" name="content"></textarea></pre>
                			</td>
                		</tr>
                	</tbody>
                </table>
                <!-- <ul class="check-lists list-unstyled">
                  <li class="d-flex align-items-center"> 
                    <input type="checkbox" id="list-1" name="list-1" class="form-control-custom">
                    <label for="list-1">Similique sunt in culpa qui officia</label>
                  </li>
                  <li class="d-flex align-items-center"> 
                    <input type="checkbox" id="list-2" name="list-2" class="form-control-custom">
                    <label for="list-2">Ed ut perspiciatis unde omnis iste</label>
                  </li>
                  <li class="d-flex align-items-center"> 
                    <input type="checkbox" id="list-3" name="list-3" class="form-control-custom">
                    <label for="list-3">At vero eos et accusamus et iusto </label>
                  </li>
                  <li class="d-flex align-items-center"> 
                    <input type="checkbox" id="list-4" name="list-4" class="form-control-custom">
                    <label for="list-4">Explicabo Nemo ipsam voluptatem</label>
                  </li>
                  <li class="d-flex align-items-center"> 
                    <input type="checkbox" id="list-5" name="list-5" class="form-control-custom">
                    <label for="list-5">Similique sunt in culpa qui officia</label>
                  </li>
                  <li class="d-flex align-items-center"> 
                    <input type="checkbox" id="list-6" name="list-6" class="form-control-custom">
                    <label for="list-6">At vero eos et accusamus et iusto </label>
                  </li>
                  <li class="d-flex align-items-center"> 
                    <input type="checkbox" id="list-7" name="list-7" class="form-control-custom">
                    <label for="list-7">Similique sunt in culpa qui officia</label>
                  </li>
                  <li class="d-flex align-items-center"> 
                    <input type="checkbox" id="list-8" name="list-8" class="form-control-custom">
                    <label for="list-8">Ed ut perspiciatis unde omnis iste</label>
                  </li>
                </ul> -->
                
              </div>
            </div>
            <!-- Pie Chart-->
            <div class="col-lg-4 col-md-6">
              <div class="wrapper project-progress" style="text-align: center;">
                <h2 class="display h4">Progress Of Study</h2><!-- 
                <p> Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p> -->
                <div class="pie-chart">
                  <canvas id="pieChartt" width="320px;" height="320px;"></canvas>
                </div>
              </div>
            </div>
            
            <%-- <!-- Line Chart -->
            <div class="col-lg-5 col-md-12 flex-lg-last flex-md-first align-self-baseline">
              <div class="wrapper sales-report">
                <h2 class="display h4">Sales marketing report</h2>
                <p> Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolor amet officiis</p>
                <div class="line-chart">
                  <canvas id="lineCahrt"></canvas>
                </div>
              </div>
            </div> --%>
            <div class="col-lg-5 col-md-12 flex-lg-last flex-md-first align-self-baseline">
				<h2 class="display h4" style="text-align: center;">Top3 Member Rank</h2>
				<form action="${pageContext.request.contextPath}/group/updateGroupMemberPosition" method="post" id="changePositionForm">
			  	<table class="table table-hover">
					<thead>
						<tr>
							<th>이름</th>
							<th>메일</th>
							<th>직책</th>
							<th>게시글수</th>
						</tr>
					</thead>
					<tbody id="memberList">
						<c:forEach items="${topList}" var="list">
							<tr>
								<td>
								<div style="width: 50px;">
								<img alt="person" class="img-fluid rounded-circle" src="${pageContext.request.contextPath}/resources/upload/${list.PICPATH}">
								${list.NAME}
								</div>
								</td>
								<td>${list.EMAIL }</td>
								<td>${list.POSITION }</td>
								<td>${list.POST}</td>
								<td></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<input type="hidden" name="groupMemberNo" id="groupMemberNo">
				</form>
			</div>
          </div>
        </div>
      </section>

<style>
th,td{
	text-align: center;
	vertical-align: middle;
}
</style>

<script>
$(document).ready(function(){
	var chartDiv = $("#pieChartt");
	var myChart = new Chart(chartDiv, {
	    type: 'pie',
	    data: {
	        labels: ["TO DO", "DOING", "DONE"],
	        datasets: [{
	            data: [30,60, 10],
	            backgroundColor: [
	            	"#FF6384",
		            "#4BC0C0",
		            "#FFCE56"
		            /* "#E7E9ED",
		            "#36A2EB" */
	            ]
	        }]
	    },
	    options: {
	 	responsive: true,
		maintainAspectRatio: false,
	    }
	});
});
</script>