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
			font-family: 'Noto Sans KR', sans-serif;
			margin: 0;
		}
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
				background-color: brown;
				-webkit-transition: 0.5s ease-out;
			}
			
			/*FireFox
				progress::-moz-progress-bar {
				background: orange;
			}*/
			
			/*버튼을 감싸는 div*/
			#location{
				position: absolute;
				left: 50%;
				transform : translateX(-50%);
				
			}
			.button{
				font-family: 'Jeju Myeongjo', serif;
                background-color: white;
                border: 1px solid #B9B8B8;
                /* 버튼 안의 텍스트의 색 */
                color: black;
                text-align: center;
                padding: 8px 10px;
                font-size: 14px;
                position: relative;
                left: 15.5%;
            	top: 200px;
            	border-radius: 3px;
            	margin: 3px;
            }
            
            .button:hover{
                background-color: #F0F0EF;
                border: 1px solid #B9B8B8;
                border-radius: 3px;
            }
			
			.longTermGraph{
				position: relative;
				top : 200px;
				left: 35%;
				width : 800px;

			}
			
			

			table{
				width : 700px;
				text-align: center;border: 1px solid;
				border-collapse: collapse;	
			}
			td{
				border: 1px solid;
			}
		</style>
	</head>
	<body>
		<jsp:include page="loginBox.jsp"></jsp:include>
		<form action="./lp_updateForm" method="get">
		<div>
			<div id="listTable">	
				<span>
				</span>
				<!-- add -->		
			</div>
		</div>
		</form>
	</body>
	<script>
	$(document).ready(function(){
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
	
	function listPrint(list){
		console.log(list);
		var content="";

		list.forEach(function(item,index){
			var result = item.longStackM*100/item.longGoalM
			console.log("===============");
			console.log(result);
			content+="<div class='longTermGraph'>";
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
		$("#listTable").append(content);
		
		list.forEach(function(it,index){
			content="<div id='location'>"
			content+="<input class='button' type='button' value='추가' onclick='add()'/>";
			/* content+="<input type='button' value='수정' onclick='update()'/>"; */
			content+="<input class='button' type='submit' value='수정'/>";
			content+="<input class='button' type='button' onclick='del()' value='삭제'/>";
			content+="</div>"
		});
		$("#listTable").after(content);

	}

	function add(){
		location.href="longTermAdd.jsp";
	}
	
	/* function update(){		
		location.href="longTermEdit.jsp";
		
	} */

	function del(){
		var list = $("input[type='radio']");
		var val = "";
		
		if (confirm("삭제하시겠습니까?")==true){
			console.log($("input[type='radio']"));
			console.log(list.length);
			console.log(list[0].checked);
			for(var i=0;i<list.length;i++){
				if(list[i].checked == true){
					console.log(list[i].attributes[2].value);
					val = list[i].attributes[2].value
				}
			}
			location.href="./lp_del?idx="+val;
		}else{
			return;
		}
	}

	</script>
</html>