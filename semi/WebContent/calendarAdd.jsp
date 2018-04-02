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
			
		body {
    		font-family: 'Noto Sans KR', sans-serif;
    		color: #616161;
    		font-size : 16px;
    		
		}
        	#cal_addButton1, #cal_addButton2, #cal_addButton3{
        		border: 1px solid black;
        		float : left;
        		margin: 1px;
        		text-align: center;
        		padding: 8px;
    			width: 80px;
    			height: 40px;
        	}
        	
        	
        	/*내용을 밑으로 보내기 위한 div*/
        	#Content{
        		clear:left;
        	}
        	
        	#cal_addCategorySpan{
				border: 1px solid black;
				width: 130px;
				height: 30px;
				background-color: orange;
			}
        	
        	#cal_addBack{
        		position:absolute; 
        		width: 100%;
        		height: 100%;
        		background-color: black;
        		opacity: 0.2;
        		z-index: 3;
        	}
        	
        	#cal_addPop{
        		z-index: 5;
        		position: absolute;
        		width: 600px;
        		height: 300px;
        		background-color: white;
        		left: 100px;
        		top: 100px;
        	}
        	
        	#cal_addBack, #cal_addPop{
        		display: none;
        	}
        	
        	table, td{
        		border: 1px solid black;
        		border-collapse: collapse;
        		padding: 5px 10px;
        	}
        	textarea{
        		resize: none;
        	}
        	#cal_longTermSpan{
				border: 1px solid black;
				width: 130px;
				height: 30px;
				background-color: orange;
				
        	}
        	.cal_longTermMsg{
        		display: none;
        	}
        	
        	#longBarBack{
        		
        		background-color: yellowgreen;
        		width: 400px;
        		height: 20px;
        	}
        	#longBar{
        		background-color: green;
        		width: 80%;
        		height: 20px;
        	}
        	#longInfo{
        		border:1px solid black;
        		width: 150px;
        		height: 100px;
        	}
        	progress{
				background-color: gray;
				border:0;
				height:50px;
				width : 700px;
				border-radius:90px;
			}
			
			.egg{
				position: absolute;
				top : 30%;
				left : 50%;
				transform:translateX(-50%);
			}
			.button:hover{
                background-color: #F0F0EF;
                border: 1px solid #B9B8B8;
                border-radius: 3px;
            }
            #cal_addBtn, #cal_addCancelBtn{
            	font-family: 'Jeju Myeongjo', serif;
	            background-color: white;
	            border: 1px solid #B9B8B8;
	        /* 버튼 안의 텍스트의 색 */
	            color: #6E6E6E;
	            text-align: center;
	            padding: 6px 12px;
	            font-size: 14px;
	            border-radius: 3px;
            }
            .buttons{
            	position: absolute;
            	top : 17%;
            	left : 50%;
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
            #cal_addBtn2{
				display: none;
			}
			.btn{
				position: absolute;
            	top : 76%;
            	left : 50%;
            	transform : translateX(-50%);
			}
        </style>
    </head>
   <body>
    	<jsp:include page="loginBox.jsp"></jsp:include>
		<div id="cal_addBack"></div>
		<div id="cal_addPop">
			
			<div id="cal_addPoptitle"></div>
			
			<table id="cal_addPopList"></table>
			
			<div id="cal_longPopList"></div>
			<div id="cal_longPopBtn"></div>
			
			<br/>
			<a href='#' onclick='cal_addPopClose()'>취소</a>
		</div>
		
		<div class="buttons">
		    <div id="cal_addButton1">지출</div>
	 	   <div id="cal_addButton2">수입</div>
	 	   <div id="cal_addButton3">저축</div>
    	</div>	
    
    	<form id="calAddForm" action="./ca_upCompl" method="post">
    		<input type="hidden" value="1" name="calTabIdx" id="calEdit"/>
    		<input type="hidden" value="calOption" class="page"/>
		
    		<input id="cal_addCategoryVal" type="hidden" name="cal_addCtgSel1" value="0"/>
    		<input id="cal_addCtgIdx" type="hidden" name="cal_addCtgIdx1" value="0"/>
    		<input id="cal_addLongIdx" type="hidden" value="0"/>
		    <div id="Content" class="egg">
		    
			    <div id="cal_buttonContent">
			    	<select class="notLongterm" id="cal_addYear" name ="cal_addYear1" onChange="goalFind()">
			    		<option value="2017">2017</option>
			    		<option value="2018" selected>2018</option>
						<option value="2019">2019</option>
						<option value="2020">2020</option>
						<option value="2021">2021</option>
						<option value="2022">2022</option>
			    	</select>
			    	
			    	<select class="notLongterm" id=cal_addMonth name="cal_addMonth1" onChange="cal_createDate()">
			    		<option value="01">1월</option>
			    		<option value="02">2월</option>
			    		<option value="03">3월</option>
			    		<option value="04">4월</option>
			    		<option value="05">5월</option>
			    		<option value="06">6월</option>
			    		<option value="07">7월</option>
			    		<option value="08">8월</option>
			    		<option value="09">9월</option>
			    		<option value="10">10월</option>
			    		<option value="11">11월</option>
			    		<option value="12">12월</option>
			    	</select>
			    	
			    	<select class="notLongterm" id=cal_addDate name="cal_addDate1" onChange="goalFind()"></select>
			    	<br/>
			    	<span id="cal_goalShow"></span>
			    	
			    	
			    	<br/><br/><br/><br/>
			    	<textarea class="notLongterm" rows="1" cols="40" name="cal_addSubject1" placeholder="제목을 입력해주세요."></textarea>
			    	<br/><br/>
			    	<textarea rows="1" cols="40" name="cal_addIosM1" placeholder="금액을 입력해주세요."></textarea>
			    	<br/><br/>
			    	<span class="cal_categorySpans" id="cal_addCategorySpan">카테고리</span>
			    	<span class="cal_categorySpans" id="cal_pickedCtg">카테고리를 선택해주세요.</span>
			    	<span class="cal_longTermMsg" id="cal_longTermSpan">장기계획 그래프</span>
			    	<span class="cal_longTermMsg">장기계획 그래프를 선택해주세요.</span>
			    	
			    	
			    	<br/><br/>
			    	<textarea class="notLongterm" rows="5" cols="40" name="cal_addMemo1" placeholder="메모 내용을 입력해주세요."></textarea>
			    </div>
			    
			</div>
		    <div class="btn">
				<input id="cal_addBtn1" class="button" type="button" value="확인1"/>
				<input id="cal_addBtn2" class="button" type="button" value="확인2"/>
				<input id="cal_addCancelBtn" class="button" type="button" onclick="location.href='./calendar.jsp'" value="취소"/>
			</div>
	    </form>
    </body>
    <script>
	    var cal_categoryCnt = 0;
	    
	    if(cal_categoryCnt == 0){
	    	$("#cal_addButton1").css("background-color","red");
	    	$("#cal_addButton2").css("background-color","white");
	    	$("#cal_addButton3").css("background-color","white");
	    }else if(cal_categoryCnt == 1){
	    	$("#cal_addButton1").css("background-color","white");
	    	$("#cal_addButton2").css("background-color","yellow");
	    	$("#cal_addButton3").css("background-color","white");
	    }else{
	    	$("#cal_addButton1").css("background-color","white");
	    	$("#cal_addButton2").css("background-color","white");
	    	$("#cal_addButton3").css("background-color","green");
	    }
	    $("#cal_addCategoryVal").val(cal_categoryCnt);
	    
	    $("#cal_addButton1").click(function() {
	    	cal_categoryCnt =0;
	    	
	        if(cal_categoryCnt == 0){
	        	$("#cal_addButton1").css("background-color","red");
	        	$("#cal_addButton2").css("background-color","white");
	        	$("#cal_addButton3").css("background-color","white");
	        }else if(cal_categoryCnt ==1){
	        	$("#cal_addButton1").css("background-color","white");
	        	$("#cal_addButton2").css("background-color","yellow");
	        	$("#cal_addButton3").css("background-color","white");
	        }else{
	        	$("#cal_addButton1").css("background-color","white");
	        	$("#cal_addButton2").css("background-color","white");
	        	$("#cal_addButton3").css("background-color","green");
	        }
	        
	        $("#cal_addCategoryVal").val(cal_categoryCnt);
	        console.log("카테고리 히든 값 : "+$("#cal_addCategoryVal").val());
	        $("#cal_pickedCtg").html("카테고리를 다시 선택해주세요.");
	        $(".cal_categorySpans").css("display", "inline");
	        $(".cal_longTermMsg").css("display", "none");
	        $("#cal_addBtn1").css("display", "inline");//확인1 버튼 보이게하기
	        $("#cal_addBtn2").css("display", "none");//확인2 버튼 안보이게하기
	        $(".notLongterm ").css("display", "inline");//날짜,제목,메모 보이게 하기
		});
	    
	    $("#cal_addButton2").click(function() {
	    	cal_categoryCnt =1;
	    	console.log("cal_addButton2 클릭 : 1");
	    	
	        if(cal_categoryCnt == 0){
	        	$("#cal_addButton1").css("background-color","red");
	        	$("#cal_addButton2").css("background-color","white");
	        	$("#cal_addButton3").css("background-color","white");
	        }else if(cal_categoryCnt ==1){
	        	$("#cal_addButton1").css("background-color","white");
	        	$("#cal_addButton2").css("background-color","yellow");
	        	$("#cal_addButton3").css("background-color","white");
	        }else{
	        	$("#cal_addButton1").css("background-color","white");
	        	$("#cal_addButton2").css("background-color","white");
	        	$("#cal_addButton3").css("background-color","green");
	        }
	        
	        $("#cal_addCategoryVal").val(cal_categoryCnt);
	        console.log("카테고리 히든 값 : "+$("#cal_addCategoryVal").val());
	        $("#cal_pickedCtg").html("카테고리를 다시 선택해주세요.");
	        $(".cal_categorySpans").css("display", "inline");
	        $(".cal_longTermMsg").css("display", "none");
	        $("#cal_addBtn1").css("display", "inline");//확인1 버튼 보이게하기
	    	$("#cal_addBtn2").css("display", "none");//확인2 버튼 안보이게하기
	    	$(".notLongterm ").css("display", "inline");//날짜,제목,메모 보이게 하기
		});
	    
	    $("#cal_addButton3").click(function() {
	    	cal_categoryCnt =2;
	    	
	        if(cal_categoryCnt == 0){
	        	$("#cal_addButton1").css("background-color","red");
	        	$("#cal_addButton2").css("background-color","white");
	        	$("#cal_addButton3").css("background-color","white");
	        }else if(cal_categoryCnt ==1){
	        	$("#cal_addButton1").css("background-color","white");
	        	$("#cal_addButton2").css("background-color","yellow");
	        	$("#cal_addButton3").css("background-color","white");
	        }else{
	        	$("#cal_addButton1").css("background-color","white");
	        	$("#cal_addButton2").css("background-color","white");
	        	$("#cal_addButton3").css("background-color","green");
	        }
	        
	        $("#cal_addCategoryVal").val(cal_categoryCnt);
	        console.log("카테고리 히든 값 : "+$("#cal_addCategoryVal").val());
	        $("#cal_pickedCtg").html("카테고리를 다시 선택해주세요.");
	        $(".cal_categorySpans").css("display", "none");
	        $(".cal_longTermMsg").css("display", "inline");
	          
	        $("#cal_addBtn1").css("display", "none");//확인1 버튼 안보이게하기
	    	$("#cal_addBtn2").css("display", "inline");//확인2 버튼 보이게하기
	    	$(".notLongterm ").css("display", "none");//날짜,제목,메모 안보이게 하기
		});
	    
	    
	    //데이터 유효성검사 - 확인 버튼1
	    $("#cal_addBtn1").click(function(){

		    	if($("textarea[name='cal_addSubject1']").val() ==""){
		    		alert("제목을 입력하세요.");
		    	}else if($("textarea[name='cal_addIosM1']").val() ==""){
		    		alert("금액을 입력하세요.");
		    	}else if($("#cal_addCtgIdx").val() == 0){
		    		alert("카테고리를 선택하세요.");
		    	}else{
		    			$("#calAddForm").submit();
		    	}
		    	
	    }); 
	    
	    //데이터 유효성검사 - 확인 버튼2
	    $("#cal_addBtn2").click(function(){

		    	if($("textarea[name='cal_addIosM1']").val() ==""){
		    		alert("금액을 입력하세요.");
		    	}else if($("#cal_addCtgIdx").val() == 0){
		    		alert("장기계획을 선택하세요.");
		    	}else{
		    			location.href="./ca_upCompl2?longIdx='"+$("#cal_addLongIdx").val()+"'&longStackM='"+$("input[name=cal_addIosM1]").val()+"'";
		    	}
		    	
	    }); 
	    
	    
	    //사용자가 입력한 카테고리 데이터를 지출/수입에 맞게 팝업으로 보냄
	    $("#cal_addCategorySpan").click(function() {
	    	console.log($("#cal_addCategoryVal").val());
	    	
			$.ajax({
				type:"post",
				url:"./ca_addCa",
				data:{
					cal_addCategory:$("#cal_addCategoryVal").val()
				},
				dataType:"json",
				success:function(data){
					console.log(data);
					
					cal_spandCatPop(data.categoryList);
				},
				error:function(error){
					console.log(error);
				}
			});
		});
	    
	    //팝업창 카테고리 테이블 만들기
	    function cal_spandCatPop(categoryList){
	    	
	    	//팝업창 띄우기
	    	$("#cal_addBack").css("display","block");
	    	$("#cal_addPop").css("display","block");
	    	
	    	
	    	var cal_content = "";
	    	$("#cal_longPopList").html(cal_content);
	    	//지출 영역의 카테고리를 선택하면 지출에 관련된 카테고리만 표시한다
	    	if($("#cal_addCategoryVal").val()==0){
	    		$("#cal_addPoptitle").html("<h3>지출 카테고리</h3>");
	    		
	    		cal_content += "<tr>";
	    		for(var i =0;i<6;i++){
	    			var ctgSub = categoryList[i].ctgSub+"";
	        		cal_content += "<td id='cal_ctxName"+i+"' onclick='cal_ctgPick("+i+")'>"+categoryList[i].ctgSub+"</td>";
	    		}
	    		cal_content += "</tr>";
	    		
	    		cal_content += "<tr>";
	    		for(var i =6;i<12;i++){
	        		cal_content += "<td id='cal_ctxName"+i+"' onclick='cal_ctgPick("+i+")'>"+categoryList[i].ctgSub+"</td>";
	    		}
	    		cal_content += "</tr>";
	    		
	    	}else{//수입 영역의 카테고리를 선택하면 수입에 관련된 카테고리만 표시한다
	    		$("#cal_addPoptitle").html("<h3>수입 카테고리</h3>");
	    		
	    		cal_content += "<tr>";
	    		for(var i =0;i<3;i++){
	        		cal_content += "<td id='cal_ctxName"+i+"' onclick='cal_ctgPick("+i+")'>"+categoryList[i].ctgSub+"</td>";
	    		}
	    		cal_content += "</tr>";	
	    	}
	
	    	$("#cal_addPopList").append(cal_content);
	    }
	    
	    //팝업창 닫기
	    function cal_addPopClose(){
	    	var cal_content = "";
	    	$("#cal_addBack").css("display","none");
	    	$("#cal_addPop").css("display","none");
	    	$("#cal_addPopList").html(cal_content);//테이블에 쌓은 카테고리 리스트 지우기
	    }
	    
	    //선택한 카테고리를 body에 표시
	    function cal_ctgPick(i) {
	    	console.log("카테고리 표시 요청");
	    	
	    	var ctxName = $("#cal_ctxName"+i+"").html();
	    	$("#cal_pickedCtg").html(ctxName);
	    	
	    	var cal_content = "";
	    	$("#cal_addPopList").html(cal_content);
	    	
	    	$("#cal_addBack").css("display","none");
	    	$("#cal_addPop").css("display","none");
	    	
	    	console.log("i+1 : ");
	    	console.log(i+1);
	    	$("#cal_addCtgIdx").val(i+1);//선택한 카테고리의 인덱스에 맞게 숫자를 계산하여 input type=hidden 에 넣는다
		}
	    
	    //지출/수입 입력 페이지에서 장기계획 그래프 팝업 출력 /////////////////////////////////////////////////////////////////////////////////
	    $("#cal_longTermSpan").click(function(){
	    	
	    	 $.ajax({
	    		type:"get",
	    		url:"./ca_longTermList",
	    		dataType:"json",
	    		success:function(data){
	    			console.log(data);
	    			console.log(data.longList);
	    			
	    			cal_longTermPop(data.longList);
	    			
	    		},
	    		error:function(error){
	    			console.log(error);
	    		}
	    	});
	    	//팝업창 사이즈 조절했음
	    	$("#cal_addPop").css("width", "1000px");
	    	$("#cal_addPop").css("height", "600px");
	    	
	    	var content = "";
	    	var content2 = "";
	    	var content3 = "";
	    	
	    	$("#cal_longPopList").html(content);
	    	
	    	//팝업창 띄우기
	    	$("#cal_addBack").css("display","block");
	    	$("#cal_addPop").css("display","block");
	    	
	    	
	    	$("#cal_addPoptitle").html("<h3>장기계획 그래프</h3>");
	    	
	    	
	    	//팝업시 장기계획 선택 확인 버튼
		    $("#cal_longPopBtn").html(content3);
			content2 = "<input type='button' onclick='keepLongIdx()' value='확인'/>"
			$("#cal_longPopBtn").append(content2); 
	    	
	    	
	    	$.ajax({
				type:"post",
				url:"./longList",
				dataType:"json",
				success:function(data){
					console.log(data.list);
					if(data.list.length==0){
						if (confirm("장기계획이 없습니다. 추가하시겠습니까?")==true){
							location.href="longTermAdd.jsp";
						}else{
							/* location.href="main.jsp"; */
						}
					}
					console.log(data);
					
					listPrint(data.list);
					
				},
				error:function(error){
					console.log(error);
				}
			});

	    });
	    
 	    function keepLongIdx(){
	    	$("#cal_addLongIdx").val($("input[type=radio]:checked").val());
	    	console.log($("input[type=radio]:checked").val());
	    	cal_addPopClose();
	    } 
	    
	    function listPrint(list){
 			console.log(list);
 			var content="";

 			list.forEach(function(item,index){
 				var result = item.longStackM*100/item.longGoalM
 				console.log("===============");
 				console.log(result);
 				content+="<div>";
 				content+="<span>";
 					content+="<div>";
 						content+="<progress value='"+item.longStackM*100/item.longGoalM+"'max='"+100+"'>";
 						content+="</progress>";
 						content+="<input name='idx' type='radio' value='"+item.longIdx+"'/>";
 					content+="</div>";
 					content+="<div>"; 
 						content+="<table>";
 						content+="<tr>";
 						
 						content+="<td>제목 : "+item.longSubject+"&nbsp&nbsp&nbsp</td>";
 						content+="<td>설정 기간:&nbsp&nbsp"+item.longTerm+"일&nbsp&nbsp&nbsp</td>";
 						content+="<td>총 금액:&nbsp&nbsp"+item.longGoalM+"&nbsp&nbsp</td>";
 						content+="<td>남은 금액:&nbsp&nbsp"+(item.longGoalM-item.longStackM)+"&nbsp&nbsp</td>";
 						content+="<td>진행도&nbsp&nbsp"+result.toFixed(0)+"%</td>";

 						content+="</tr>";
 						content+="</table>";
 					content+="</div>";
 					content+="<br/>";
 				content+="</span>";
 				content+="</div>";
 				
 			});
 			$("#cal_longPopList").append(content);
    	} 

	    	

	    
	    
	    //디폴트 일(日)자 만들기
    	var content = "";
	    for(var i = 1; i<=31;i++){
	    	if(i<10){
	    		content += "<option value='0"+i+"' name='cal_addDate'>"+i+"일</option>"
	    	}else{
	    		content += "<option value='"+i+"' name='cal_addDate'>"+i+"일</option>"
	    	}
	    }
	    $("#cal_addDate").append(content);
	    
	    //입력 성공/실패 판별
	    var success = "${success}";
	    if(success ==""){
	    	console.log("공백상태임");
	    }else if(success != 0){
	    	alert("입력에 성공하셨습니다.");
	    	location.href="./calendar.jsp"; //calendar.jsp
	    }else{
	    	alert("입력에 실패하셨습니다.");
	    }
	    
	  	//년,월에 맞춰서 일(日)자 만들기
		function cal_createDate(){
	    	
	    	console.log($("#cal_addYear").val());
	    	console.log($("#cal_addMonth").val());
	    	console.log($("#cal_addDate").val());
	    	
	    	var lastDay = (new Date($("#cal_addYear").val(), $("#cal_addMonth").val(), 0)).getDate();
	    	console.log(lastDay);
	    	
	    	var content = "";
	    	$("#cal_addDate").html(content);
		    for(var i = 1; i<=lastDay;i++){
		    	if(i<10){
		    		content += "<option value='0"+i+"' name='cal_addDate1'>"+i+"일</option>"
		    	}else{
		    		content += "<option value='"+i+"' name='cal_addDate1'>"+i+"일</option>"
		    	}
		    }
		    $("#cal_addDate").append(content);
		    goalFind();
	    }
	    
	  	// 단위기간 찾기
	  	function goalFind(){
	  		$.ajax({
	  			type:"get",
	  			url:"./ca_find",
	  			data:{
	  				cal_addYear:$("#cal_addYear").val(),
	  				cal_addMonth:$("#cal_addMonth").val(),
	  				cal_addDate:$("#cal_addDate").val(),
	  				tabIdx : $("#calEdit").val()
	  			},
	  			dataType:"json",
	  			success:function(data){
	  				console.log(data.listDto);
	  				//cal_goalShow
	  				if(data.listDto.goalIdx==0){
	  					$("#cal_goalShow").html("해당하는 단위기간이 없습니다.");
	  				}else{
	  					$("#cal_goalShow").html("<p>이 날짜에 해당하는 단위기간의 제목 : "+data.listDto.goalSubject+"</p>");
	  				}
	  			},
	  			error:function(error){
	  				console.log(error);
	  			}
	  		});
	  	}
	  	
    </script>
</html>