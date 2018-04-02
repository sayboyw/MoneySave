package hos.semi.service;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import hos.semi.dao.CalDAO;
import hos.semi.dao.LongAddDAO;
import hos.semi.dto.CalDTO;
import hos.semi.dto.CategoryDTO;
import hos.semi.dto.GoalDTO;
import hos.semi.dto.MakeDTO;
import hos.semi.dto.longTurmDTO;

public class CalService {

	HttpServletRequest request = null;
	HttpServletResponse response = null;
	
	public CalService(HttpServletRequest request,
			HttpServletResponse response) {
		this.request = request;
		this.response = response;		
	}
	
	// 지출,수입내역 읽어오기
	public void app() throws IOException {
		System.out.println("지출,수입내역 읽어오기");
		CalDAO calDAO1 = new CalDAO();
		CalDAO calDAO2 = new CalDAO();
		CalDAO calDAO3 = new CalDAO();
		String stReplMemo1 = "";
		String stReplMemo2 = "";
		ArrayList<String> replMemo1 = new ArrayList<String>();
		ArrayList<String> replMemo2 = new ArrayList<String>();
		
		String memberId = (String) request.getSession().getAttribute("loginId");
		String tabIdx = request.getParameter("tabIdx");
		String clickDay = request.getParameter("clickDay");
		String clickYear = request.getParameter("clickYear");
		String clickMonth = request.getParameter("clickMonth");
		System.out.println(tabIdx+" : "+clickDay+" : "+clickYear+" : "+clickMonth+" : "+memberId);
		
		String clickDate =null;
		if(Integer.parseInt(clickDay)<10) {
			clickDate = clickYear+"-"+clickMonth+"-0"+clickDay;
		}else {
			clickDate = clickYear+"-"+clickMonth+"-"+clickDay;
		}
		
		System.out.println("테스트 : "+clickDate);
		Date clickDate2 = Date.valueOf(clickDate);
		System.out.println(clickDate2);
		
		ArrayList<CalDTO> ca_outcomelist = calDAO1.outcomelist(Integer.parseInt(tabIdx), clickDate2, memberId);
		ArrayList<CalDTO> ca_incomelist = calDAO2.incomelist(Integer.parseInt(tabIdx), clickDate2, memberId);
		HashMap<String, Object> appMap = new HashMap<String, Object>();
		
		
		for(int i=0;i<ca_outcomelist.size();i++) {
			if(ca_outcomelist.get(i).getIosMemo() != null) {
				if(ca_outcomelist.get(i).getIosMemo().indexOf("_") != -1) {
					stReplMemo1 = ca_outcomelist.get(i).getIosMemo().replaceAll("_", "　");
					System.out.println("지출 : "+stReplMemo1);
				}else {
					stReplMemo1 = ca_outcomelist.get(i).getIosMemo();
				}
				replMemo1.add(stReplMemo1);
			}
		}
		
		for(int i=0;i<ca_incomelist.size();i++) {
			if(ca_incomelist.get(i).getIosMemo() != null) {
				if(ca_incomelist.get(i).getIosMemo().indexOf("_") != -1) {
					stReplMemo2 = ca_incomelist.get(i).getIosMemo().replaceAll("_", "　");
					System.out.println("수입 : "+stReplMemo2);
				}else {
					stReplMemo2 = ca_incomelist.get(i).getIosMemo();
				}
				replMemo2.add(stReplMemo2);
			}
		}

/*		for(int i=0;i<ca_incomelist.size();i++) {
			if(ca_incomelist.get(i).getIosMemo() != null && ca_incomelist.get(i).getIosMemo().indexOf("_") != -1) {
				stReplMemo2 = ca_incomelist.get(i).getIosMemo().replaceAll("_", "　");
				System.out.println("지출 : "+stReplMemo2);
				replMemo2.add(stReplMemo2);
				
			}else if(ca_incomelist.get(i).getIosMemo().indexOf(" ") != -1){
				replMemo2 = ca_incomelist.get(i).getIosMemo().replaceAll("_", " ");
				System.out.println("수입 : "+replMemo2);
			}
		}*/
		appMap.put("replMemo1", replMemo1); /*지출 메모*/
		appMap.put("replMemo2", replMemo2); /*수입 메모*/
		appMap.put("ca_outcome", ca_outcomelist);
		appMap.put("ca_income", ca_incomelist);
		
		
		//카테고리 이름 가져오기
		ArrayList<String> ctgNames = calDAO3.ctgSubjectCall();
		appMap.put("ctgNames", ctgNames);
		
		Gson json = new Gson();
		String ca_obj = json.toJson(appMap);
		
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(ca_obj);
	}
	
