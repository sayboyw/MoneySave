<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
		<script  src="js/bootstrap.js"></script>
		<link rel="stylesheet" href="css/bootstrap.css">
		<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Quicksand" rel="stylesheet">
		<style>
		
			@import url(https://fonts.googleapis.com/css?family=Quicksand);
			@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

			body {
    		font-family: 'Noto Sans KR', sans-serif;
    		color: #616161;
 
			}

			#listTitle{
				position: absolute;
				left : 14%;
				top : 13%;
				width : 200px;
				height: 50px;
				text-align: center;
			}
			#memList{
				position: absolute;
				left : 16%;
				top : 20%;
				border-spacing: 0;
  				border-collapse: collapse;
			}
			
			th,td{
				height : 40px;
				width: 200px;
				text-align: center;
			}
			th{
				font-family: 'Quicksand', sans-serif;
			}
			td{
				height: 30px; 
				
			}
			tr:nth-child(even){
                background-color: #6AB72F;
            }
            h3{
            	text-align: center;
            }
		</style>
	</head>
	<body>
		<jsp:include page="loginBox.jsp"></jsp:include>
		<div id="listTitle"><h3>회원리스트</h3></div>
		<table id="memList"  class="table table-striped table-bordered">
			<tr>
				<th>ID</th>
				<th>PW</th>
				<th>NAME</th>
				<th>Phone NO.</th>
				<th>E-mail</th>
				<th>DELETE</th>
			</tr>
			<!-- 리스트 출력 영역 -->
		</table>
	</body>
	<script>
		$(document).ready(function(){
			$.ajax({
				type:"post",
				url:"./adminList",
				dataType:"json",
				success:function(data){
					console.log(data);
					listPrint(data.list);
				},
				error:function(error){
					console.log(error);
				}
			});
		});
		
		function listPrint(list){
			console.log(list);
			
			var content="";
			list.forEach(function(item,index){
				console.log(item.memberid);
				content+="<tr>";
				content+="<td>"+item.memberid+"</td>";
				content+="<td>"+item.memberpw+"</td>";
				content+="<td>"+item.memberName+"</td>";
				content+="<td>"+item.memberPhone+"</td>";
				content+="<td>"+item.memberEmail+"</td>";
				content+="<td><a href='./adminDel?memberid="+item.memberid+"' >탈퇴</a></td>";
				content+="</tr>";
			});

			$("#memList").append(content);
		}
		
		var msg="${msg}";
		if(msg != ""){
			alert(msg);
		}
	</script>
</html>