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
        	
        	#cal_addButton1, #cal_addButton2, #cal_addButton3{
        		border: 1px solid black;
        		width:100px;
        		height: 50px;	
        		float : left;
        		margin: 1px;
        	}

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
        </style>
    </head>
    <body>
    	<jsp:include page="loginBox.jsp"></jsp:include>
		<div id="cal_addBack"></div>
		<div id="cal_addPop">
		
		<div id="cal_addPoptitle"></div>
		
		<table id="cal_addPopList">
			
		</table>
		<br/><a href='#' onclick='cal_addPopClose()'>취소</a>
		</div>
		
		
	    <div id="cal_addButton1">지출</div>
	    <div id="cal_addButton2">수입</div>
	    <div id="cal_addButton3">저축</div>
    
    
    	<form action="./ca_upDB" method="post">
		    <input type="hidden" value="1" name="calTabIdx" id="calEdit"/>
		    <input type="hidden" value="calOption" class="page"/>
		    <div id="Content">
		    
			    <div id="cal_buttonContent">
			    	<select id="cal_addYear" name ="cal_addYear">
			    		<option value="2017">2017</option>
			    		<option value="2018" selected>2018</option>
						<option value="2019">2019</option>
						<option value="2020">2020</option>
						<option value="2021">2021</option>
						<option value="2022">2022</option>
			    	</select>
			    	
			    	<select id=cal_addMonth name="cal_addMonth" onchange="cal_createDate()">
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
			    	
			    	<select id=cal_addDate name="cal_addDate"></select>
			    	<input id="cal_addIosIdx" name="cal_addIosIdx" type="hidden" value="${calList.iosIdx}"/>
			    	
			    	
			    	<br/><br/><br/><br/>
			    	<textarea rows="1" cols="40" name="cal_addSubject" placeholder="제목을 입력해주세요.">${calList.iosSubject}</textarea>
			    	<br/><br/>
			    	<textarea rows="1" cols="40" name="cal_addIosM" placeholder="금액을 입력해주세요.">${calList.iosM}</textarea>
			    	<br/><br/>
			    	<span id="cal_addCategorySpan">
			    		카테고리<input id="cal_addCategoryVal" type="hidden" name="cal_addCtgSel" value="${calList.iosSel}"/>
			    		<input id="cal_addCtgIdx" type="hidden" name="cal_addCtgIdx" value="${calList.ctgIdx}"/>
			    	</span>
			    	<span id="cal_pickedCtg">카테고리를 선택해주세요.</span>
			    	
			    	<br/><br/>
			    	<textarea rows="5" cols="40" name="cal_addMemo" placeholder="메모 내용을 입력해주세요.">${calList.iosMemo}</textarea>
			    </div>
			    
			</div>
		        
			<input id="cal_addBtn" type="submit" value="확인"/>
			<input id="cal_addCancelBtn" type="button" value="취소"/>
	    </form>
    </body>
    <script>
    
	    var cal_categoryCnt = "${calList.iosSel}";
	    var cal_addYear = "${calList.iosSel}";
	    var date = "${calList.iosDate}";
		
	    var dateSplitString = "";
	    var dateSplitArr = date.split("-");
	    console.log("dateSplitArr[2] : "+dateSplitArr[2]);
	    

	    
	    
	    $("#asdf").val(dateSplitArr[2]);
	    
 function cal_createDate(){
	    	
	    };
	    
    	var content = "";
    	
    	var dateLength = 0;
    	if(dateSplitArr[0]!=2016 && dateSplitArr[1]==2){
    		dateLength = 28;
    	}else if(dateSplitArr[1] ==4||6||9||11){
    		dateLength = 30;
    	}else if(dateSplitArr[0]==2016 && dateSplitArr[1]==2){
    		dateLength = 29;
    	}else{
    		dateLength = 31;
    	}
    	
	    for(var i = 1; i<=30;i++){
	    	if(i<10){
	    		content += "<option value='0"+i+"' name='cal_addDate'>"+i+"일</option>"
	    	}else{
	    		content += "<option value='"+i+"' name='cal_addDate'>"+i+"일</option>"
	    	}
	    	
	    }
	    $("#cal_addDate").append(content);
	     
	    
	    $("#cal_addYear").val(dateSplitArr[0]);
	    $("#cal_addMonth").val(dateSplitArr[1]);
	    $("#cal_addDate").val(dateSplitArr[2]);
	    
	    
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
		});
	    
	    //데이터 유효성검사
	    $("#cal_addBtn").click(function(){
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
	    
	    var success = "${success}";
	    if(success ==""){
	    	console.log("공백상태임");
	    }else if(success != 0){
	    	alert("입력에 성공하셨습니다.");
	    	location.href="spend.jsp";
	    }else{
	    	alert("입력에 실패하셨습니다.");
	    }
    </script>
</html>