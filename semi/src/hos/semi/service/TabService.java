package hos.semi.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import hos.semi.dao.TabDAO;
import hos.semi.dto.GoalDTO;

public class TabService {

	HttpServletRequest request; 
	HttpServletResponse response;

	public TabService(HttpServletRequest request, 
			HttpServletResponse response) {		
		this.request = request;
		this.response = response;
	}
	
	
	
	//탭 수정
	public void tb_update() throws ServletException, IOException{
		request.setCharacterEncoding("UTF-8");
		//값 불러오기
		String loginId = (String) request.getSession().getAttribute("loginId");
		
		String tb_tabIdx = request.getParameter("tabIdx");
		int tabIdx = Integer.parseInt(tb_tabIdx);
		String tb_startyear = request.getParameter("tb_startyear");
		String tb_startmonth = request.getParameter("tb_startmonth");
		String tb_startday = request.getParameter("tb_startday");
		String tb_endyear = request.getParameter("tb_endyear");
		String tb_endmonth = request.getParameter("tb_endmonth");
		String tb_endday = request.getParameter("tb_endday");
		String tb_goalLimitM = request.getParameter("tb_goalLimitM");
		String tb_tabSubject = request.getParameter("tb_tabSubject");
		String tb_goalSubject = request.getParameter("tb_goalSubject");
		System.out.println(tabIdx);
		
		//시작날, 마지막날 Date 형식으로 변환
		String tb_stratDate = tb_startyear+"-"+tb_startmonth+"-"+tb_startday;
		String tb_endDate = tb_endyear+"-"+tb_endmonth+"-"+tb_endday;
		Date tb_stDate = Date.valueOf(tb_stratDate);
		Date tb_enDate = Date.valueOf(tb_endDate);
		 
		int goalLimitM = Integer.parseInt(tb_goalLimitM); //지출상한액 int로 변환
		
		System.out.println(tb_goalLimitM+" / "+tb_tabSubject+" / "+tb_goalSubject);
		System.out.println(tb_stDate);
		System.out.println(tb_enDate);
		
		//시작날 - 마지막날 = termday
		TabDAO dao = new TabDAO();
		int termday = dao.goalTerm(tb_stDate,tb_enDate);
		
		String msg = "수정에 실패 하였습니다.";
		int result = 0;
		dao = new TabDAO();
		if(tabIdx!=10) {
			if(dao.jp_tabUpdate(loginId,tb_tabSubject,tabIdx)==1) {
				dao = new TabDAO();
				if(dao.jp_goalUpdate(loginId,tabIdx,goalLimitM,tb_goalSubject,tb_stDate,tb_enDate,termday) != 0) {
					result = 1;
					msg = "수정에 성공 하였습니다.";
				}
			}
		}
		System.out.println(msg);
		
		Gson json = new Gson();
		HashMap<String, Integer> map = new HashMap<>();
		map.put("result", result);
		map.put("tabIdx", tabIdx);
		String obj = json.toJson(map);
		System.out.println(obj);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println(obj);
		
	}
	//탭 추가하기
	public void tb_add() throws ServletException, IOException{
		request.setCharacterEncoding("UTF-8");
		//값 불러오기
		String loginId = (String) request.getSession().getAttribute("loginId");
		String tb_tabIdx = request.getParameter("tabIdx");
		int idx = Integer.parseInt(tb_tabIdx);
		int tabIdx = 0;
		String tb_startyear = request.getParameter("tb_startyear");
		String tb_startmonth = request.getParameter("tb_startmonth");
		String tb_startday = request.getParameter("tb_startday");
		String tb_endyear = request.getParameter("tb_endyear");
		String tb_endmonth = request.getParameter("tb_endmonth");
		String tb_endday = request.getParameter("tb_endday");
		String tb_goalLimitM = request.getParameter("tb_goalLimitM");
		String tb_tabSubject = request.getParameter("tb_tabSubject");
		String tb_goalSubject = request.getParameter("tb_goalSubject");
		
		//시작날, 마지막날 Date 형식으로 변환
		String tb_stratDate = tb_startyear+"-"+tb_startmonth+"-"+tb_startday;
		String tb_endDate = tb_endyear+"-"+tb_endmonth+"-"+tb_endday;
		System.out.println(tb_endDate);
		Date tb_stDate = Date.valueOf(tb_stratDate);
		Date tb_enDate = Date.valueOf(tb_endDate);
		 
		int goalLimitM = Integer.parseInt(tb_goalLimitM); //지출상한액 int로 변환
		
		System.out.println(goalLimitM+" / "+tb_tabSubject+" / "+tb_goalSubject);
		System.out.println(tb_stDate);
		System.out.println(tb_enDate);
		int result = 0;
		//마지막날 - 시작날 = termday
		TabDAO dao = new TabDAO();
		int termday = dao.goalTerm(tb_stDate,tb_enDate);	//기간구하기
		System.out.println("idx: "+idx);
		if(idx==1) {
			tabIdx=2;		//2번탭생성
			dao = new TabDAO();
			dao.tb_add2(loginId,tabIdx,goalLimitM,tb_goalSubject,tb_stDate,tb_enDate,termday,tb_tabSubject);		
			result = 1;
		}else if(idx==3) {
			tabIdx=3;		//3번탭생성
			dao = new TabDAO();
			dao.tb_add3(loginId,tabIdx,goalLimitM,tb_goalSubject,tb_stDate,tb_enDate,termday,tb_tabSubject);
			result =1;
		}else{
			tabIdx=2;
			dao = new TabDAO();
			dao.tb_add2(loginId,tabIdx,goalLimitM,tb_goalSubject,tb_stDate,tb_enDate,termday,tb_tabSubject);
			result =1;
		}
		System.out.println("ser: "+result);
		
		Gson json = new Gson();
		HashMap<String, Integer> map = new HashMap<>();
		map.put("result", result);
		map.put("tabIdx", tabIdx);
		String obj = json.toJson(map);
		System.out.println(obj);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println(obj);
		
	}
	//탭 삭제(1번 탭 삭제x)
	public void tb_TabDelete() throws ServletException, IOException{
		String loginId = (String) request.getSession().getAttribute("loginId");
		String tb_tabIdx = request.getParameter("tabIdx");
		int tabIdx = Integer.parseInt(tb_tabIdx);
		int result = 0;

		if(tabIdx==1) {
			result=0;
			System.out.println("1번탭이라 삭제안됨");
		}else {
			TabDAO dao = new TabDAO();
			result=dao.tb_TabDelete(loginId,tabIdx);
			if(result==1) {
				dao = new TabDAO();
				if(dao.tb_goaldelete(loginId,tabIdx)==1) { //goal_tb에서 해당 탭의 정보 삭제 => 성공시(1)
					dao = new TabDAO();
					if(dao.tb_iosDelete(loginId,tabIdx)==1) {	//ios_tb에서 해당 아이디, 탭의정보 삭제
						System.out.println("전부 다 삭제 성공");
					}
			}else {
				System.out.println("삭제 x");
			}
			
			}
		
		}
				
/*		
		if(dao.tb_num1(loginId,tabIdx)!=1) {	//삭제할 탭 번호 가져오기
			dao = new TabDAO();
			if(dao.tb_TabDelete(loginId,tabIdx)==1) {	//실제로 탭 삭제작업 => 성공시(1)
				dao = new TabDAO();
				if(dao.tb_goaldelete(loginId,tabIdx)==1) { //goal_tb에서 해당 탭의 정보 삭제 => 성공시(1)
					dao = new TabDAO();
					if(dao.tb_iosDelete(loginId,tabIdx)==1) {
						msg = "삭제 성공";
						result = 1;
					}
					
				}
			}
		}else {
			msg = "삭제 실패";
			result = 0;
		}
		*/
		Gson json = new Gson();
		HashMap<String, Integer> map = new HashMap<>();
		map.put("result", result);
		map.put("tabIdx", tabIdx);
		String obj = json.toJson(map);
		System.out.println(obj);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println(obj);
		
	}
	//탭 띄우기
	public void tb_check() throws ServletException, IOException{
		String loginId = (String) request.getSession().getAttribute("loginId");
		TabDAO dao = new TabDAO();
		ArrayList<GoalDTO> list = dao.tb_check(loginId);

		Gson json = new Gson();
		HashMap<String, ArrayList<GoalDTO>> map = new HashMap<>();
		map.put("list", list);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		System.out.println("service: "+list);
		out.println(obj);
		
	}
	
