<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>탭 추가 및 삭제</title>
<style>
	ul{list-style:none;}
	a{text-decoration:none;}
	.home_subject_notice{width: 567px; float:left;}    
	.home_subject_notice {position:relative; width: 567px;   float:left;}
	.home_subject_notice>li>a { display:block; position:absolute; text-align:center;  background:#ffffff;  color:#555; border:1px solid #dce3e9;  border-bottom:0; padding:7px 16px; font-weight:bold; margin-left: 40px;
	border: 1px solid black; display:inline-block;}
	.home_subject_notice>li+li+li+li>a{ display:block; position:absolute; width:10px;  text-align:center;  background:#ffffff;  color:#555; border:1px solid #dce3e9;  border-bottom:0; padding:7px 16px; font-weight:bold; margin-left: 40px;
	border: 1px solid black;}
	.home_subject_notice>li.on>a {background:#efb300; color:#fff;   border:1px solid #efb300;}
	.home_subject_notice>li:first-child>a {left:0;}
	.home_subject_notice>li+li>a {left:84px;}
	.home_subject_notice>li+li+li>a {left:168px;}
	.home_subject_notice>li+li+li+li>a {left:252px;}
	.home_subject_notice>li+li+li+li>b {left:252px;}
	#li2{
		display: none;
	}
	#li3{
		display: none;
	}
	
	#table-cover{
				position: absolute;
			  	top: 30%;
				left: 50%;
				width: 1000px;
				height: 500px;
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
            	top : 70%;
            	transform : translateX(-50%);
            }

            input[type='text']{
            	width : 400px;
            }
            table{
            	width : 600px;
            	height : 300px;
            	border-spacing: 0;
  				border-collapse: collapse;
            }
            td{
            	height : 80px;
            }
			#tb_goalLimitM{
				size: 20px;
				width : 80%;
			}
</style>
</head>
<body>
	<jsp:include page="loginBox.jsp"></jsp:include>
	
	<center>
		
		<div id="table-cover">
			<table class="table table-striped table-bordered">
				<tr>
					<td colspan="3" align="center">
						<input id="tb_goalLimitM" name="tb_goalLimitM" type="text" style="width: 250px; text-align: center;" placeholder="지출 상한액" style="width:100%;"/>
					</td>
				</tr>
				<tr>
					<td>
						<select id="tb_startyear" name ="tb_startyear" onChange="cal_createDate()">
					    	<option value="2018" selected>2018</option>
							<option value="2019">2019</option>
							<option value="2020">2020</option>
							<option value="2021">2021</option>
							<option value="2022">2022</option>
					    	</select>
		
						<select id="tb_startmonth" name="tb_startmonth" onChange="cal_createDate()">
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
		
						<select id="tb_startday" name="tb_startday"></select>
					</td>
					<td><b> ~ </b></td>
					<td>
						<select id="tb_endyear" name ="tb_endyear" onChange="cal_createDate2()">
				    		<option value="2018" selected>2018</option>
							<option value="2019">2019</option>
							<option value="2020">2020</option>
							<option value="2021">2021</option>
							<option value="2022">2022</option>

				    	</select>
		
						<select id="tb_endmonth" name="tb_endmonth" onChange="cal_createDate2()">
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
		
						<select id="tb_endday" name="tb_endday"></select>
					</td>
				</tr>
				
				<tr>
					<td colspan="3" align="center">
						<input id="tb_tabSubject" type="text" name="tb_tabSubject" style="width: 250px;
						text-align: center;" placeholder="프로젝트 제목"/>
					</td>
				</tr>
				<tr>
					<td colspan="3" align="center">
						<input id="tb_goalSubject" type="text" name="tb_goalSubject" style="width: 250px;
						text-align: center;" placeholder="단위 기간 제목"/>
					</td>
				</tr>
			</table>
		</div>	
		<br>
		<div id="button-cover">
			<input id="tb_add" class="button" type="button" value="확인 버튼">
			<input type="button" class="button" value="취소 버튼" onclick="location.href='main.jsp'">
			<input id="tb_delete" class="button" type="button" value="삭제 버튼">
		</div>
	</center>
