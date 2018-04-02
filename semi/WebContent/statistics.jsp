<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<script  src="https://code.jquery.com/jquery-2.2.4.js"></script>
		<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
		<style>
			@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);
			
			#chart_div{
				font-family: 'Noto Sans KR', sans-serif;
				position: absolute;
				left: 26%;
				top: 10%;
				align: center;
			}
			
			#piechart{
				font-family: 'Noto Sans KR', sans-serif;
				position: absolute;
				left: 8%;
				top: 80%;
				align: center;
			}
			
			#dotwchart{
				font-family: 'Noto Sans KR', sans-serif;
				position: absolute;
				right: 8%;
				top: 80%;
				align: center;
			}
			
			#selectBox{
				/* z-index: 1; */
				font-family: 'Noto Sans KR', sans-serif;
				position: absolute;
				left: 17%;
				top: 16.5%;
				align: center;
				padding: 7px 10px;
				font-size: 12px;
				color: #6E6E6E;
				border-radius: 3px;
			}
			
			#contain{
			    position: absolute;
			    left: 50%;
			    transform: translateX(-50%);
			    width: 100%;
			    overflow: auto;
			    z-index: 3;
			    top: 90px;
			    height: 835px;
			}
			
		</style>
		
		<!-- 구글 차트 -->
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<script type="text/javascript">
			google.charts.load('current', {'packages':['corechart']});
			
			
			/* 1일평균 지출액 */
			var subject;
			var avg ;
			var goalList;
			var goal;
			var list;
			var gIdx;
			
			$(document).ready(function(){
			
				$.ajax({
					 type:"post",
					 url:"./ss_bar",
					  data:{
						 tabIdx : $(".on").val()
					 }, 
					 dataType:"JSON",
					 success:function(data){
						 console.log("data:"+data);
						 bar(data); 
					
					 },
					 error:function(error){
						 console.log(error);
					 }
				 });
						
				
				//막대그래프를 그리기위한 함수

				function  bar(data){
						subject=data.subjectList;
						avg = data.resultList;
						goalList = data.gList;
						
						goal = subject.split("/");
						console.log("goalsize:"+goal.length);
						console.log("goal:"+goal[0]);
						
						list = avg.split("/");
						console.log(list[0]);
						console.log(parseFloat(list[0]));
						console.log(list[1]);
						
						gIdx=goalList.split("/");
						console.log(gIdx);
						console.log(gIdx[0]);
						
						console.log("selecBox:"+goal);
						var content = "";

						for(var i=0;i<goal.length;i++){
							content += "<option id='sel(i)' value="+gIdx[i]+">"+goal[i]+"</option>";
						}
						$("#selectBox").append(content);
						
						var obj = gIdx[0];
						goalSelect(obj);

						google.charts.setOnLoadCallback(drawVisualization);
					}

					
			});
			
			
			
			
			
			//일평균지출 막대그래프
			function drawVisualization(){			//tabidx가 필요함
				var data = google.visualization.arrayToDataTable ([
					['단위기간', '일평균지출',{role : 'style'}],
					[goal[4], parseFloat(list[4]), 'color:#6AB72F'],
					[goal[3], parseFloat(list[3]), 'color:#6AB72F'],
					[goal[2], parseFloat(list[2]), 'color:#6AB72F'],
					[goal[1], parseFloat(list[1]), 'color:#6AB72F'],
					[goal[0], parseFloat(list[0]), 'color:#6AB72F'],
				]);
				
				var options = {
					title : '1일 평균 지출액 ',
					vAxis : {title : '원'},
					hAxis : {title : '단위기간'},
					seriesType : 'bars',
					legend: 'none'
				};
				
				var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
				chart.draw(data, options);
			}
			
			
			//셀렉트박스 온체인지 함수
			 function goalSelect(obj){
				 
				  $.ajax({
					 type:"post",
					 url:"./ss_select",
					 data:{
						 select:obj
					 },
					 dataType:"JSON",
					 success:function(data){
						 console.log("data:"+data);
						 pie(data); 
					
					 },
					 error:function(error){
						 console.log(error);
					 }
				 });
				  
			 }
			
			//파이그래프에 출력하기 위한 함수

			var sub;
			var avg;
			
			var dotw;
			var davg;
			
			function pie(data){
				var subject = data.cSubList;
				console.log("subject:"+subject);
				sub = subject.split("/");
				
				var avrage = data.cAvgList;
				avg = avrage.split("/");
				console.log("avrage:"+avrage);

				console.log("sub:모양"+sub);
				console.log("avg:모양"+avg);
				console.log("avg[]:"+parseInt(avg[0]));
				
				//요일별 그래프에 출력하기 위한 함수
				var day = data.dSubList;
				dotw = day.split("/");
				
				var avrage = data.dAvgList;
				davg = avrage.split("/");
				
				google.charts.setOnLoadCallback(drawChart);
				google.charts.setOnLoadCallback(dotwChart);
				
			}
			

					
			//카테고리별 파이그래프
			function drawChart() {
		
		        var data = new google.visualization.DataTable();
		        data.addColumn('string','카테고리');
		        data.addColumn('number','지출금액(%)');
		        data.addRows([
		 
		          [sub[0], parseFloat(avg[0])],
		          [sub[1], parseFloat(avg[1])],
				  [sub[2], parseFloat(avg[2])],
		          [sub[3], parseFloat(avg[3])],
		          [sub[4], parseFloat(avg[4])],
		          [sub[5], parseFloat(avg[5])],
		          [sub[6], parseFloat(avg[6])],
		          [sub[7], parseFloat(avg[7])],
		          [sub[8], parseFloat(avg[8])],
		          [sub[9], parseFloat(avg[9])],
		          [sub[10], parseFloat(avg[10])],
		          [sub[11], parseFloat(avg[11])]
		        ]);
		
		        var options = {
		          title: '카테고리별 지출금액',
		          slices:{
			          /* 0: { color: '#88D184' },
		              1: { color: '#CDCD1A' },
		              2: { color: '#6D7B3E' },
		              3: { color: '#437211' },
		              4: { color: '#87D38D' },
		              5: { color: '#4AA080' },
		              6: { color: '#62C2AD' },
		              7: { color: '#CDCD1A' },
		              8: { color: '#91C480' },
		              9: { color: '#57C434' },
		              10: { color: '#217405' },
		              11: { color: '#9AB035' } */
		          }
		        };
		
		        var chart = new google.visualization.PieChart(document.getElementById('piechart'));
		        chart.draw(data, options);
			}