	//탭 구분
	public void tb_list() throws ServletException, IOException{
		String loginId = (String) request.getSession().getAttribute("loginId");
		String tb_tabIdx = request.getParameter("tabIdx");
		int tabIdx = Integer.parseInt(tb_tabIdx);
		System.out.println("받아온 값: "+tabIdx);
		String obj = null;
		TabDAO dao = new TabDAO();
		boolean success = true;
		GoalDTO dto = dao.tb_day(tabIdx,loginId);
		System.out.println("dtoStart: "+dto.getGoalStart());
		System.out.println("dtoEnd: "+dto.getGoalEnd());
		String sDate = "";
		String eDate = "";
		String[] startDate;
		String[] endDate;
		String tb_startYear = "";
		String tb_startMonth = "";
		String tb_startDay = "";
		String tb_endYear = "";
		String tb_endMonth = "";
		String tb_endDay = "";
		if(dto.getGoalStart() != null && dto.getGoalEnd() != null) {
			Date tb_Start = dto.getGoalStart();
			Date tb_End = dto.getGoalEnd();
			System.out.println(tb_Start);
			SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			
			sDate = fmt.format(tb_Start);
			eDate = fmt.format(tb_End);
			System.out.println(sDate);
			startDate = sDate.split("-");
			endDate = eDate.split("-");
			System.out.println("시작시간: "+startDate[0]+" / "+startDate[1]+" / "+startDate[2]);
			System.out.println("끝시간: "+endDate[0]+" / "+endDate[1]+" / "+endDate[2]);
			tb_startYear = startDate[0];
			tb_startMonth = startDate[1];
			tb_startDay = startDate[2];
			tb_endYear = endDate[0];
			tb_endMonth = endDate[1];
			tb_endDay = endDate[2];
			System.out.println("자른 날짜: "+tb_startYear);
		}		
		dao = new TabDAO();
		if(dao.check(loginId,tabIdx)==success) {	//탭 구분하는 메소드
			System.out.println("true");
			dao = new TabDAO();
			ArrayList<GoalDTO> list = dao.list(loginId,tabIdx,tb_startYear,tb_startMonth,tb_startDay,tb_endYear,tb_endMonth,tb_endDay);
			//탭 데이터 받아오기
			Gson json = new Gson();
			HashMap<String, ArrayList<GoalDTO>> map = new HashMap<String, ArrayList<GoalDTO>>();
			map.put("list", list);
			System.out.println("list: "+list);
			obj = json.toJson(map);
			System.out.println(obj);
		}else {
			obj = null;
		}
		System.out.println("obj = ? "+obj);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println(obj);
		
	}



}