	// 수입 및 지출 내역 수정
		public void update() throws ServletException, IOException {
			String iosIdx = request.getParameter("iosIdx");
			CalDAO calDAO = new CalDAO();
			CalDTO calList = calDAO.update(iosIdx);
			
			System.out.println("update(), calList.getIosIdx() : "+calList.getIosIdx());
			
			request.setAttribute("calList", calList);
	        RequestDispatcher dis = request.getRequestDispatcher("calendarEdit.jsp");
	        dis.forward(request, response);
		}

		public void delete() throws ServletException, IOException {
			String iosIdx = request.getParameter("iosIdx");
			CalDAO calDao = new CalDAO();
			int success1 = calDao.delete(iosIdx);
			
			request.setAttribute("success1", success1);
			RequestDispatcher dis = request.getRequestDispatcher("calendar.jsp"); /*calendar.jsp*/
			dis.forward(request, response);
		}

		//카테고리 팝업리스트 호출
		public void ca_addCa() throws ServletException, IOException {
			
			String addCategory = request.getParameter("cal_addCategory");
			System.out.println(addCategory);
			
			CalDAO dao = new CalDAO();
			ArrayList<CategoryDTO> cal_categoryList = dao.ca_addCa(Integer.parseInt(addCategory));
			
			HashMap<String, ArrayList<CategoryDTO>> map = new HashMap<String, ArrayList<CategoryDTO>>();
			if(cal_categoryList != null){
				map.put("categoryList", cal_categoryList);
			}
			
			Gson json = new Gson();
			String obj = json.toJson(map);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println(obj);
		}
		
		
		//사용자가 입력한 ios데이터를 DB 에 입력
		public void ca_upCompl() throws ServletException, IOException {
			
			request.setCharacterEncoding("UTF-8");
			String iosSel = request.getParameter("cal_addCtgSel1");
			String ctgIdx = request.getParameter("cal_addCtgIdx1");
			String iosSubject = request.getParameter("cal_addSubject1");
			String iosM = request.getParameter("cal_addIosM1");
			String iosMemo = request.getParameter("cal_addMemo1");
			String addYear = request.getParameter("cal_addYear1");
			String addMonth = request.getParameter("cal_addMonth1");
			String addDate = request.getParameter("cal_addDate1");
			String tb_tabIdx = request.getParameter("calTabIdx");
			int tabIdx = Integer.parseInt(tb_tabIdx);
			if(iosMemo != null) {

				if(iosMemo.indexOf(" ") != -1) {
					iosMemo = iosMemo.replaceAll(" ", "_");
					System.out.println(iosMemo);
					
					System.out.println("ca_upCompl(), request.getParameter : "
							+iosSel+" / "+ctgIdx+" / "+iosSubject+" / "+iosM+" / "+iosMemo+" / "
								+addYear+" / "+addMonth+" / "+addDate);
					
				}
			}else {
				System.out.println("ca_upCompl(), request.getParameter : "
						+iosSel+" / "+ctgIdx+" / "+iosSubject+" / "+iosM+" / "
							+addYear+" / "+addMonth+" / "+addDate);
			}
			
			
			//받아온 카테고리 인덱스 번호를 지출/수입에 맞게 계산
			int intCtgidx = 0;
			if(iosSel.equals("1")) {
				intCtgidx = Integer.parseInt(ctgIdx)+12;
				ctgIdx = intCtgidx+"";
			}
			System.out.println("ctgIdx : "+ctgIdx);
			
			//String 형식의 날짜를 Date 타입으로 변환
			String stringDate = "";
			
			stringDate = addYear+"-"+addMonth+"-"+addDate;
			System.out.println("stringDate : "+stringDate);
			
			Date iosDate = Date.valueOf(stringDate);
			
			System.out.println("iosDate : "+iosDate);
			
			//요일도 계산
			String iosDOTW = "" ;
		    Calendar cal = Calendar.getInstance() ;
		    cal.setTime(iosDate);
		    
		    int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
		    
		    switch(dayNum){
		        case 1:
		        	iosDOTW = "일";
		            break ;
		        case 2:
		        	iosDOTW = "월";
		            break ;
		        case 3:
		        	iosDOTW = "화";
		            break ;
		        case 4:
		        	iosDOTW = "수";
		            break ;
		        case 5:
		        	iosDOTW = "목";
		            break ;
		        case 6:
		        	iosDOTW = "금";
		            break ;
		        case 7:
		        	iosDOTW = "토";
		            break;
		    }
		    System.out.println(iosDOTW);
/*		    
			//가계부탭 인덱스도 전송 <- 임시로 1로 주겟음
		    int tabIdx = 1;
	*/	    
		    
		    String loginId = (String) request.getSession().getAttribute("loginId");
		    
		    /*어떤 단위기간인지 구분하는 컬럼도 계산*/
		    CalDAO dao1 = new CalDAO();
		    int goalIdx = dao1.pickGoalIdx(iosDate);
		    
		    CalDTO dto = new CalDTO();
		    dto.setIosSel(Integer.parseInt(iosSel));
		    dto.setCtgIdx(Integer.parseInt(ctgIdx));
		    dto.setIosSubject(iosSubject);
		    dto.setIosM(Integer.parseInt(iosM));
		    if(iosMemo != null) {
		    	dto.setIosMemo(iosMemo);
		    }
		    dto.setIosDate(iosDate);
		    dto.setIosDOTW(iosDOTW);
		    dto.setTabIdx(tabIdx);
		    dto.setMemberId(loginId);
		    dto.setGoalIdx(goalIdx);
		    
		    
		    CalDAO dao2 = new CalDAO();
		    int success = dao2.calAdd(dto);
		    
		    request.setAttribute("success", success);
		    RequestDispatcher dis = request.getRequestDispatcher("calendarAdd.jsp");
		    dis.forward(request, response);
		}
		