//=============================================

			//요일별 그래프
			function dotwChart() {
		
		        var data = new google.visualization.DataTable();
		        data.addColumn('string','요일');
		        data.addColumn('number', '지출금액(%)');
		        data.addRows([
				  [dotw[0], parseFloat(davg[0])] ,
		          [dotw[1], parseFloat(davg[1])] ,
				  [dotw[2], parseFloat(davg[2])],
		          [dotw[3], parseFloat(davg[3])],
		          [dotw[4], parseFloat(davg[4])],
		          [dotw[5], parseFloat(davg[5])],
		          [dotw[6], parseFloat(davg[6])] 
		        ]);
		
		        var options = {
		          title: '요일별 지출금액',
		          slices:{
			          /* 0: { color: '#6AB72F' },
			          1: { color: '#88D184' },
		              2: { color: '#CDCD1A' },
		              3: { color: '#6D7B3E' },
		              4: { color: '#437211' },
		              5: { color: '#87D38D' },
		              6: { color: '#4AA080' } */
		          }
		        };
		
		        var chart = new google.visualization.PieChart(document.getElementById('dotwchart'));
		        chart.draw(data, options);
			}
		</script>
	</head>
	<body>
		<jsp:include page="loginBox.jsp"></jsp:include>
		<input type="hidden" value="stat" class="page"/>

		<div id ="contain" >
			<div id="chart_div" style="width:900px; height: 500px;"></div>
			<select id="selectBox" onchange="javascript:goalSelect(this.value);">
				<!-- 셀렉트 옵션리스트 출력영역 -->
			</select>
			<div id="piechart" style="width:900px; height: 500px;"></div>
			<div id="dotwchart" style="width:900px; height: 500px;"></div>
		</div>
	</body>
	
</html>