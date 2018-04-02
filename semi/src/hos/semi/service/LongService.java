package hos.semi.service;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import hos.semi.dao.LongAddDAO;
import hos.semi.dto.longTurmDTO;

public class LongService {
	
	HttpServletRequest request = null;
	HttpServletResponse response = null;
	
	
	public LongService(HttpServletRequest request, 
			HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	public void lp_add() throws ServletException, IOException  {
		
		request.setCharacterEncoding("UTF-8");
		String loginId =(String) request.getSession().getAttribute("loginId");
		String subject = request.getParameter("subject");
		String startYear = request.getParameter("startYear");
		String startMonth = request.getParameter("startMonth");
		String endYear = request.getParameter("endYear");
		String endMonth = request.getParameter("endMonth");
		String goalMoney = request.getParameter("goalMoney");
		System.out.println("세션아이디 : "+loginId);
		System.out.println(subject);
		System.out.println(startYear);
		System.out.println(startMonth);
		System.out.println(endYear);
		System.out.println(endMonth);
		System.out.println(goalMoney);
		 
		String stDate = startYear+"-"+startMonth+"-01";
		String edDate = endYear+"-"+endMonth+"-01";
		System.out.println(stDate);
		System.out.println(edDate);
		
		Date stDate2=Date.valueOf(stDate);
		Date edDate2=Date.valueOf(edDate);
		
		
		 LongAddDAO longdao = new LongAddDAO();
		 
		 int term=longdao.change(stDate2,edDate2);
		 System.out.println(term);
		 
		 
		 longdao = new LongAddDAO();
		 int success = longdao.longadd(loginId,subject,stDate2,edDate2,goalMoney,term);
		 
		 String msg;
		 
		 if(success==1) {
			 
			 msg = "장기계획이 등록 됐습니다";	
			 
			 response.sendRedirect("longTermPlan.jsp");
			 
		 }else {
			 
			 msg = "장기계획 등록에 실패했습니다";	
			 
			 response.sendRedirect("longTermAdd.jsp");
			 
		 }
		 
		 System.out.println(msg);
	}

	public void longlist() throws ServletException, IOException{
		String memberId=(String)request.getSession().getAttribute("loginId");
		
		
		LongAddDAO dao = new LongAddDAO();
		
		ArrayList<longTurmDTO> list =dao.longlist(memberId);
		HashMap<String,Object> map=new HashMap<String,Object>();
		map.put("list",list );
		
		Gson json = new Gson();
		String obj = json.toJson(map);
		System.out.println(obj);

		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
		
		
	}
//수정페이지에 왔을 때 기존에 입력 되 있던 값 불러오기
	public int updateForm() throws ServletException, IOException{
		int success=0;
		String idx = request.getParameter("idx");
		System.out.println(idx);
		LongAddDAO dao = new LongAddDAO();
		
		longTurmDTO dto = dao.detail(idx);
		System.out.println(dto);
		
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		Date str1= dto.getLongStart();
		Date str2= dto.getLongEnd();
		System.out.println("str1 :" +str1);
		String sDate=fmt.format(str1);
		String eDate=fmt.format(str2);
		System.out.println("sDate " +sDate);
		String[] result1 =sDate.split("-");
		String[] result2 =eDate.split("-");
		System.out.println(result1[0]+"/"+result1[1]+"/"+result1[2]);
		dto.setSyear(result1[0]);
		dto.setSmonth(result1[1]);
		dto.setSday(result1[2]);
		dto.setEyear(result2[0]);
		dto.setEmonth(result2[1]);
		dto.setEday(result2[2]);
		
		
		String page="/";
		
		
		if(dto!=null) {
			page="longTermEdit.jsp";
			request.setAttribute("dto", dto);
		}else {
			System.out.println("실패!");
		}
		
		RequestDispatcher dis = request.getRequestDispatcher(page);
		dis.forward(request, response);
		
		
		
		return 0;
		
		
	}
//실제로 업데이트 할 내용 수정해 주는 명령어(db에서 update)
	public void update() throws ServletException, IOException{
		request.setCharacterEncoding("UTF-8");
		String uplongIdx = request.getParameter("idx");
		String upsubject = request.getParameter("upsubject");
		String upstartYear = request.getParameter("upstartYear");
		String upstartMonth = request.getParameter("upstartMonth");
		String upendYear = request.getParameter("upendYear");
		String upendMonth = request.getParameter("upendMonth");
		String upgoalMoney = request.getParameter("upgoalMoney");
		
		System.out.println(uplongIdx);
		System.out.println(upsubject);
		System.out.println(upstartYear);
		System.out.println(upstartMonth);
		System.out.println(upendYear);
		System.out.println(upendMonth);
		System.out.println(upgoalMoney);
		
		String upstDate = upstartYear+"-"+upstartMonth+"-01";
		String upedDate = upendYear+"-"+upendMonth+"-01";
		System.out.println(upstDate);
		System.out.println(upedDate);
		
		Date upstDate2=Date.valueOf(upstDate);
		Date upedDate2=Date.valueOf(upedDate);
		
		LongAddDAO longdao = new LongAddDAO();
		 
		 int upterm=longdao.upchange(upstDate2,upedDate2);
		 System.out.println(upterm);
		 
		 longdao = new LongAddDAO();
		 int success = longdao.longupdate(uplongIdx,upsubject,upstDate2,upedDate2,upgoalMoney,upterm);
		 
		 String msg;
		 
		 if(success==1) {
			 
			 msg = "장기계획 수정이 완료됐습니다";	
			 
			 response.sendRedirect("longTermPlan.jsp");
			 
		 }else {
			 
			 msg = "장기계획 수정에 실패했습니다";	
			 
			 response.sendRedirect("longTermPlan.jsp");
			 
		 }
		 
		 System.out.println(msg);
		
	}

	public void del() throws ServletException, IOException{
		String idx = request.getParameter("idx");
		System.out.println(idx);
		int result=0;
		LongAddDAO dao = new LongAddDAO();
		
		if(dao.del(Integer.parseInt(idx))==1) {
			response.sendRedirect("longTermPlan.jsp");
			System.out.println("삭제성공");
			result=1;
			
		}else {
			response.sendRedirect("longTermPlan.jsp");
			System.out.println("삭제실패");
		}
		
		
		
	}
	
	//메인 장기그래프 띄우기
	public void mainLong() throws IOException{
		String memberId =(String)request.getSession().getAttribute("loginId");
		System.out.println(memberId);
		LongAddDAO dao = new LongAddDAO();
		
		ArrayList<longTurmDTO> list =dao.mainLong(memberId);
		
		System.out.println(list);
		
		HashMap<String,Object> map=new HashMap<String,Object>();
		map.put("list",list );
		
		Gson json = new Gson();
		String obj = json.toJson(map);
		System.out.println(obj);

		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	
	}
	

	public void ca_upCompl2() throws ServletException, IOException{
		
		String memberId = (String) request.getSession().getAttribute("loginId");
		String longIdx = request.getParameter("longIdx");
		String longStackM = request.getParameter("longStackM");
		
		LongAddDAO dao = new LongAddDAO();
		int success = dao.ca_upCompl2(memberId, longIdx, longStackM);
		
		request.setAttribute("success", success);
		RequestDispatcher dis = request.getRequestDispatcher("calendarAdd.jsp");
		dis.forward(request, response);//저축 추가한 결과 0,1 로 보냈다(아직 calendarAdd.jsp에서 받지는 않았음)
	}


}
