package hos.semi.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.sun.org.apache.xerces.internal.util.SynchronizedSymbolTable;

import hos.semi.dao.MemberDAO;
import hos.semi.dao.TabDAO;
import hos.semi.dto.MemberDTO;

public class MemberService {

	HttpServletRequest request=null;
	HttpServletResponse response=null;
	
	public MemberService(HttpServletRequest request, 
			HttpServletResponse response) {
		this.request = request;	
		this.response = response;
	}

	//로그인
	public void login() throws IOException, ServletException {
		String id =request.getParameter("loginId");
		String pw =request.getParameter("loginPw");
		System.out.println(id + " / "+pw);
		MemberDAO memdao = new MemberDAO();
		//객체화 시키는 순간 MemberDAO의 생성자도 자동으로 실행된다.
		
		if( memdao.login(id,pw)) {
			HttpSession session = request.getSession();		// 세션생성
			session.setAttribute("loginId", id);			//세션에 아이디 저장
			//request.getSession().setAttribute("loginId", id);
			response.sendRedirect("main.jsp");
		}else {
			request.setAttribute("msg", "로그인에 실패 하였습니다.");
			RequestDispatcher dis=request.getRequestDispatcher("index.jsp");
			dis.forward(request, response);
		}
	}
	
	//로그아웃
	public void logout() throws IOException,ServletException {
		request.getSession().removeAttribute("loginId");
		response.sendRedirect("index.jsp");
		System.out.println("로그아웃 완료");
	}
	//아이디 중복체크
	public void overlay() throws IOException,ServletException {
		String id =request.getParameter("id");
		System.out.println("받아온 id : "+ id);
		MemberDAO memdao = new MemberDAO();
		boolean over = memdao.overlay(id);
		
		String msg="이미 사용중인 아이디 입니다.";
		if(over == false) {
			msg="사용 가능한 아이디 입니다.";
		}
		System.out.println("보내줄 msg 내용 : "+msg);
		
		HashMap<String,Boolean> map = new HashMap<String,Boolean>();
		map.put("msg", !over);		//over에 true가 joinForm으로 갈것
		//맵을 json형태로 바꾸는 작업
		Gson json = new Gson(); //Gson 라이브러리를 통해
		String obj = json.toJson(map);	// json형태의 문자열로 만들어 준다.
		System.out.println(obj);
		
		//한글깨짐방지
		response.setContentType("text/html; charset=UTF-8 ");
		//크로스 도메인 - 여기선 굳이 안해도 된다.
		// response.setHeader("Access-Control-Allow-Origin", "*");	//*자리에는 
		// response객체를 통해서 반환
		response.getWriter().println(obj);
	}

	//회원가입
	public void join() throws IOException,ServletException {
		//한글깨짐 방지
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("joinId");
		String pw = request.getParameter("joinPw");
		String name = request.getParameter("joinName");
		String phone = request.getParameter("joinNumber");
		String email = request.getParameter("joinEmail");
		String gender = request.getParameter("joinGender");
		MemberDTO memdto = new MemberDTO(id,pw,name,phone,email,gender);
		
		MemberDAO memdao = new MemberDAO();
		
		String msg="회원가입에 실패하였습니다.";
		String page="joinForm.jsp";
		int tabmake=0;
		int goalmake=0;
		if( memdao.join(memdto) == 1) {
			TabDAO tabdao = new TabDAO();
			tabmake=tabdao.tabCreate(id);
			if(tabmake==1) {
				tabdao = new TabDAO();
				goalmake=tabdao.goalCreate(id);
				if(goalmake==1) {
					System.out.println("회원가입성공");
					msg="회원가입에 성공하였습니다.";
					page="index.jsp"; 
				}
			}else {
				msg="회원가입성공 // 탭생성실패";
				page="index.jsp"; 
			}
			
		}
		System.out.println(msg);
		
		request.setAttribute("msg", msg);
		RequestDispatcher dis = request.getRequestDispatcher(page);	
		dis.forward(request, response);
	}