		//지출,수입내역 수정
		public void ca_upDB() throws ServletException, IOException {
			
			request.setCharacterEncoding("UTF-8");
			String iosIdx = request.getParameter("cal_addIosIdx");
			String iosSel = request.getParameter("cal_addCtgSel");
			String ctgIdx = request.getParameter("cal_addCtgIdx");
			String iosSubject = request.getParameter("cal_addSubject");
			String iosM = request.getParameter("cal_addIosM");
			String iosMemo = request.getParameter("cal_addMemo");
			String addYear = request.getParameter("cal_addYear");
			String addMonth = request.getParameter("cal_addMonth");
			String addDate = request.getParameter("cal_addDate");
			String tb_tabIdx = request.getParameter("calTabIdx");
			int tabIdx = Integer.parseInt(tb_tabIdx);
			
			if(iosMemo != null) {
				
				if(iosMemo.indexOf(" ") != -1) {////////////////////////////////////////////////////////////////////////
					iosMemo = iosMemo.replaceAll(" ", "_");
					System.out.println(iosMemo);
				}
				
				System.out.println("ca_upDB(), request.getParameter : "
						+iosIdx+" / "+iosSel+" / "+ctgIdx+" / "+iosSubject+" / "+iosM+" / "+iosMemo+" / "
							+addYear+" / "+addMonth+" / "+addDate);
			}else {
				System.out.println("ca_upDB(), request.getParameter : "
						+iosSel+" / "+ctgIdx+" / "+iosSubject+" / "+iosM+" / "
							+addYear+" / "+addMonth+" / "+addDate);
			}
			
			//String 형식의 날짜를 Date 타입으로 변환
			String stringDate = "";
			
			stringDate = addYear+"-"+addMonth+"-"+addDate;
			System.out.println("stringDate : "+stringDate);
			
			Date iosDate = Date.valueOf(stringDate);
			
			System.out.println("iosDate : "+iosDate);
			
			//요일도 계산
			String iosDOTW = "" ;
		    Calendar cal = Calendar.getInstance() ;
		    cal.setTime(iosDate);
		     
		    int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
		    
		    switch(dayNum){
		        case 1:
		        	iosDOTW = "일";
		            break ;
		        case 2:
		        	iosDOTW = "월";
		            break ;
		        case 3:
		        	iosDOTW = "화";
		            break ;
		        case 4:
		        	iosDOTW = "수";
		            break ;
		        case 5:
		        	iosDOTW = "목";
		            break ;
		        case 6:
		        	iosDOTW = "금";
		            break ;
		        case 7:
		        	iosDOTW = "토";
		            break;
		    }
		    System.out.println(iosDOTW);
/*		    
			//가계부탭 인덱스도 전송 <- 임시로 1로 주겟음
		    int tabIdx = 1;
	*/	    
		    String loginId = (String) request.getSession().getAttribute("loginId");
		    
		    /*어떤 단위기간인지 구분하는 컬럼도 계산*/
		    CalDAO dao1 = new CalDAO();
		    int goalIdx = dao1.pickGoalIdx(iosDate);
		    
		    CalDTO dto = new CalDTO();
		    dto.setIosIdx(Integer.parseInt(iosIdx));
		    System.out.println("여기 : "+dto.getIosIdx());
		    dto.setIosSel(Integer.parseInt(iosSel));
		    dto.setCtgIdx(Integer.parseInt(ctgIdx));
		    dto.setIosSubject(iosSubject);
		    dto.setIosM(Integer.parseInt(iosM));
		    if(iosMemo != null) {
		    	dto.setIosMemo(iosMemo);
		    }
		    dto.setIosDate(iosDate);
		    dto.setIosDOTW(iosDOTW);
		    dto.setTabIdx(tabIdx);
		    dto.setMemberId(loginId);
		    dto.setGoalIdx(goalIdx);
		    
		    CalDAO dao2 = new CalDAO();
		    int success = dao2.ca_upDB(dto);
		    
		    request.setAttribute("success", success);
		    RequestDispatcher dis = request.getRequestDispatcher("calendarAdd.jsp");
		    dis.forward(request, response);
		}
		
