package hos.semi.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hos.semi.service.CalService;
import hos.semi.service.LongService;
import hos.semi.service.MemberService;
import hos.semi.service.StatService;
import hos.semi.service.TabService;


@WebServlet({ "/login", "/logout" ,"/overlay", "/memView", "/adminList" ,"/adminconfirm",
		"/ca_calAddMinus", "/ca_calAddPlus","/ca_app","/ca_outcomeShow", "/ca_incomeShow", "/ca_find",
		"/longList","/mainLong", "/ca_longTermList", "/ca_calMain",
		"/ss_bar", "/ss_select","/tb_list","/ss_Arc", "/ss_Image"})
public class Rcontroller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response)
					throws ServletException, IOException {
		multi(request,response);
	}


	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response)
					throws ServletException, IOException {
		multi(request,response);
	}


	private void multi(HttpServletRequest request,
			HttpServletResponse response)
					throws ServletException, IOException {
		
			//서비스에게 request, response를 넘겨준다 (생성자)
				MemberService memservice = new MemberService(request,response);
				CalService calService = new CalService(request, response);	
				LongService longService = new LongService(request,response);
				StatService statService = new StatService(request,response);
				TabService tabservice = new TabService(request, response);
					
				//URL 분기
				String uri = request.getRequestURI(); 
				String ctx = request.getContextPath();	
				String subAddr =uri.substring(ctx.length());
				
				switch(subAddr) {
				
				case "/login":
					System.out.println("login 요청 시작");
					memservice.login();
					break;
					
				case "/adminconfirm":
					System.out.println("관리자여부 확인작업 시작");
					memservice.adminconfirm();
					break;
					
				case "/logout":
					System.out.println("logout 요청 시작");
					memservice.logout();
					break;
					
				case "/overlay":
					System.out.println("id중복요청 시작");
					memservice.overlay();
					break;

				case "/memView":
					System.out.println("mypage회원정보 요청 시작");
					memservice.memView();
					break;
					
				case "/adminList":
					System.out.println("mypage회원정보 요청 시작");
					memservice.adminList();
					break;
					
				case "/ca_calAddMinus" :
					System.out.println("컨트롤러 - 달력 전달 리스트 요청");
					calService.ca_calAddMinus();
					break;	
					
				case "/ca_calAddPlus" :
					System.out.println("컨트롤러 - 달력 다음달 리스트 요청");
					calService.ca_calAddPlus();
					break;
					
				case "/ca_app":
					System.out.println("컨트롤러 - 데이터 요청 시작");
					calService.app();
					break;
				
				case "/ca_outcomeShow" :
					System.out.println("토글 - 지출 버튼");
					calService.ca_outcomeShow();
					break;	
					
				case "/ca_incomeShow" :
					System.out.println("토글 - 수입 버튼");
					calService.ca_incomeShow();
					break;	
					
				case "/ca_find" :
					System.out.println("단위기간 불러오기");
					calService.ca_find();
					break;		
					
				case"/longList":
					System.out.println("장기계획 리스트 요청");
					longService.longlist();
					break;
					
				case"/mainLong":
					System.out.println("메인장기 그래프 요청");
					longService.mainLong();
					break;
					
				case "/ca_longTermList":
					System.out.println("지출/수입 입력중 장기그래프 호출");
					calService.ca_longTermList();
					break;
					
				case "/ca_calMain":
					System.out.println("지출/수입 입력중 장기그래프 호출");
					calService.ca_calMain();
					break;
					
				case "/ss_bar": 
					System.out.println("막대그래프 요청");
					statService.statStick();
					break;
					
				case "/ss_select":
					System.out.println("카테고리그래프 요청");
					statService.ss_select();
					break;
					
				case "/tb_list":
					System.out.println("탭 불러오기");
					tabservice.tb_list();
					break;

				case "/ss_Arc":
					statService = new StatService(request, response);
					System.out.println("메인페이지에 통계 원형그래프 불러오기");
					statService.arc();
					break;
					
				case "/ss_Image":
					statService = new StatService(request, response);
					System.out.println("메인페이지에 넣을 이미지요청");
					statService.image();
					break;	
					
				default:
						response.sendRedirect("/"); 		// 인덱스로 보내준다.
				
				}
	}

}
