<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>LoginPage</title>
		<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
		<link rel="stylesheet" href="css/bootstrap.css">
		<link href="https://fonts.googleapis.com/css?family=Quicksand" rel="stylesheet">
		<script  src="js/bootstrap.js"></script>
		<style>
			@import url(https://fonts.googleapis.com/css?family=Quicksand);
			
			body{
				font-family: 'Quicksand', sans-serif;
				color: #616161;
			}
			
			table{
				  position: absolute;
				  top: 40%;
				  left: 50%;
				  transform : translateX(-50%);
				  border-spacing: 0;
  				  border-collapse: collapse;
			}
		
			table,td{
				width : 500px;
			}
			
			.button{
            	font-family: 'Noto Sans KR', sans-serif;
				background-color: white;
				font-size: 13px;
				border: 1px solid #B9B8B8;
				color: #6E6E6E;
				text-align: center;
				border-radius: 3px;
				padding: 5px 9px;
            }
            
            .button:hover{
                background-color: #F0F0EF;
                border: 1px solid #B9B8B8;
                border-radius: 3px;
            }

            
            #indexLogin{
            	position: absolute;
			  	top: 30%;
				left: 48%;
				width: 75px;
				height: 70px;
            }
            
		</style>
	</head>
	<body>
		<div align="center" >
		<img id="indexLogin" alt="icon" src="./imagefolder/loginImage.png"/>
		</div>
		<br/>
		<form action="./login" method="post" >
			<table class="table table-striped table-bordered" >
				<tr>
					<td >
						<input name= "loginId" type="text" placeholder="ID"  class="form-control"/> 
					</td>
				</tr>
				<tr>
					<td >
						<input name= "loginPw" type="password" placeholder="PW"  class="form-control"/> 
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center" >
						<input class="button" type="submit" value="login"/>
						<input class="button" type="button" value="join" onclick="location.href='./joinForm.jsp'"/>
					</td>
				</tr>
			</table>
		</form>
	</body>
	<script type="text/javascript">
		var msg="${msg}";
		if(msg != ""){
			alert(msg);
		}
		
		
	</script>
</html>