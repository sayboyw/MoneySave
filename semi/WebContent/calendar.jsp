<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>

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
				font-family: 'Noto Sans KR', sans-serif;
				color: #616161;
			}
		
			/* 날짜 클릭 시 출력되는 검은 배경 */
			#cal_back{
				position: absolute;
				width:100%;
				height:100%;
				top: 0px;
				background-color: black;
				opacity: 0.3;
				z-index: 3;
				display: none;
			}
			
			/* 메모 팝업 클릭 시 출력되는 검은 배경 */
			#cal_back2{
				position: absolute;
				top: 0px;
				width:100%;
				height:100%;
				background-color: black;
				opacity: 0.4;
				z-index: 6;
				display: none;
			}
			
			/* 날짜(달력의 일) */
			#cal_date{
				position: absolute;
				top:150px;
				left:300px;
				width: 100px;
				height: 100px;
				background-color: yellowgreen;
				text-align: center;
				z-index: 1;
			}
			
			/* 날짜 클릭 시 출력되는 하얀 배경 */
			#cal_spend{
				position: absolute;
				top:35%;
				left:30%;
				width: 700px;
				height: 233px;
				background-color: white;
				display: none;
				z-index: 5;
				
				overflow : auto;
				scrollbar-face-color:#cecece;
			}
			
			/* 날짜 클릭 시 출력되는 테이블 */
			table{
				width: 100%;
				float: left;
			}
			
			th{
				color: #5B5B5B;
				height: 32px;
			}
			
			td{
				/* 테이블 width, height를 7로 나눈 값 */
				width: 106;
				height: 99;
			}
			
			/* append되는 테이블 */
			.cal_dv{
				height: 100px;
				width: 700px;
				z-index: 5;
				background-color: white;
			}
			
			table, th, td{
				border: 1px solid lightgray;
				border-collapse: collapse;
				text-align: center;
			}
			
			/* 달력 table 스타일 */
			#cal_calendar{
				position: absolute;
				width: 750px;
				height: 700px;
				top: 160px;
				left: 30%;
				align: center;
			}
			
			/* append되는 table의 스타일 */
			tr{
				border: 1px solid lightgray;
				border-collapse: collapse;
				padding: 5px 10px;
			}
			
			/* append되는 table에서 Memo에 해당하는 img의 스타일 */
			#cal_memoBtn{
				z-index: 5;
			}
			
			/* Memo 팝업 스타일 */
			.cal_memoPop{
				border: 2px solid lightgray;
				z-index: 7;
				position: absolute;
				top:37%;
				left:33%;
				width: 500px;
				height: 100px;
				background-color: white;
				text-align: center;
				padding: 50px;
				display: none;
			}
			
			/* 닫기 버튼 */
			#cal_x{
				position: absolute;
				display: none;
				width: 25px;
				height: 25px;
				top:30%;
				right:33%;
				z-index: 5;
			}
			
			/* 메모 닫기 버튼의 div */
			.cal_x2{
				position: absolute;
				display: none;
				width: 20px;
				height: 20px;
				top:39%;
				left:62%;
				z-index: 8;
			}
			
			/* 메모 닫기 버튼 */
 			/*.cal_x2img{
				position: absolute;
 				right:8px;
				top:8px;
			} */
			
			#tab1{
				width: 25px;
				height: 25px;
				background-color:  blue;
			}

			/* 달력 제목 영역 */
            #cal_caSubject{
                position: absolute;
                left: 14%;
            	top: 200px;
            	text-align: center;
            }
            
            /* 달력 페이지 이동 */            
            #cal_1{
            	position: absolute;
            	width: 23px;
            	height: 23px;
            	top: 435px;
            	left: 27%;
            	cursor: pointer;
            }
            
            #cal_2{
            	position: absolute;
            	width: 23px;
            	height: 23px;
            	top: 435px;
            	left: 71.5%;
            	cursor: pointer;
            }
            
            .btn{
				font-family: 'Noto Sans KR', sans-serif;
                background-color: white;
                border: 1px solid #B9B8B8;
                /* 버튼 안의 텍스트의 색 */
                color: #585858;
                text-align: center;
                padding: 8px 10px;
                font-size: 14px;
                position: relative;
                left: 313px;
            	top: 350px;
            	border-radius: 3px;
            }
            
            .btn:hover{
                background-color: #F0F0EF;
                border: 1px solid #B9B8B8;
                border-radius: 3px;
            }
            
            .tdStyle{
            	cursor: pointer;
            }
            
            .tdStyle:hover{
            	background-color: #F2F2F2;
            }
            
            /* a링크 스타일 */
           	a:link{color:#616161; text-decoration: none;}
			a:visited{color:#616161; text-decoration: underline;}
			a:hover{color:#000000; text-decoration: underline;}
			a:active{color:#616161; text-decoration: none;}
		</style>
	</head>
	<body>	
		<jsp:include page="loginBox.jsp"></jsp:include>		<!-- 로그인박스 -->
		<input type="hidden" value="cal" class="page"/>
		<!-- 달력 년, 월 -->
		<div id="cal_caSubject">
			<h2><span id="cal_year"></span>년 <span id="cal_month"></span>월</h2>
		</div>
		<div><h3><img id ="cal_2" src="./imagefolder/next.png"/></h3></div>
		<div><h3><img id ="cal_1" src="./imagefolder/previous.png"/></h3></div>
		<input class="btn" type="button" value="지출" name="outcome" onclick="cal_outcomeShow()"/><br/><br/>
		<input class="btn" type="button" value="수입" name="income" onclick="cal_incomeShow()"/><br/><br/>
		
		<!-- 달력 테이블 -->
		<table id="cal_calendar">
			<tr>
				<th>일</th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th>토</th>
			</tr>
		</table>
		<input class="btn" type="button" name="cal_addBtn" value="추가" onclick="location.href='./calendarAdd.jsp'"/>
	
		<input type="hidden" id="tab1" value="1"/>
		<!-- <div id="cal_date">Day 6</div> -->
		<div id="cal_back"></div> <!-- 검은 배경 -->
		<!-- X 버튼 -->
		<div id="cal_x">
			<img src="./imagefolder/letter_x.png" height="20" width="20"/>
		</div>
		<div id="cal_spend"><!-- 테이블 -->
			<table id="cal_table">
				<tr>
					<th>카테고리</th>
					<th>제목</th>
					<th>금액</th>
					<th>메모</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</table>
		</div>
		<div id = "cal_back2"></div>
		<div class="cal_memoPop"></div>
		<div class="cal_x2"></div>		
	</body>
	<script>
	console.log("달력페이지에서 a태그 ㄴ값 : "+$(".on").val());
		var cal_click = "";
		var outcomeCnt = 1;
		var incomeCnt = 3;
		var idNum = 0;
		
		/* $(document).ready(function(){
			//showTerm();
			
			outCount(outcomeCnt);
			
		});
		 */
		// 전달로 이동
		$("#cal_1").click(function(){
			$.ajax({
				type: "get",
				url: "./ca_calAddMinus",
				dataType: "JSON",
				data: {
					calYear: $("#cal_year").html(),
					calMonth: $("#cal_month").html()
				},
				success: function(data){
					cal_makeMinus(data);
					console.log(data.makeDTO.endDay);
					cal_click=data.makeDTO.startDay;
					
					if(data.makeDTO.month == 0){
						$("#cal_caSubject").html("<h2><span id='cal_year'>"+data.makeDTO.year+"</span>년 "
								+"<span id='cal_month'>"+(data.makeDTO.month+1)+"</span>월</h2>");
					}else{
						$("#cal_caSubject").html("<h2><span id='cal_year'>"+data.makeDTO.year+"</span>년 "
								+"<span id='cal_month'>"+data.makeDTO.month+"</span>월</h2>");
					}
					
					console.log("cal_click : "+cal_click);
					console.log("시작일 : "+data.makeDTO.startDay);
					outCount(outcomeCnt);
					inCount(incomeCnt);
				},
				error: function(error){
					console.log(error);
				}
			});
		});
		
		// 다음달로 이동
		$("#cal_2").click(function(){
			$.ajax({
				type: "get",
				url: "./ca_calAddPlus",
				dataType: "JSON",
				data: {
					calYear: $("#cal_year").html(),
					calMonth: $("#cal_month").html()
				},
				success: function(data){
					cal_makePlus(data);
					console.log(data.makeDTO.endDay);
					cal_click=data.makeDTO.startDay;
					

					if(data.makeDTO.month == 0){
						$("#cal_caSubject").html("<h2><span id='cal_year'>"+data.makeDTO.year+"</span>년 "
								+"<span id='cal_month'>"+(data.makeDTO.month+1)+"</span>월</h2>");
					}else{
						$("#cal_caSubject").html("<h2><span id='cal_year'>"+data.makeDTO.year+"</span>년 "
								+"<span id='cal_month'>"+data.makeDTO.month+"</span>월</h2>");
					}
					
					console.log("cal_click : "+cal_click);
					console.log("시작일 : "+data.makeDTO.startDay);
					
					outCount(outcomeCnt);
					inCount(incomeCnt);
				},
				error: function(error){
					console.log(error);
				}
			});
		});
		
		// 오늘의 날짜가 속한 단위기간 표시하기(css)
		/* function showTerm(){
			$.ajax({
				type: "get",
				url: "./ca_showTerm",
				dataType: "JSON",
				data:{
					calYear: $("#cal_year").html(),
					calMonth: $("#cal_month").html()
				},
				success: function(data){
					console.log("단위기간 css : "+data.goalDTO.goalStart+" / "+data.goalDTO.goalEnd);
					
				},
				error: function(error){
					console.log(error);
				}
			});
		} */

		//디폴트 달력
		var content ="";//달력 테이블에 붙일 컨텐트
        var dayId = 0;//달력에 td 마다 다르게 줄 id 번호
        var calDate = new Date();//오늘의 날짜정보를 담음
        console.log("오늘 : "+calDate);
        console.log(calDate.getMonth()+1);//지금 날짜 기준의 현재 달
        console.log(calDate.getFullYear());//지금 날짜 기준의 현재 해
        console.log(calDate.getDay());//지금 날짜 기준의 현재 요일
        
        $("#cal_year").html(calDate.getFullYear());//화면 중앙에 크게 보이는 년도
        $("#cal_month").html(calDate.getMonth()+1);//화면 중앙에 크게 보이는 달
        
        //이번달의 마지막날
        var lastDay = (new Date(calDate.getFullYear(), calDate.getMonth()+1, 0)).getDate();
        console.log("디폴트 달력 마지막  : "+lastDay);
        
        //디폴트 달력 append로 붙이기
        var cntDay =0;
        for(var i =0;i<=5;i++){
            content += "<tr id=tr"+i+">";
            for(var j=0;j<=6;j++){
                content += "<td class='tdStyle' id='day"+dayId+++"' onclick='dayClick("+cntDay+++")'></td>";
            }
            content += "</tr>";
        }
        
        $("#cal_calendar").append(content);
        
        var day = 1;//달력에 들어갈 일자
        console.log("td 아이디 : "+"day"+calDate.getDay());
        console.log("for문 돌릴 길이 : "+lastDay);
        
        //현재 해, 현재 달에 해당하는 1일의 요일        
		var stFirstDayId = "";
		
		if($("#cal_month").html()<10){
			stFirstDayId = $("#cal_year").html()+"-0"+$("#cal_month").html()+"-01";
		}else{
			stFirstDayId = $("#cal_year").html()+"-"+$("#cal_month").html()+"-01";
		}        
        
		console.log("stFirstDayId : "+stFirstDayId);
		
		var firstDayId = new Date(stFirstDayId).getDay();
        console.log(calDate.getFullYear());
        console.log(calDate.getMonth()+1);
        console.log("1일에 해당할 요일 : "+firstDayId);
        
        var today = calDate.getDate();
        console.log(today);
        var todayId = firstDayId+today-1;
        console.log(todayId);
        $("#day"+todayId+"").css("border","3px solid #6AB72F");
        
        var outcome2 = firstDayId;
        var income2 = firstDayId;
        
        for(var i=0;i<lastDay;i++){ //lastDay 라는 마지막날 만큼을 길이로 사용
            var content = "";
        	content+= "<span style='color:#CC3131' id='outcomeCnt"+outcome2+++"'></span><br/>";
            content+="<span style='color:#2A43B4' id='incomeCnt"+income2+++"'></span>";
        	$("#day"+firstDayId+++"").html(""+day+++"<br/>"+content+""); //적절한 td 에서 시작하여 날짜를 1부터 쭉 입력
        }
        
        if(//달력의 맨 아랫줄에 비어있는 줄 삭제
                $("#day35").html()=="" && $("#day36").html()=="" && $("#day37").html()=="" && 
                $("#day38").html()=="" && $("#day39").html()=="" && $("#day40").html()=="" && 
                $("#day41").html()==""
            ){
                $("#tr5").html("");
                
                for(var i = 0 ; i>34; i++){
                	var dayPlus1 = "#day"+i;
                	var dayPlus2 = $(dayPlus1).val();
/*                 	console.log("비어있는 td의 value : "+dayPlus2); */
                	
                	if(dayPlus2==""){
                		$(dayPlus1).removeAttr("onclick");
                	}
                }
            }
        for(var i = 0 ; i<42; i++){
        	var dayPlus1 = "#day"+i;
        	var dayPlus2 = $(dayPlus1).html();
        	if(dayPlus2==""){
        		$(dayPlus1).removeAttr("onclick");
        	}
        }
		
		// 달력 만들기(전달)
		function cal_makeMinus(data){
			console.log("달력 전달 만들기 시작");
			var day = 0;
			var content = "";
			
			$("#cal_calendar").html("<tr><th>일</th><th>월</th>	<th>화</th>	"
					+ "<th>수</th><th>목</th>	<th>금</th>	<th>토</th></tr>");
			var cntDay =0;
			for(var i=0;i<=5;i++){
				content += "<tr id=tr"+i+" align='center'>";
				for(var j=0;j<=6;j++){
					content += "<td class='tdStyle' id='day"+day+++"' onclick='dayClick("+cntDay+++")'></td>";
				}
				content += "</tr>";
			}
			$("#cal_calendar").append(content);
			console.log("요깅 : "+data.makeDTO.startDay);
			
			// 달력 요일에 맞춰 일 집어넣기
			var tdDateId = data.makeDTO.startDay-1;
			var income3 = data.makeDTO.startDay-1;
			var outcome3 = data.makeDTO.startDay-1;
			
			var length = data.makeDTO.endDay;
			console.log(tdDateId+" : "+length);
			
			var day = 1;
			for(var i=0;i<length;i++){
				var content = "";
				content+= "<span style='color:#CC3131' id='outcomeCnt"+outcome3+++"'></span><br/>";
				content+="<span style='color:#2A43B4' id='incomeCnt"+income3+++"'></span>";
				$("#day"+tdDateId+++"").html(""+day+++"<br/>"+content+""); //적절한 td 에서 시작하여 날짜를 1부터 쭉 입력
			}
			
			if(
				$("#day35").html()=="" && $("#day36").html()=="" && $("#day37").html()=="" &&
				$("#day38").html()=="" && $("#day39").html()=="" && $("#day40").html()=="" &&
				$("#day41").html()==""
			){
				$("#tr5").html("");
			}
		}
		
		
		// 달력 만들기(다음달)
		function cal_makePlus(data){
			console.log("달력 다음달 만들기 시작");
			var day = 0;
			var content = "";
			
			$("#cal_calendar").html("<tr><th>일</th><th>월</th>	<th>화</th>	"
					+ "<th>수</th><th>목</th>	<th>금</th>	<th>토</th></tr>");
			var cntDay =0;
			for(var i=0;i<=5;i++){
				content += "<tr id=tr"+i+" align='center'>";
				for(var j=0;j<=6;j++){
					content += "<td class='tdStyle' id='day"+day+++"' onclick='dayClick("+cntDay+++")'></td>";
				}
				content += "</tr>";
			}
			$("#cal_calendar").append(content);
			console.log("요깅 : "+data.makeDTO.startDay);
			
			// 달력 요일에 맞춰 일 집어넣기
			var tdDateId = data.makeDTO.startDay-1;
			var income3 = data.makeDTO.startDay-1;
			var outcome3 = data.makeDTO.startDay-1;
			
			var length = data.makeDTO.endDay;
			console.log(tdDateId+" : "+length);
			
			var day = 1;
			for(var i=0;i<length;i++){
				var content = "";
				content+= "<span style='color:#CC3131' id='outcomeCnt"+outcome3+++"'></span><br/>";
				content+="<span style='color:#2A43B4' id='incomeCnt"+income3+++"'></span>";
				$("#day"+tdDateId+++"").html(""+day+++"<br/>"+content+""); //적절한 td 에서 시작하여 날짜를 1부터 쭉 입력
			}
			
			if(
				$("#day35").html()=="" && $("#day36").html()=="" && $("#day37").html()=="" &&
				$("#day38").html()=="" && $("#day39").html()=="" && $("#day40").html()=="" &&
				$("#day41").html()==""
			){
				$("#tr5").html("");
				
			}
		}
		
		console.log("==========================절취선==========================");
		
		// 달력에서 지출만 보여주기
		function cal_outcomeShow(){
			console.log("달력 - 지출 토글 클릭");
			outcomeCnt++;
			outCount(outcomeCnt);
			
			if(outcomeCnt>=2){
				outcomeCnt=0;
			}	
			console.log(outcomeCnt);
		}
		
		// 지출 카운트 메소드
		function outCount(outcomeCnt){
			console.log("지출 카운트 메소드 : "+outcomeCnt);
			if(outcomeCnt == 1){
				$.ajax({
					type: "post",
					url: "./ca_outcomeShow",
					dataType: "JSON",
					data: {
						tabIdx : $(".on").val(),
	                	clickYear : $("#cal_year").html(),
	                	clickMonth : $("#cal_month").html()
					},
					success: function(data){
						
						var stFirstDayId = "";
						
						if($("#cal_month").html()<10){
							stFirstDayId = $("#cal_year").html()+"-0"+$("#cal_month").html()+"-01";
						}else{
							stFirstDayId = $("#cal_year").html()+"-"+$("#cal_month").html()+"-01";
						}
						
						console.log("stFirstDayId : "+stFirstDayId);
						
						var firstDayId = new Date(stFirstDayId).getDay();
						
						console.log("아이디 계산");
						console.log(firstDayId);
						console.log("계산끝");
						
						sumOutcome(data);
					},
					error: function(error){
						console.log(error);
					}
				});
			}else{
				for(var i =0;i<=41;i++){
					$("#outcomeCnt"+i+"").html("");
				}
				
			}
		}
		
		//지출 합계를 달력에 표시(디폴트)
		function sumOutcome(data){

			var stFirstDayId2 = "";
			var blank = "";
			
			if($("#cal_month").html()<10){
				stFirstDayId2 = $("#cal_year").html()+"-0"+$("#cal_month").html()+"-01";
			}else{
				stFirstDayId2 = $("#cal_year").html()+"-"+$("#cal_month").html()+"-01";
			}
			
			var firstDayId2 = new Date(stFirstDayId2).getDay();//첫날의 요일
			var sumLastDay = (new Date($("#cal_year").html(), $("#cal_month").html(), 0)).getDate();//해당 년,월의 마지막날
			console.log(firstDayId2+" : "+sumLastDay);
			
			for(var i = 0;i<42;i++){
				$("#outcomeCnt"+i+"").html(blank);
			}
			for(var i=firstDayId2; i<firstDayId2+sumLastDay; i++){
				//console.log(firstDayId2+sumLastDay);
				var sum=0;
				for(var j=0; j<data.clickOutList.length; j++){
					//console.log("맞음");
					if(data.clickOutList[j].showDate == i-firstDayId2+1){
						sum += data.clickOutList[j].iosM;
						$("#outcomeCnt"+i+"").html("- "+sum);
						console.log(sum);
					}
				}
			}
		}
		
		// 달력에서 수입만 보여주기
		function cal_incomeShow(){
			console.log("달력 - 수입 토글 클릭");
			incomeCnt++;
			inCount(incomeCnt);
			
			if(incomeCnt>=5){
				incomeCnt=3;
			}	
			console.log(incomeCnt);
		}	
		//}
		
		// 수입 카운트 메소드 - 토글버튼 실제 실행부분
		function inCount(incomeCnt){
			console.log("수입 카운트 메소드 : "+incomeCnt);
			if(incomeCnt == 4){
				$.ajax({
					type: "post",
					url: "./ca_incomeShow",
					dataType: "JSON",
					data: {
						tabIdx : $(".on").val(),
	                	clickYear : $("#cal_year").html(),
	                	clickMonth : $("#cal_month").html()
					},
					success: function(data){
						
						
						var stFirstDayId = "";
						
						if($("#cal_month").html()<10){
							stFirstDayId = $("#cal_year").html()+"-0"+$("#cal_month").html()+"-01";
						}else{
							stFirstDayId = $("#cal_year").html()+"-"+$("#cal_month").html()+"-01";
						}
						
						console.log("stFirstDayId : "+stFirstDayId);
						
						var firstDayId = new Date(stFirstDayId).getDay();
						
						console.log("아이디 계산");
						console.log(firstDayId);
						console.log("계산끝");
						
						sumIncome(data);
					},
					error: function(error){
						console.log(error);
					}
				});
			}else{
				for(var i =0;i<=41;i++){
					$("#incomeCnt"+i+"").html("");
				}				
			}
		}
		
		//수입 합계를 달력에 표시 얘도 위랑 같은 일
		function sumIncome(data){
			
			var stFirstDayId3 = "";
			
			if($("#cal_month").html()<10){
				stFirstDayId3 = $("#cal_year").html()+"-0"+$("#cal_month").html()+"-01";
			}else{
				stFirstDayId3 = $("#cal_year").html()+"-"+$("#cal_month").html()+"-01";
			}
			
			
			var firstDayId3 = new Date(stFirstDayId3).getDay();
			var sumLastDay2 = (new Date($("#cal_year").html(), $("#cal_month").html(), 0)).getDate();
			console.log(firstDayId3+" : "+sumLastDay2);
			
			for(var i=firstDayId3; i<firstDayId3+sumLastDay2; i++){
				//console.log(firstDayId3+sumLastDay2);
				var sum=0;
				for(var j=0; j<data.clickInList.length; j++){
					//console.log("맞음");
					if(data.clickInList[j].showDate == i-firstDayId3+1){
						sum += data.clickInList[j].iosM;
						$("#incomeCnt"+i+"").html("+ "+sum);
						console.log(sum);
					}
				}
			}
		}
		
		
		// 데이터가 없을 시 append를 한 번만 시키기 위한 flag값
		var ca_flag = false;
		console.log("tab1(1) : "+$("#tab1").val());
		console.log("here : "+cal_click);
		
		
		// 날짜 클릭 시 하얀 배경과 테이블 출력 - 상세내역을 보여주는 팝업 
		function dayClick(cntDay){
			console.log("상세내역 보여주기");
			ca_flag = false;
			console.log("테스트");
			console.log(cntDay);
			
			$("#cal_back").css("display","block");
			$("#cal_spend").css("display","block");
			$("#cal_x").css("display","block");
			console.log("데이터 요청 시작");
			
			var stFirstDayId = "";
			
			if($("#cal_month").html()<10){
				stFirstDayId = $("#cal_year").html()+"-0"+$("#cal_month").html()+"-01";
			}else{
				stFirstDayId = $("#cal_year").html()+"-"+$("#cal_month").html()+"-01";
			}
			
			
			console.log(stFirstDayId);			
			var firstDayId = new Date(stFirstDayId).getDay();
			
			
			console.log("안녕");
			console.log($("#cal_year").html());
			console.log($("#cal_month").html());
			
			console.log("여기요");
			console.log(firstDayId);
			console.log(cntDay-firstDayId+1);

            $.ajax({
                type:"post",
                url:"./ca_app",
                dataType:"JSON",
                data: {
                	tabIdx : $(".on").val(),
                	clickDay : cntDay-firstDayId+1,
                	clickYear : $("#cal_year").html(),
                	clickMonth : $("#cal_month").html()
                },
                success:function(data){
                    console.log(data.ca_outcome);
                    console.log(data.ctgNames);
                    console.log("인덱스 - 수입 : "+data.ca_income);
                    console.log("인덱스 - 지출 : "+data.ca_outcome);
                    /* console.log("data.ca_income[0] : "+data.ca_income[0].iosSubject);
                    console.log("data.ca_income[1] : "+data.ca_income[1].iosSubject); */
                    
                    // 지출, 수입 내역이 모두 없을 때
                    if(data.ca_outcome.length == 0 && data.ca_income.length == 0){
                    	nocomeApp();
                    	console.log("둘 다 없음");
                    // 지출 내역만 있을 때
                    } else if(data.ca_outcome.length != 0 && data.ca_income.length == 0){
                    	outcomeApp(data);
                    	console.log("지출 내역만 있음");
                    // 수입 내역만 있을 때
                    } else if(data.ca_income.length != 0 && data.ca_outcome.length == 0){
                    	incomeApp(data);
                    	console.log("수입 내역만 있음");
                    } else{
                    	allComeApp(data);
                    	console.log("둘 다 있음");
                    }
                }, error:function(error){
                    	console.log(error);
                }
            });
		}
		
		// 닫기 버튼 클릭
		$("#cal_x").click(function(){
			var content = "<tr><th>카테고리</th><th>제목</th><th>금액</th>";
			content+= "<th>메모</th><th>수정</th><th>삭제</th></tr>";
			$("#cal_back").css("display","none");
			$("#cal_spend").css("display","none");
			$("#cal_x").css("display","none");
			$("#cal_table").html(content);
		});
		
		// 메모 닫기 버튼
		$(".cal_x2").click(function(){
			$(".cal_x2").css("display","none");
			$(".cal_memoPop").css("display","none");
			$("#cal_back2").css("display","none");
		});
		
		// 수입 지출 없을 때
		function nocomeApp(){
			console.log("no append 시작");
			console.log(ca_flag);
			
			if(ca_flag == false){
	            var content = "";
		            content+="<tr class='cal_dv'>";
		            content+="<td colspan='6' align='center'>지출 및 수입 내역이 없습니다.<br/>";
		            content+="<a href='calendarAdd.jsp'>지출 및 수입 추가 페이지로 이동</a></td>";
		            content+="</tr>"
	            $("#cal_table").append(content);
		        ca_flag = true;
		        
		        $("#cal_spend").css("height","133px");
			}
		}
		
		// 수입, 지출내역 둘 다 있을 때
		function allComeApp(data){
			console.log("둘 다 append");
			console.log(data.ca_income+" : "+data.ca_outcome);
			var content1 = "";
			var content2 = "";
			 
			for(var i=0;i<data.ca_outcome.length;i++){
				content2+="<tr class='cal_dv'>";
	            content2+="<td align='center'>"+data.ctgNames[data.ca_outcome[i].ctgIdx-1]+"<br/>";
	            content2+="<input type='hidden' value='"+data.ca_outcome[i].iosIdx+"'/></td>";
	            content2+="<td align='center'>"+data.ca_outcome[i].iosSubject+"</td>";
	            content2+="<td align='center' style='color:#CC3131'>"+data.ca_outcome[i].iosM+"</td><br/>";
	            
	         	// 만약 메모가 없을 경우 grayBtn 이미지 출력
	            if(data.ca_outcome[i].iosMemo == null){
	            	// div 클릭 시 memo Popup 출력
	            	console.log("메모가 없을 경우");
	            	content2 += "<td align='center'><img class='cal_memoBtn' width='50px' height='50px' src='./imagefolder/calGrayBtn.png'/></td>";
	            	
        		// 만약 메모가 있을 경우 greenBtn 이미지 출력
	            }else {
	            	content2 += "<td align='center'><div onclick=addMemoPop('"+data.ca_outcome[i].iosMemo+"')>";
	            	
	            	content2 += "<img class='cal_memoBtn' width='50px' height='50px' src='./imagefolder/calGreenBtn.png'/></div></td>";
	            	console.log("메모가 있을 경우");
	            }
	            content2+="<td align='center'><a href='./ca_update?iosIdx="+data.ca_outcome[i].iosIdx+"'>수정</a></td>";
				content2+="<td align='center'><a href='./ca_delete?iosIdx="+data.ca_outcome[i].iosIdx+"'>삭제</a></td>";
				content2+="</tr>";
			}
			$("#cal_table").append(content2);
			 
			
			for(var i=0;i<data.ca_income.length;i++){
				content1+="<tr class='cal_dv'>";
	            content1+="<td align='center'>"+data.ctgNames[data.ca_income[i].ctgIdx-1]+"<br/>";
	            content1+="<input type='hidden' value='"+data.ca_income[i].iosIdx+"'/></td>";
	            content1+="<td align='center'>"+data.ca_income[i].iosSubject+"</td>";
	            content1+="<td align='center' style='color:#2A43B4'>"+data.ca_income[i].iosM+"</td><br/>";
	            
	         	// 만약 메모가 없을 경우 grayBtn 이미지 출력
	            if(data.ca_income[i].iosMemo == null){
	            	// div 클릭 시 memo Popup 출력
	            	console.log("메모가 없을 경우");
	            	content1 += "<td align='center'><img class='cal_memoBtn' width='50px' height='50px' src='./imagefolder/calGrayBtn.png'/></td>";
	            	
        		// 만약 메모가 있을 경우 greenBtn 이미지 출력
	            }else {
	            	content1 += "<td align='center'><div onclick=addMemoPop('"+data.ca_income[i].iosMemo+"')>";
	            	content1 += "<img class='cal_memoBtn' width='50px' height='50px' src='./imagefolder/calGreenBtn.png'/></div></td>";
	            	console.log("메모가 있을 경우");
	            }
	            content1+="<td align='center'><a href='./ca_update?iosIdx="+data.ca_income[i].iosIdx+"'>수정</a></td>";
				content1+="<td align='center'><a href='./ca_delete?iosIdx="+data.ca_income[i].iosIdx+"'>삭제</a></td>";
				content1+="</tr>";
			}
			$("#cal_table").append(content1);
			
			if(data.length == 1){
     			$("#cal_spend").css("height","133px");
     		}else{
     			$("#cal_spend").css("height","233px");
     		}
		}
		
		// 수입 내역만 있을 때
		function incomeApp(data){
			console.log(data.ca_income.length);
			console.log("수입 append 시작");
			 var content = "";
			 
			 for(var i=0;i<data.ca_income.length;i++){
				content+="<tr class='cal_dv'>";
	            content+="<td align='center'>"+data.ctgNames[data.ca_income[i].ctgIdx-1]+"<br/><input type='hidden' value='"+data.ca_income[i].iosIdx+"'/></td>";
	            content+="<td align='center'>"+data.ca_income[i].iosSubject+"</td>";
	            content+="<td align='center'>"+data.ca_income[i].iosM+"</td>";
	            
	        	// 만약 메모가 없을 경우 grayBtn 이미지 출력
	            if(data.ca_income[i].iosMemo == null){
	            	// div 클릭 시 memo Popup 출력
	            	console.log("메모가 없을 경우");
	            	content += "<td align='center'><img class='cal_memoBtn' width='50px' height='50px' src='./imagefolder/calGrayBtn.png'/></td>";
	            	
         		// 만약 메모가 있을 경우 greenBtn 이미지 출력
	            }else {
	            	content += "<td align='center'><div onclick=addMemoPop('"+data.ca_income[i].iosMemo+"')>";
	            	
	            	content += "<img class='cal_memoBtn' width='50px' height='50px' src='./imagefolder/calGreenBtn.png'/></div></td>";
	            	console.log("메모가 있을 경우");
	            }
	            content+="<td align='center'><a href='./ca_update?iosIdx="+data.ca_income[i].iosIdx+"'>수정</a></td>";
				content+="<td align='center'><a href='./ca_delete?iosIdx="+data.ca_income[i].iosIdx+"'>삭제</a></td>";
				content+="</tr>";
			 }
			 $("#cal_table").append(content);
			 
			if(data.ca_income.length == 1){
      			$("#cal_spend").css("height","133px");
      		}else{
      			$("#cal_spend").css("height","233px");
      		}
		}
		
		// 지출 내역만 있을 때
		function outcomeApp(data){
			console.log(data.ca_outcome);
			console.log("지출 append 시작");
			 var content = "";
			 for(var i=0;i<data.ca_outcome.length;i++){
				content+="<tr class='cal_dv'>";
	            content+="<td align='center'>"+data.ctgNames[data.ca_outcome[i].ctgIdx-1]+"<br/><input type='hidden' value='"+data.ca_outcome[i].iosIdx+"'/></td>";
	            content+="<td align='center'>"+data.ca_outcome[i].iosSubject+"</td>";
	            content+="<td align='center'>"+data.ca_outcome[i].iosM+"</td>";
	            
	        	// 만약 메모가 없을 경우 grayBtn 이미지 출력
	            if(data.ca_outcome[i].iosMemo == null){
	            	// div 클릭 시 memo Popup 출력
	            	console.log("메모가 없을 경우");
	            	content += "<td align='center'>";
	            	content += "<img class='cal_memoBtn' width='50px' height='50px' src='./imagefolder/calGrayBtn.png'/></td>";
	            	
         		// 만약 메모가 있을 경우 greenBtn 이미지 출력
	            }else {
	            	content += "<td align='center'><div onclick=addMemoPop('"+data.ca_outcome[i].iosMemo+"')>";
	            	content += "<img class='cal_memoBtn' width='50px' height='50px' src='./imagefolder/calGreenBtn.png'/></div></td>";
	            	console.log("메모가 있을 경우");
	            }
	            content+="<td align='center'><a href='./ca_update?iosIdx="+data.ca_outcome[i].iosIdx+"'>수정</a></td>";
				content+="<td align='center'><a href='./ca_delete?iosIdx="+data.ca_outcome[i].iosIdx+"'>삭제</a></td>";
				content+="</tr>";
			 }
			 $("#cal_table").append(content);
			
			if(data.ca_outcome.length == 1){
      			$("#cal_spend").css("height","133px");
      		}else{
      			$("#cal_spend").css("height","233px");
      		}
		}
		
		// 수입 메모 팝업 출력
		function addMemoPop(incomedata){
			$(".cal_memoPop").css("display", "block");
			$("#cal_back2").css("display", "block");
			$(".cal_x2").css("display", "block");
			$(".cal_memoPop").html("<p>당신의 메모</p><hr/><br/>"+incomedata);
			$(".cal_x2").html("<img src ='./imagefolder/letter-x2.png' height='20' width='20'/>");
			$("td").unbind("hover");
			console.log("수입 메모 팝업 출력");
		}
		
		// 지출 메모 팝업 출력
		function spendMemoPop(outcomedata){
			$(".cal_memoPop").css("display", "block");
			$("#cal_back2").css("display", "block");
			$(".cal_x2").css("display", "block");
			$(".cal_memoPop").html("<p>당신의 메모</p><hr/><br/>"+outcomedata+"<div class='cal_x2'><img class='cal_x2img' src ='./imagefolder/letter-x2.png' height='20' width='20'/></div>");
			console.log("지출 메모 팝업 출력");
		}
		
		// 지출 & 수입 내역 삭제
		var success1 = "${success1}";
		if(success1 == 1){
			alert("삭제에 성공하였습니다.");
		}else if(success1 == ""){
			
		}else{
			alert("삭제에 실패하였습니다.");
		}
	</script>
</html>