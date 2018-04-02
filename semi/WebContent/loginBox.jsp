<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
	<head>
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<link rel="stylesheet" href="css/bootstrap.css">
	<link href="https://fonts.googleapis.com/css?family=Shrikhand" rel="stylesheet">
	<script  src="js/bootstrap.js"></script>
	<style>
		@import url(https://fonts.googleapis.com/css?family=Quicksand);
		@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);
	
		body{
			font-family: 'Noto Sans KR', sans-serif;
			margin: 0;
		}
		
		/* a링크 스타일 */
		a{
            font-family: 'Quicksand', sans-serif;
            font-size: 15px;
        }
        
       	a:link{color:#585858; text-decoration: none;}
		a:visited{color:#585858; text-decoration: none;}
		a:hover{color:#B40404; text-decoration: none;}
		a:active{color:#585858; text-decoration: none;}
		
		/* 환영합니다 xx님, 마이페이지 연결하는 셀렉트 부분 */
		.custom-select{
			font-family: 'Noto Sans KR', sans-serif;
			font-weight: 300;
			position: absolute;
			width: 150px;
			height: 38px;
			right: 9%;
			top: 11px;
			border-radius: 5px;
			border-color: ;
			padding: 10px 10px;
			font-size: 12px;
			color: #6E6E6E; 
		}
		
		/*총괄하는 div*/
		#loginBoxMain{
			width : 100%;
			height : 90px;
			background-color: white;
			border-bottom: 1px solid #e8e5e5;
			position : absolute;
			margin: 0;
			top : 0%;
			z-index: 10;
		}
		
		/* 로고 */
		#loginBoximg{
			font-family: 'Shrikhand', cursive;
			font-size: 27pt;
			color: black;
			position: absolute;
			top : 4%;
			left : 43.5%;
		}
		
		#loginBoximg:hover{
			cursor: pointer;
		}
		
		/* 사이드메뉴 */
		#hiSide{
			position: absolute;
		    display: inline-block;
		    float: left;
		    top: 13px;
		    left: 13px;
		}

		/* 로그아웃 */
		#loginBox2{
			position :absolute;
			float : left;
			top: 20px;
			right : 4%;
		} 
		
		/* 드롭다운 될 메뉴들의 위치 */
		.topBox {
		    position: relative;
		    display: inline-block;
		    float : left;
		    top: 18%;
		    left :1%;
		    width : 100%;
		    height : 80px;
		}

		/*관리자 리스트 부분*/
		#adminList{
			display: none;
		}
			
			/* The side navigation menu */
			.sidenav {
				height: 100%; /* 100% Full-height */
				width: 0; /* 0 width - change this with JavaScript */
				position: fixed; /* Stay in place */
				z-index: 1; /* Stay on top */
				top: 0; /* Stay at the top */
				left: 0;
				background-color: #111; /* Black*/
				overflow-x: hidden; /* Disable horizontal scroll */
				padding-top: 60px; /* Place content 60px from the top */
				transition: 0.5s; /* 0.5 second transition effect to slide in the sidenav */
			}

			/* The navigation menu links */
			.sidenav a {
				font-family: 'Noto Sans KR', sans-serif;
			    padding: 8px 8px 8px 35px;
			    text-decoration: none;
			    font-size: 20px;
			    color: #818181;
			    display: block;
			    transition: 0.3s;
			}

			/* When you mouse over the navigation links, change their color */
			.sidenav a:hover {
			    color: #f1f1f1;
			}
			
			/* Position and style the close button (top right corner) */
			.sidenav .closebtn {
			    position: absolute;
			    top: 0;
			    right: 25px;
			    font-size: 36px;
			    margin-left: 50px;
			}
			
			/* On smaller screens, where height is less than 450px,
			change the style of the sidenav (less padding and a smaller font size) */
			@media screen and (max-height: 450px) {
			    .sidenav {padding-top: 15px;}
			    .sidenav a {font-size: 18px;}
			}
			/* 탭 */
			.nav-tabs {
  				border-bottom: 1px solid #ddd;
  				position: absolute;
  				top: 54%;
  				left: 7%;
			}

			.nav-tabs .nav-item {
			  	margin-bottom: -1px;
			}
			
			.nav-tabs .nav-link {
				border: 1px solid transparent;
				border-top-left-radius: 0.25rem;
				border-top-right-radius: 0.25rem;
			}
			
			.nav-tabs .nav-link:hover {
				border-color: #ffffff #ffffff #d8d8d8 #ffffff;
			}
			
			/* .nav-tabs .nav-link.disabled {
				color: #868e96;
				background-color: transparent;
				border-color: transparent;
			} 
			*/
			
			.nav-tabs .nav-link.active,
			.nav-tabs .nav-item.show .nav-link {
				color: #495057;
				background-color: #fff;
				border-color: #ddd #ddd #fff;
			}

			#li2{
				display: none;
			}
			#li3{
				display: none;
			}
	</style>
	
