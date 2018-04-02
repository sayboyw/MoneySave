<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
		
		<style>
		.out{
			background-color: green;
			width:40px;
			height:700px;
			position:absolute;
		}
			
		.over{
			position:relative;
			width:40px;
			height:700px;
			
		}
		.in{
			background-color: gray;
			width:40px;
			position:absolute;
		}
		
		/* .black{
				position: absolute;
				width:100%;
				height:100%;
				top: 0px;
				background-color: black;
				opacity: 0.3;
				z-index: 3;
				display: none;
			}
			
		.pop{
				position: absolute;
				top:30%;
				left:25%;
				width: 1000px;
				height: 400px;
				background-color: white;
				display: none;
				z-index: 5;
				
				overflow : auto;
				scrollbar-face-color:#cecece;
			} */
		
		
		</style>
	</head>
	<body>
<!-- 	<div class="black"></div>
	<div class ="pop"></div> -->
	<div class="over">
		<!-- add -->
	</div>
	
	
	
	</body>
	<script>
	$(document).ready(function(){
		$.ajax({
			type:"post",
			url:"./mainLong",
			dataType:"json",
			success:function(data){
				console.log("===============")
				console.log(data.list);
				if(data.list.length==0){//만약 장기 계획이 없을 시
					
				}else{
					mainLong(data.list);
				}
				
			},
			error:function(error){
				console.log(error);
			}
		});
		
	});
	
	function mainLong(list){
		/*$(".in").css("height","");*/
		
		console.log(list);
		var content="";
		var result=list[0].longStackM*100/list[0].longGoalM;
		var graybar=100-result;
		console.log(list[0].longStackM);
		console.log(list[0].longGoalM);
		console.log(graybar);

		list.forEach(function(item,index){
			
			
			
				content+="<div class='out'>";
					content+="<div class='in'>";
					
					content+="</div>";
				content+="</div>";
			
			
			
		
		});
		$(".over").append(content);
		
		$(".in").css("height",""+graybar+"%");

	}
	
	  /* $(".over").hover(function() {
		$(".black").css("display","block");
		$(".pop").css("display","block");
		}, function(){
			
		$(".black").css("display","none");
		$(".pop").css("display","none");
			
		}); */
	 
	 /* $(".over").mouseenter(function() {
		 $(".black").css("display","block");
			$(".pop").css("display","block");
	 });
	 $(".over").mouseleave(function() {
		 $(".black").css("display","none");
			$(".pop").css("display","none");
	 }); */
		
	
	
	
	
	
	</script>
</html>