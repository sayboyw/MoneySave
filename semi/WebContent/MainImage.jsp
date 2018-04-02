<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<script  src="https://code.jquery.com/jquery-2.2.4.js"></script>
		<style>
			#good{
				display: none;
			}
			
			#so{
				display: none;
				width : 1292px;
				height: 702px;
			}
			#bad{
				display: none;
			}
		</style>
		<script>
		var avg;
		console.log(avg);
		
		$(document).ready(function(){
			
			$.ajax({
				 type:"post",
				 url:"./ss_Image",
				 dataType:"JSON",
				 data:{
					tabIdx:$(".on").val() 
				 },
				 success:function(data){
					 console.log("data:"+data);
					 mainImage(data);
					 
				 },
				 error:function(error){
					 console.log(error);
				 }
			 });
			
			function  mainImage(data){
				avg= data.avg;
				
				if(avg<=30){
					$("#good").css("display","block");
				}else if (avg<=70){
					$("#so").css("display","block");
				}else{
					$("#bad").css("display","block");
				}
			}
		});
		</script>
		
	</head>
	<body>
			<img id="good" src ="./imagefolder/good.png"/>
			<img id="so" src ="./imagefolder/so.png"/>
			<img id="bad" src ="./imagefolder/bad.png"/>

	</body>
</html>