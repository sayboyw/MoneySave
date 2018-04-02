<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<script  src="https://code.jquery.com/jquery-2.2.4.js"></script>
		
	    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	    <script type="text/javascript">
			
	    var avg;
	      var golLimit;
	      var sum;
	      var per;
	    $(document).ready(function(){
	    	$.ajax({
				 type:"post",
				 url:"./ss_Arc",
				 dataType:"JSON",
				 data:{
					 tabIdx:$(".on").val()
				 },
				 success:function(data){
					 console.log("data:"+data);
					 mainChart(data);
					 
				 },
				 error:function(error){
					 console.log(error);
				 }
			 });
	    	
	    });
	    
	    function mainChart(data){
	    	avg = data.avg;
	    	per = data.per;
	    	sum=data.sum;
	    	$("#avg").html(avg+"%");
	    	$("#sum").html(sum+"원");
	    }
	    
	      google.charts.load('current', {'packages':['corechart']});
	      google.charts.setOnLoadCallback(drawChart);
	      
	      
	      //메인그래프 
	      function drawChart() {
	    	  
	    	  var data = google.visualization.arrayToDataTable([
	              ['Language', 'Speakers (in millions)'],
	              ['${avg}', parseInt(avg)], ['${per}', parseInt(per)]
	            ]);

	            var options = {
	              /* backgroundColor.strokeWidth: 20px, */
	              legend: 'none',
	              pieSliceText: 'none',
	              pieStartAngle: 270,
	              tooltip: { trigger: 'none' },
	              slices: {
	                0: { color: '#6AB72F' },
	                1: { color: '#E6E6E6' }
	            	},
	          	  pieHole: 0.5
	           	 };

	            var chart = new google.visualization.PieChart(document.getElementById('piechart'));
	            chart.draw(data, options);
	      }
	    
	    </script>
	    <style>
			h2{
				color: #585858;
				position: absolute;
				left: 145px;
				top: 125px;
			}
			
			h4{
				color: #585858;
				position: absolute;
				left: 134px;
				top: 170px;
			}
			
			#pie{
				position : absolute;
				left:0%;
			}
			
	    </style>
	  </head>
	  <body>
		  <div id="pie">
		   	<div id="piechart" style="width: 343px; height: 343px;"></div>
		    <h2 id = "avg"></h2>
		    <h4 id = "sum"></h4>
		  </div>
	  </body>
</html>