</head>
	<body>
		<div id="loginBoxMain">
			<div class="topBox">
				<div id="mySidenav" class="sidenav">
  					<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
					<a href="calendar.jsp">달력</a>
					<a href="longTermPlan.jsp">장기 계획</a>
					<a href="statistics.jsp">통계</a>
					<a href="tapEditControl1.jsp">탭 설정</a>
					<a href="tapEditControl2.jsp">탭 추가 및 삭제</a>
					<a href="adminList.jsp" id="adminList">관리자용 회원 리스트</a>
				</div>
	
				<!-- Use any element to open the sidenav -->
				<span id="hiSide" onclick="openNav()"><img src="./imagefolder/sideMenu.png" height="27px" width="32px"/></span>
			
			  	<div id="loginBoximg" onclick="location.href='main.jsp'">money save</div>
			  	<div class="form-group">
					<select class="custom-select" onchange="location.href=this.value">
					    <option selected=""  id="welcome"></option>
					    <option value="./myPage.jsp">마이페이지</option>
				    </select>
				</div>
			  	<div id="loginBox2"></div>
			  	 <!-- 탭 -->
			</div>
			<ul class="nav nav-tabs">
	        <li class="nav-item on" value="1" id="li1">
	            <a class="nav-link active" data-toggle="tab" href="#" id="name1">Tab 1</a>
	        </li>
	        <li class="nav-item" value="0" id="li2">
	        	<a class="nav-link " data-toggle="tab" href="#" id="name2">Tab 2</a>
	        </li>
	        <li class="nav-item" value="0" id="li3">
	        	<a class="nav-link " data-toggle="tab" href="#" id="name3">Tab 3</a>
	        </li>
	        <li class="nav-item" value="10" id="li4">
	        	<a class="nav-link " data-toggle="tab" href="#" id="add">New Tab +</a>
	        </li>
	   	</ul>
		</div>
		
		
		
	</body>
	<script>
		
		$(document).ready(function(){
			$.ajax({
				type:"post",
				url:"./adminconfirm",
				dataType:"json",
				success:function(data){
					console.log(data.result);
					if(data.result==1){//관리자 계정
						$("#adminList").css("display","block");
						var content1 = "관리자 계정입니다";
						var content2 = "<a href='./logout'>LOGOUT</a>";
						document.getElementById("welcome").innerHTML=content1;
						document.getElementById("loginBox2").innerHTML=content2;
					}else if(data.result==0){//일반계정
						var content1 = loginId+"님 반갑습니다.";
						var content2 = "<a href='./logout'>LOGOUT</a>";
						document.getElementById("welcome").innerHTML=content1;
						document.getElementById("loginBox2").innerHTML=content2;		
						ajax(1);
						tabchk();
						console.log("페이지값 : "+$(".page").val());
					}
					//아작스한번 더쓰는 메소드
					
				},
				error:function(error){
					console.log(error);
				}
			});
		});
		
		//탭 띄우기
		function tabchk(){
			$.ajax({
				type:"post",
				url:"./tb_check",
				dataType:"JSON",
				success:function(obj){
					/* console.log(obj.list);
					console.log(obj.list[0].tabIdx);
					console.log(obj.list[1].tabIdx); */
					console.log("탭의 갯수 : "+obj.list.length);
					if(obj.list.length ==1){
						$("#name1").html(obj.list[0].tabSubject);
					}else if(obj.list.length ==2){
						if(obj.list[1].tabIdx == 2){
							$("#name1").html(obj.list[0].tabSubject);
							$("#li2").attr("value","2");
							$("#name2").html(obj.list[1].tabSubject);
							$("#li2").css("display","inline");
							
						}else if(obj.list[1].tabIdx==3){
							$("#name1").html(obj.list[0].tabSubject);
							$("#li3").attr("value","3");
							$("#name3").html(obj.list[1].tabSubject);
							$("#li3").css("display","inline");	
						}
						
					}else if(obj.list.length ==3){
						$("#name1").html(obj.list[0].tabSubject);
						$("#li2").attr("value","2");
						$("#name2").html(obj.list[1].tabSubject);
						$("#li2").css("display","inline");
						$("#li3").attr("value","3");
						$("#name3").html(obj.list[2].tabSubject);
						$("#li3").css("display","inline");	
					}
				},
				error:function(e){
					console.log(e);
				}
			});
		}
		
		//탭 구분하기
		function ajax(idx) {
			$.ajax({
				type:"post",
				url:"./tb_list",
				data:{
					tabIdx:idx,
					pageInfo:$(".page").val()
					//페이지정보(달력인지 메인인지 등등)
				},
				dataType:"JSON",
				success:function tabPrint(list){
					if($(".page").val()=="main"){
						if($(".on").val()==1){	//메인페이지에서 출력할것
							$("#name1").html(list.list[0].tabSubject);
						}else if($(".on").val()==10){
							alert("'탭 추가 및 삭제' 창으로 이동합니다.");
							location.href="tapEditControl2.jsp";
						}else if($(".on").val()==0){
							//탭이 2번,3번 구분
						}
					}else if($(".page").val()=="cal"){		//달력 페이지에서 실행할거
						outCount(outcomeCnt);
					}else if($(".page").val()=="calOption"){
							$("#calEdit").val($(".on").val());
					}else if($(".page").val()=="stat"){	//통계 페이지에서 실행할거
						
					}else if($(".page").val()=="tab"){	//탭 페이지에서 실행할거
						if(list.list[0].tabIdx==1){
							$("#name1").html(list.list[0].tabSubject);
							$("#tb_goalLimitM").val(list.list[0].goalLimitM);
			    	 		$("#tb_tabSubject").val(list.list[0].tabSubject);
			    	 		$("#tb_goalSubject").val(list.list[0].goalSubject);
			    	 		$("#tb_startyear").val(list.list[0].statrtYear);
			    	 		$("#tb_startmonth").val(list.list[0].statrtMonth);
			    	 		$("#tb_startday").val(list.list[0].statrtDay);
			    	 		$("#tb_endyear").val(list.list[0].endtYear);
			    	 		$("#tb_endmonth").val(list.list[0].endMonth);
			    	 		$("#tb_endday").val(list.list[0].endDay);
						}else if(list.list[0].tabIdx==2){
							$("#tb_goalLimitM").val(list.list[0].goalLimitM);
			    	 		$("#tb_tabSubject").val(list.list[0].tabSubject);
			    	 		$("#tb_goalSubject").val(list.list[0].goalSubject);
			    	 		$("#tb_startyear").val(list.list[0].statrtYear);
			    	 		$("#tb_startmonth").val(list.list[0].statrtMonth);
			    	 		$("#tb_startday").val(list.list[0].statrtDay);
			    	 		$("#tb_endyear").val(list.list[0].endtYear);
			    	 		$("#tb_endmonth").val(list.list[0].endMonth);
			    	 		$("#tb_endday").val(list.list[0].endDay);
						}else if(list.list[0].tabIdx==3){
							$("#tb_goalLimitM").val(list.list[0].goalLimitM);
			    	 		$("#tb_tabSubject").val(list.list[0].tabSubject);
			    	 		$("#tb_goalSubject").val(list.list[0].goalSubject);
			    	 		$("#tb_startyear").val(list.list[0].statrtYear);
			    	 		$("#tb_startmonth").val(list.list[0].statrtMonth);
			    	 		$("#tb_startday").val(list.list[0].statrtDay);
			    	 		$("#tb_endyear").val(list.list[0].endtYear);
			    	 		$("#tb_endmonth").val(list.list[0].endMonth);
			    	 		$("#tb_endday").val(list.list[0].endDay);
						}else{
							/* $("#tb_goalLimitM").val("");
			    	 		$("#tb_tabSubject").val("");
			    	 		$("#tb_goalSubject").val(""); */
			    	 		alert("'탭 추가 및 삭제' 창으로 이동합니다.");
							location.href="tapEditControl2.jsp";
						}
					}
				},error:function(e){
					console.log(e);
			}
				
			});
			
		}
		//탭 부분
		$( ".nav-tabs>li>a" ).click(function() {
	        $(this).parent().addClass("on").siblings().removeClass("on");
	        return false;
	    });
		
		$("a").click(function(){
			console.log("탭체크시 선택된 on클래스의 값 : " +$(".on").val());
			ajax($(".on").val());
			tabchk();
			
		});
		
		var loginId="${sessionScope.loginId}";
		if(loginId ==""){
			alert("로그인이 필요한 서비스입니다.");
			location.href="index.jsp";	
		}

		
		
		// 사이드바
		/* Set the width of the side navigation to 250px */
		function openNav() {
		    document.getElementById("mySidenav").style.width = "300px";
		}
		
		/* Set the width of the side navigation to 0 */
		function closeNav() {
		    document.getElementById("mySidenav").style.width = "0";
		}
		
		
	</script>
</html>