	//멤버-회원탈퇴
			public void memDel() throws IOException,ServletException{
				String id =(String) request.getSession().getAttribute("loginId");
				String pw = request.getParameter("delPw");
				System.out.println("id변수 값 : "+id+" // 입력받은 pw: "+pw);
				
				MemberDAO memdao = new MemberDAO();
				
				String msg="회원탈퇴에 실패했습니다.";
				if(memdao.memberDel(id,pw) == 1) {
					msg="회원탈퇴에 성공했습니다.";
					int success=1;
					request.setAttribute("msg", msg);
					RequestDispatcher dis = request.getRequestDispatcher("index.jsp");
					dis.forward(request, response);
				}else {
					System.out.println(msg); 	//디버깅코드
					request.setAttribute("msg", msg);
					RequestDispatcher dis = request.getRequestDispatcher("myPage.jsp");	
					//원래 메인이었는데 mypage로 바꿈
					dis.forward(request, response);
				}
				
			}
	
	
//사용자의 정보 보기
	public void memView() throws IOException,ServletException{
		int success=0;
		String id = (String) request.getSession().getAttribute("loginId");
		System.out.println("받아온 세션아이디 확인 :" +id);
		
		HashMap<String,Object> map = new HashMap<>();
		
		if(id==null) {
			success=-1;
		}else {
			MemberDAO memdao = new MemberDAO();
			MemberDTO memdto = memdao.memView(id);
			if(memdto != null) {
				System.out.println("무언가 리턴받았다");
				map.put("dto",memdto);
				success=1;
			}else {
				success=0;
			}
		}
		map.put("success",success);
			
		Gson json = new Gson();
		String obj = json.toJson(map);
		
		System.out.println(obj);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);	
	}
	
	//회원정보 수정하기
	public void memUpdate() throws IOException,ServletException{
		request.setCharacterEncoding("UTF-8");
		int success=0;
		String id = (String) request.getSession().getAttribute("loginId");
		
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		System.out.println("받아온 세션아이디 확인 :" +id+"/// 다른 받아온 값들 : "+pw+"/"+name+"/"+phone+"/"+email);
		
		
		HashMap<String,Object> map = new HashMap<>();
		
		if(id==null) {
			success=-1;
		}else {
			MemberDAO memdao = new MemberDAO();
			MemberDTO memdto = memdao.memUpdate(id,pw,name,phone,email);
			if(memdto != null) {
				System.out.println("무언가 리턴받았다");
				map.put("dto",memdto);
				success=1;
			}else {
				success=0;
			}
		}
		map.put("success",success);
			
		Gson json = new Gson();
		String obj = json.toJson(map);
		
		System.out.println(obj);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);	
	}
	
	//관리자 - > 회원탈퇴
	public void adminDel() throws IOException,ServletException{
		String id =request.getParameter("memberid");
		System.out.println("id변수 값 : "+id);
		
		MemberDAO memdao = new MemberDAO();
		
		String msg="회원탈퇴에 실패했습니다.";
		if(memdao.adminDel(id) == 1) {
			msg="회원탈퇴에 성공했습니다.";
			response.sendRedirect("adminList.jsp");
		}else {
			System.out.println(msg); 	//디버깅코드
			request.setAttribute("msg", msg);
			
			RequestDispatcher dis = request.getRequestDispatcher("main");	
			dis.forward(request, response);
		}
		
	}
	//관리자-> 회원정보확인
	public void adminList() throws IOException,ServletException {
		int status =0;
		String id=(String) request.getSession().getAttribute("loginId");
		
		HashMap <String,Object>map = new HashMap<String, Object>();
		map.put("loginId",id);
		MemberDAO memdao = new MemberDAO();
		ArrayList<MemberDTO> list = memdao.memberList();
		if(list.size()>0) {
			status=1;
			map.put("list",list);
		}
		map.put("status",status);
		
		Gson json = new Gson();
		String obj = json.toJson(map);
		System.out.println(obj);
		
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);

	}
	//관리자여부 확인
	public void adminconfirm() throws IOException,ServletException{
		String id=(String) request.getSession().getAttribute("loginId");
		System.out.println("id변수 값 : "+id);
		HashMap <String,Object>map = new HashMap<String, Object>();
		map.put("loginId",id);
		MemberDAO memdao = new MemberDAO();
		int result = memdao.adminconfirm(id);
		System.out.println("받아온 result : "+result);
		if(result==0) {	//일반회원
			map.put("result", result);
		}else {	//관리자
			map.put("result",result);
		}
		
		Gson json = new Gson();
		String obj = json.toJson(map);
		System.out.println(obj);
		
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}
	
	
}