		// 달력 붙이기(전달)
		public void ca_calAddMinus() throws IOException {
			String calYear = request.getParameter("calYear");
			String calMonth = request.getParameter("calMonth");
			
			MakeCal makeCal = new MakeCal();
			MakeDTO makeDTO = makeCal.makeMinus(calYear, calMonth);
			
			HashMap<String, MakeDTO> map = new HashMap<String, MakeDTO>();
			map.put("makeDTO", makeDTO);
			
			Gson json = new Gson();
			String obj = json.toJson(map);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println(obj);
		}
		
		// 달력 붙이기(다음달)
		public void ca_calAddPlus() throws IOException {
			String calYear = request.getParameter("calYear");
			String calMonth = request.getParameter("calMonth");
			System.out.println(calYear+" : "+calMonth);
			
			MakeCal makeCal = new MakeCal();
			MakeDTO makeDTO = makeCal.makePlus(calYear, calMonth);
			
			HashMap<String, MakeDTO> map = new HashMap<String, MakeDTO>();
			map.put("makeDTO", makeDTO);
			
			Gson json = new Gson();
			String obj = json.toJson(map);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println(obj);
		}
		
		
		
		// 달력 지출 버튼 (토글)
		public void ca_outcomeShow() throws IOException {
			CalDAO calDAO = new CalDAO();
			String memberId = (String) request.getSession().getAttribute("loginId");	//세션아이디
			String tabIdx = request.getParameter("tabIdx");	//1
			String clickYear = request.getParameter("clickYear"); 
			String stClickMonth = request.getParameter("clickMonth");
			
			String clickMonth;
			if(Integer.parseInt(stClickMonth)<10) {
				clickMonth = "0"+stClickMonth;
			}else {
				clickMonth = stClickMonth;
			}
			System.out.println(tabIdx+" : "+clickYear+" : "+clickMonth+" : "+memberId);
			
			ArrayList<CalDTO> clickOutList = calDAO.outcomeShow(tabIdx, clickYear, clickMonth, memberId);
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("clickOutList", clickOutList);
			
			Gson json = new Gson();
			String obj = json.toJson(map);
			response.getWriter().println(obj);
			
		}
		
