<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
		<link rel="stylesheet" href="css/bootstrap.css">
		<link href="https://fonts.googleapis.com/css?family=Quicksand" rel="stylesheet">
		<script  src="js/bootstrap.js"></script>
		<style>
			@import url(https://fonts.googleapis.com/css?family=Quicksand);
			@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);
		
			body{
				font-family: 'Quicksand', sans-serif;
				color: #616161;
			}
		#a{
			position: absolute;
			top : 30%;
			left: 50%;
			transform : translateX(-50%);
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
            #button-cover{
            	position: absolute;
            	left : 50%;
            	top : 50%;
            	transform : translateX(-50%);
            }
            #table-cover{
				position: absolute;
			  	top: 30%;
				left: 50%;
				width: 600px;
				height: 250px;
				transform : translateX(-50%);
				border-spacing: 0;
				border-collapse: collapse;
			}
		</style>
	</head>
	<body>
		<jsp:include page="loginBox.jsp"></jsp:include>
		<form action="lp_add" method="post" >
		
		
		<div id="table-cover">
			<table class="table table-striped table-bordered">
				<tr>
					<td colspan="3" align="center">
						<input type="text" name="subject" placeholder="장기계획 제목"/>
					</td>
				</tr>
				<tr>
					<td>시작날짜 :
						<select name="startYear">
							<option>-년도</option>
							<option value="2017">2017</option>
							<option value="2018" selected>2018</option>
							<option value="2019">2019</option>
							<option value="2020">2020</option>
							<option value="2021">2021</option>
							<option value="2022">2022</option>
							<option value="2023">2023</option>
							<option value="2024">2024</option>
							<option value="2025">2025</option>
							<option value="2026">2026</option>
							
						</select>
					
						<select name="startMonth">
							<option>-월</option>
							<option value="01">1</option>
							<option value="02">2</option>
							<option value="03">3</option>
							<option value="04">4</option>
							<option value="05">5</option>
							<option value="06">6</option>
							<option value="07">7</option>
							<option value="08">8</option>
							<option value="09">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>
					</td>
				
					<td><b>  ~  </b></td>
					<td>
						<select name="endYear">
							<option>-년도</option>
							<option value="2018">2018</option>
							<option value="2019">2019</option>
							<option value="2020">2020</option>
							<option value="2021">2021</option>
							<option value="2022">2022</option>
							<option value="2023">2023</option>
							<option value="2024">2024</option>
							<option value="2025">2025</option>
							<option value="2026">2026</option>
							<option value="2027">2027</option>
						</select>
				
						<select name="endMonth">
							<option>-월</option>
							<option value="01">1</option>
							<option value="02">2</option>
							<option value="03">3</option>
							<option value="04">4</option>
							<option value="05">5</option>
							<option value="06">6</option>
							<option value="07">7</option>
							<option value="08">8</option>
							<option value="09">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="3" align="center">
						<input type="text" name="goalMoney" placeholder="목표금액">
					</td>
				</tr>
			</table>
		</div>
		<div id="button-cover">
			<input type="submit" class="button" value="확인"/>
			<input type="button" class="button" value="취소" onclick="aa()">
		</div>

		</form>
	
	</body>
	<script>
		function aa(){
			if (confirm("정말 취소하시겠습니까?")==true){
				location.href="longTermPlan.jsp";
			}else{
				return;
			}
		};
	</script>
</html>