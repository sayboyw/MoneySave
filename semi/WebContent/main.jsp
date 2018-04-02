<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>MainPage</title>
		<link rel="stylesheet" href="css/bootstrap.css">
		<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
		<script  src="js/bootstrap.js"></script>
		<style type="text/css">
			@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);
			
			body{
				font-family: 'Noto Sans KR', sans-serif;
				color: #616161;
				font-size: 14px;
				background-color: #F2F2F2;
			}
			
			#MainStat{
				position : absolute;
				top : 153px;
				left: 4%;
				width : 345px;
				height : 345px;
				background-color: white;
				border: 1px solid #e2e2e2;
			}
			
			#MainCal{
				position: absolute;
				top : 512px;
				width : 345px;
				height : 345px;
				left: 4%;
				background-color: white;
				border: 1px solid #e2e2e2;
			}
			
			#MainImg{
				top : 153px;
				left : 23%;
				width : 1294.03px;
				height : 704px;
				background-color: white;
				position: absolute;
				border: 1px solid #e2e2e2;
			}
			
			#MainLong{
				top : 153px;
				right: 4%;
				width : 40px;
				height : 620px;
				position: absolute;
			}
			
			#MainLongBtn{
				top: 665px;
				right: 30px;
			    width: 39px;
			    height: 20px;
			    position: absolute;
			}
			
			#longBtn{
				position: absolute;
				top: 1px;
			}
			
			
			.out{
				background-color: green;
				width:40px;
				height:620px;
				position:absolute;
			}
		
			.in{
				background-color: white;
				width:40px;
				position:absolute;
			}
			
			.over{
				position:relative;
				width:40px;
				height:620px;
				
			}
			
			/* #pop{
				position: absolute;
				top:30%;
				left:25%;
				width: 400px;
				height: 400px;
				background-color: white;
				display: none;
				z-index: 5;
				
				overflow : auto;
				scrollbar-face-color:#cecece;
			} */
			
			/* #x{
				position: absolute;
				display: none;
				width: 25px;
				height: 25px;
				top:30%;
				right:33%;
				z-index: 7;
			} */
			
			progress{/*IE*/
				background-color: gray;
				border:0;
				height:25px;
				width : 700px;
				border-radius:90px;
			} 
			
			/*Chrome*/
			progress::-webkit-progress-bar {  
				background-color: white;
				border: 1px solid gray;
			}  
			
			progress::-webkit-progress-value {  
				background-color: #6AB72F;
				-webkit-transition: 0.5s ease-out;
			}
			
			/*팝업창 배경*/
			.delBackground{
				position: absolute;
				width:1000px;
				height:1000px;
				top: 0px;
				background-color: black;
				opacity: 0.3;
				z-index: 3;
				display: none;
			}
			
			/*팝업창*/
			.delPopup{
				position: absolute;
				top:43%;
				left:40%;
				width: 400px;
				height: 200px;
				background-color: white;
				display: none;
				z-index: 5;
				text-align : center;
				overflow : auto;
				scrollbar-face-color:#cecece;
			}

			#calTops{
				position: absolute;
				top: 15px;
				left: 15px;
				width: 315px;
				align: center;
				height: 313px;
				/* background-color: yellow; */
			}
			
			#calTopOut{
				position: absolute;
				top: 10px;
				left: 7%;
				width: 50px;
				height: 30px;
				/* background-color: red; */
			}
			
			#calTopOut span{
				font-family: 'Noto Sans KR', sans-serif;
				color: #6E6E6E;
				text-align: left;
				font-size: 15pt;
				font-weight: 500;
			}
			
			#calTops hr{
				border: 0.5px solid #A4A4A4;
				position: absolute;
				top: 40px;
				width: 100%;
			}
			
			#calTopIn{
				position: absolute;
				top: 10px;
				right: 6%;
				width: 50px;
				height: 30px;
			}
			
			#calTopIn span{
				font-family: 'Noto Sans KR', sans-serif;
				color: #6E6E6E;
				text-align: right;
				font-size: 15pt;
				font-weight: 500;
			}
			
			.calCont{
				position: absolute;
				top: 100px;
				left: 32px;
    			width: 274px;
				height: 200px;
				/* background-color: yellow; */
			}
			
			#calMoney{
				font-family: 'Noto Sans KR', sans-serif;
				color: #6E6E6E;
				text-align: right;
				font-size: 14pt;
				font-weight: 200;
				position: absolute;
				right: 5%;
			}
			
			#calConOut{
				font-family: 'Noto Sans KR', sans-serif;
				color: #6E6E6E;
				text-align: right;
				font-size: 13pt;
				font-weight: 200;
			}
			
			.btns{
			/* 
				font-family: 'Noto Sans KR', sans-serif;
                background-color: white;
                
                color: #6E6E6E;
                text-align: center;
                padding: 8px 10px;
                font-size: 13px;
                position: relative;
                left: 30%;
            	top: 280px;
           	    border: 1px solid #B9B8B8;
           	    border-radius: 3px;
    		*/
    			font-family: 'Noto Sans KR', sans-serif;
                background-color: white;
                border: 1px solid #B9B8B8;
                /* 버튼 안의 텍스트의 색 */
                color: black;
                text-align: center;
                padding: 8px 10px;
                font-size: 14px;
                position: relative;
                left: 30%;
            	top: 280px;
            	border-radius: 3px;
            }
            
            .btns:hover{
                background-color: #F0F0EF;
                border: 1px solid #B9B8B8;
                border-radius: 3px;
            }

		</style>
	</head>
	<body>
		<jsp:include page="loginBox.jsp"></jsp:include>
		<input type="hidden" value="main" class="page"/>
		
		<div id="Main">
			<div id="MainStat">
				<jsp:include page = "ArcGage.jsp"></jsp:include>
			</div>
			
			<div id="MainCal">
				<div id="calTops">
					<div id="calTopOut" onclick="cal1()"><span>지출</span></div>
					<div id="calTopIn" onclick="cal2()"><span>수입</span></div>
					<hr/>
				</div>
				<div id="calContents">
					<div class="calCont"></div>
				</div>
				<input type="button" class="btns" value="지출 및 수입 추가" name="add" onclick='location.href="./calendarAdd.jsp"'/>
			</div>
			
			<div id="MainImg">
				<jsp:include page="MainImage.jsp"></jsp:include>
			</div>
			
			<!-- ===================================================== -->
			<div id="MainLong">
				
				<div class="over">
					<!-- add -->
						<div id = "MainLongBtn">
							<input type="button" id="longBtn" class="btn"  value="상세보기" onclick="gg()">
							
						</div>
				</div>
				
				
				
				</div>
				<!-- ===================================================== -->
			</div>

	</body>
	<script>
		var calDate = new Date();
		var todayYear = calDate.getFullYear();//오늘에 해당하는 년
		var todayMonth = calDate.getMonth()+1;//오늘에 해당하는 달
		var todayDate = calDate.getDate();//오늘에 해당하는 날짜
		var calContentCnt = 0;//지출|수입 바꿔주는 변수 
	
		console.log("오늘 날짜 : "+todayYear+" / "+todayMonth+" / "+todayDate);
		
		$(document).ready(function(){
			calList();
			mainLongTerm();
		
		});
		//장기계획그래프
		function mainLongTerm(){
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
			
		}
		//장기계획 그래프 -2
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
				content="<table class='per'>";
						content+="<tr>";
							content+="<td>"+result.toFixed(0)+"%</td>";
						content+="</tr>";
				content+="</table>";
		
		
				content+="<div class='out'>";
					content+="<div class='in'>";
					
					content+="</div>";
				content+="</div>";
				
				/* content="<div>";
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
				content+="</div>"; */
			
			});
			$(".over").append(content);
			
			$(".in").css("height",""+graybar+"%");
			
		}
		//닫기버튼클릭
		/* $("#x").click(function(){
			var lp_content = "";
			$("#black").css("display","none");
			$("#pop").css("display","none");
			$("#x").css("display","none");
			$("#listTable").html(lp_content);
		}); */
		
		//달력 출력1
		function cal1(){
			calContentCnt = 0;
			calList(calContentCnt);
		}
		//달력 출력2
		function cal2(){
			calContentCnt = 1;
			calList(calContentCnt);
		}
		//달력 출력3
		function calList(){
			$.ajax({
				type:"get",
				url:"./ca_calMain",
				data:{
					todayYear:todayYear,
					todayMonth:todayMonth,
					todayDate:todayDate,
					tabIdx:$(".on").val()
				},
				dataType:"json",
				success:function(data){
					var content = "";
					var blank = "";
					$(".calCont").html(blank);
					
					/* console.log("메인에 띄울 지출 데이터 : "+data.calMainList1[0].iosSubject); */
					// 지출에 아무것도 없을 때
					if(calContentCnt==0 && data.calMainList1[0] == null){
						$(".calCont").html("<span id='calConOut'>보여줄 내용이 없습니다.</span>");
						console.log(calContentCnt);
						
					// 수입에 아무것도 없을 때	
					}else if(calContentCnt==1 && data.calMainList2[0] == null){
						console.log("아무것도 없음 - 메인");
						console.log(calContentCnt);
						$(".calCont").html("<span id='calConOut'>보여줄 내용이 없습니다.</span>");
						
					// 지출에 내용이 있을 때
					}else if(calContentCnt==0 && data.calMainList1[0] != null){
						for(i=0;i<data.calMainList1.length;i++){
							content += "<span id='calConOut'>"+data.calMainList1[i].iosSubject+"";
							content += "<span id='calMoney'>"+data.calMainList1[i].iosM+"</span><br/>";
							content += "</span>";
						}
						console.log(calContentCnt);
					//  수입에 내용이 있을 때	
					} else if(calContentCnt==1 && data.calMainList2 != null){
						for(i=0;i<data.calMainList2.length;i++){
							content += "<span id='calConOut'>"+data.calMainList2[i].iosSubject+"";
							content += "<span id='calMoney'>"+data.calMainList2[i].iosM+"</span><br/>";
							content += "</span>";
						}
						console.log(calContentCnt);
					}
					
					$(".calCont").append(content);
				},
				error:function(error){
					console.log(error);
				}
			});
		}
		//장기계획 상세보기
		function gg() {
		 	
 			$(".delBackground").css("display","block");
			$("#pop").css("display","block");
			$("#x").css("display","block"); 
		}

		
	</script>
</html>