</body>
<script>
	//탭 띄우기
	$(document).ready(function(){
		$.ajax({
			type:"post",
			url:"./tb_check",
			dataType:"JSON",
			success:function(obj){
				/* console.log(obj.list);
				console.log(obj.list[0].tabIdx);
				console.log(obj.list[1].tabIdx); */
				
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
	});
	
	var a;
	var b;
	var c;
	var d;

	//탭 삭제
	$("#tb_delete").click(function(){
		$.ajax({
			type:"post",
			url:"./tb_delete",
			data:{
				tabIdx:$(".on").val()
			},
			dataType:"JSON",
			success:function(obj){
				console.log("삭제시 obj값 : "+obj.result);
				if(obj.result==1){
					alert("삭제 완료");
					if(obj.tabIdx==2){
						$("#li2").attr("value","0");
						$("#li2").css("display","none");
					}else if(obj.tabIdx==3){
						$("#li3").attr("value","0");
						$("#li3").css("display","none");
					}
					b = $("#li2").val();
					c = $("#li3").val();
					d = a+b+c;
				}else{
					alert("삭제 실패");
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	});
	
	var money = /[^(0-9)]/;
	//탭 추가
	$("#tb_add").click(function(){
		a = $("#li1").val();
		b = $("#li2").val();
		c = $("#li3").val();
		d = a+b+c;
		if(d==6){
			alert("새 가계부 추가는 결제가 필요합니다.");
		}else{
			if($("#tb_tabSubject").val().length > 7){
				alert("제목은 최대 6자까지 입력 가능합니다.");
				$("#tb_tabSubject").val("");
			}else if(money.test($("#tb_goalLimitM").val())){
				alert("지출상한액은 숫자만 입력 가능합니다.");
				$("#tb_goalLimitM").val("");
			}else{
				tabAdd();
			}
		}
	});

		//탭 추가하기
		function tabAdd(){
			$.ajax({
	 		type:"post",
			url:"./tb_add",
			data:{
				tabIdx:d,
				tb_startyear:$("#tb_startyear").val(),
				tb_startmonth:$("#tb_startmonth").val(),
				tb_startday:$("#tb_startday").val(),
				tb_endyear:$("#tb_endyear").val(),
				tb_endmonth:$("#tb_endmonth").val(),
				tb_endday:$("#tb_endday").val(),
				tb_goalLimitM:$("#tb_goalLimitM").val(),
				tb_tabSubject:$("#tb_tabSubject").val(),
				tb_goalSubject:$("#tb_goalSubject").val()
			},
			dataType:"JSON",
			success:function(obj){
				console.log(obj);
				if(obj.result==1){
					alert("추가 완료");
					if(obj.tabIdx==2){
						$("#li2").attr("value","2");
						$("#li2").css("display","inline");
						$("#name2").html($("#tb_tabSubject").val());
					}else if(obj.tabIdx==3){
						$("#li3").attr("value","3");
						$("#li3").css("display","inline");
						$("#name3").html($("#tb_tabSubject").val());
					}
					b = $("#li2").val();
					c = $("#li3").val();
					d = a+b+c;
					console.log(d);
					//location.href="EditControl2.jsp";
				}else{
					alert("추가 실패");
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	//일수 구하기
	var content = "";
    for(var i = 1; i<=31;i++){
    	if(i<10){
    		content += "<option value='0"+i+"' name='tb_startday'>"+i+"일</option>"
    	}else{
    		content += "<option value='"+i+"' name='tb_startday'>"+i+"일</option>"
    	}
    }
    $("#tb_startday").append(content);
    
  	//일수 구하기
	var content2 = "";
    for(var i = 1; i<=31;i++){
    	if(i<10){
    		content2 += "<option value='0"+i+"' name='tb_endday'>"+i+"일</option>"
    	}else{
    		content2 += "<option value='"+i+"' name='tb_endday'>"+i+"일</option>"
    	}
    }
    $("#tb_endday").append(content2);
 	//$("#cal_addDate").append(content);
 	
 	//일수 구하기
    function cal_createDate(){
		
		var lastDay = (new Date($("#tb_startyear").val(), $("#tb_startmonth").val(), 0)).getDate();
		
		console.log(lastDay);
		
		var content = "";
		$("#tb_startday").html("");
		for(var i = 1; i<=lastDay;i++){
			if(i<10){
				content += "<option value='0"+i+"' name='tb_startday'>"+i+"일</option>"
			}else{
				content += "<option value='"+i+"' name='tb_startday'>"+i+"일</option>"
			}
		}
		$("#tb_startday").append(content);
	}
    
	//일수 구하기
	function cal_createDate2(){
     	
     	var lastDay = (new Date($("#tb_endyear").val(), $("#tb_endmonth").val(), 0)).getDate();
     	
     	console.log(lastDay);
     	
     	var content = "";
     	$("#tb_endday").html("");
 	    for(var i = 1; i<=lastDay;i++){
 	    	if(i<10){
 	    		content += "<option value='0"+i+"' name='tb_endday'>"+i+"일</option>"
 	    	}else{
 	    		content += "<option value='"+i+"' name='tb_endday'>"+i+"일</option>"
 	    	}
 	    }
 	    $("#tb_endday").append(content);
      }
      
	$(".home_subject_notice>li>a").click(function() {
	    $(this).parent().addClass("on").siblings().removeClass("on");
	    return false;
	});
	
	//탭 구분하기
	$("a").click(function(){
		$.ajax({
			type:"post",
			url:"./tb_list",
			data:{
				tabIdx:$(".on").val()
			},
			dataType:"JSON",
			success:function tabPrint(list){
				if(list != null){
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
						$("#name2").html(list.list[0].tabSubject);
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
						$("#name3").html(list.list[0].tabSubject);
						$("#tb_goalLimitM").val(list.list[0].goalLimitM);
		    	 		$("#tb_tabSubject").val(list.list[0].tabSubject);
		    	 		$("#tb_goalSubject").val(list.list[0].goalSubject);
		    	 		$("#tb_startyear").val(list.list[0].statrtYear);
		    	 		$("#tb_startmonth").val(list.list[0].statrtMonth);
		    	 		$("#tb_startday").val(list.list[0].statrtDay);
		    	 		$("#tb_endyear").val(list.list[0].endtYear);
		    	 		$("#tb_endmonth").val(list.list[0].endMonth);
		    	 		$("#tb_endday").val(list.list[0].endDay);
					}
				}else{
					$("#tb_goalLimitM").val("");
	    	 		$("#tb_tabSubject").val("");
	    	 		$("#tb_goalSubject").val("");
	    	 		alert("'탭 추가 및 삭제' 창으로 이동합니다.");
					location.href="tapEditControl2.jsp";
				}
			},error:function(e){
				console.log(e);
			}
		});
	});

    /* var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	} */
</script>
</html>