		// 달력 수입 버튼 (토글)
		public void ca_incomeShow() throws IOException {
			CalDAO calDAO = new CalDAO();
			String memberId = (String) request.getSession().getAttribute("loginId");
			String tabIdx = request.getParameter("tabIdx");
			String clickYear = request.getParameter("clickYear");
			String stClickMonth = request.getParameter("clickMonth");
			
			String clickMonth;
			if(Integer.parseInt(stClickMonth)<10) {
				clickMonth = "0"+stClickMonth;
			}else {
				clickMonth = stClickMonth;
			}
			
			System.out.println(tabIdx+" : "+clickYear+" : "+clickMonth);
			
			ArrayList<CalDTO> clickInList = calDAO.incomeShow(tabIdx, clickYear, clickMonth, memberId);
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("clickInList", clickInList);
			
			Gson json = new Gson();
			String obj = json.toJson(map);
			response.getWriter().println(obj);
			
		}
		
		// 단위기간 불러오기
		public void ca_find() throws IOException {
			CalDAO calDAO = new CalDAO();
			String tabIdx = request.getParameter("tabIdx");
			System.out.println("ca_find에서 tabidx 값 : " +tabIdx);
			String memberId = (String) request.getSession().getAttribute("loginId");
			String cal_addYear = request.getParameter("cal_addYear");
			String cal_addMonth = request.getParameter("cal_addMonth");
			String cal_addDate = request.getParameter("cal_addDate");
			System.out.println(cal_addYear+" : "+cal_addMonth+" : "+cal_addDate);
			
			String stringDate = "";
			stringDate = cal_addYear+"-"+cal_addMonth+"-"+cal_addDate;
			Date dtDate = Date.valueOf(stringDate);
			
			System.out.println("stringDate : "+stringDate);
			
			GoalDTO listDto = calDAO.find(dtDate, tabIdx, memberId);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("listDto", listDto);
			
			Gson json = new Gson();
			String obj = json.toJson(map);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println(obj);
			
		}
		
		
		public void ca_longTermList() throws IOException {
			
			LongAddDAO dao = new LongAddDAO();
			
			String memberId = (String) request.getSession().getAttribute("loginId");
			System.out.println(memberId);
			
			ArrayList<longTurmDTO> longList = dao.ca_longTermList(memberId);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("longList", longList);
			
			Gson json = new Gson();
			String obj = json.toJson(map);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println(obj);
			
		}

		public void ca_calMain() throws IOException {
			
			String memberId = (String) request.getSession().getAttribute("loginId");
			String tabIdx = request.getParameter("tabIdx");
			String todayYear = request.getParameter("todayYear");
			String todayMonth = request.getParameter("todayMonth");
			String todayDate = request.getParameter("todayDate");
			
			String stToday = todayYear+"-"+todayMonth+"-"+todayDate;
			Date today = Date.valueOf(stToday);
			
			CalDAO dao = new CalDAO();
			ArrayList<CalDTO> calMainList1 = dao.ca_calMain1(today, tabIdx, memberId);
			
			CalDAO dao2 = new CalDAO();
			ArrayList<CalDTO> calMainList2 = dao2.ca_calMain2(today, tabIdx, memberId);
			
			HashMap<String, ArrayList> map = new HashMap<String, ArrayList>();
			map.put("calMainList1", calMainList1);
			map.put("calMainList2", calMainList2);
			
			Gson json = new Gson();
			String ca_obj = json.toJson(map);
			
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println(ca_obj);
			
		}
		
}
