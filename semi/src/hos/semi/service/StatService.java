package hos.semi.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import hos.semi.dao.StatDAO;
import hos.semi.dto.GoalDTO;
import hos.semi.dto.IosDTO;

public class StatService {

	HttpServletRequest request = null;
	HttpServletResponse response = null;

	public StatService(HttpServletRequest request, 
			HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	//일평균지출 막대그래프 
		public void statStick() throws ServletException, IOException {
			String memberId=(String) request.getSession().getAttribute("loginId");
			
			String tabIdx = request.getParameter("tabIdx"); //재필이가 보내주는 값
		 
		//막대그래프 연산 : 특정 단위기간동안의 지출의 합을 특정 단위기간으로 나눈 목록5개
		//	String memberId = "admin";
		//	String tabIdx = "1";
			ArrayList<Float> resultList = new ArrayList<Float>(); //전체 연산 결과를 담을 리스트
			ArrayList<GoalDTO> subjectList = new ArrayList<GoalDTO>();
			
			
			//0. 특정 단위기간을 찾아냄(1~5개)
			StatDAO dao = null ;
			dao = new StatDAO();
			ArrayList<GoalDTO> goalList = dao.goalList(memberId,tabIdx);
			System.out.println(goalList.size());
			GoalDTO goaldto = null;
			for(int i=0;i<goalList.size();i++) {
				int goalIdx= goalList.get(i).getGoalIdx();
				
				//1. 특정단위기간에 해당하는 지출금액
				dao = new StatDAO();
				ArrayList<IosDTO> iosList = dao.iosList(goalIdx,memberId,Integer.parseInt(tabIdx));
				System.out.println("iosList:"+iosList.size());
				
				//2. 특정단위기간에 해당하는 목표기간, 단위기간제목
				dao = new StatDAO();
				goaldto = dao.goal(goalIdx);

				//단위기간 제목들을 담을 리스트
				subjectList.add(goaldto);
				
				System.out.println("goaldto:"+goaldto.getGoalSubject());
				//3. 지출금액의 합계/목표기간 = 일평균지출금액
				int sum =0;
				int idx=0;
				for(int k=0;k<iosList.size();k++) {
					sum += iosList.get(k).getIosM();
				}
				
				float avg = sum/goaldto.getGoalTerm();
				System.out.println(goaldto.getGoalTerm());
				
				resultList.add(avg);
				
			}	
			//resultList를 제대로 인식못해서 문자열로 보내기로함 (0번행을 [로 인식하는문제)
			String list ="";
			for(int i=0;i<resultList.size();i++) {
				list += resultList.get(i);
				if(i<resultList.size()-1) {
					list += "/";
				}
			}
			System.out.println(list);
			
			//단위기간 제목을 보내기 위한 리스트
			String subList ="";
			for(int k=0;k<subjectList.size();k++) {
				subList += subjectList.get(k).getGoalSubject();
				if(k<subjectList.size()-1) {
					subList += "/";
				}
			}
			
			String gList ="";
			for(int k=0;k<goalList.size();k++) {
				gList += goalList.get(k).getGoalIdx();
				if(k<goalList.size()-1) {
					gList += "/";
				}
			}
			System.out.println("gList:"+gList);
			
			/*//4. 단위기간 중 최근 5개를 출력
			
			request.setAttribute("resultList", list);
			request.setAttribute("subjectList", subList);
			
			request.setAttribute("gList", gList);
			
			RequestDispatcher dis = request.getRequestDispatcher("statistics.jsp");
			dis.forward(request, response);*/
			
			//json으로 반환
			HashMap<String, String> map = new HashMap<>();
			
			map.put("resultList", list);
			map.put("subjectList", subList);
			map.put("gList", gList);
			
			Gson json = new Gson();
			String obj = json.toJson(map);
			
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println(obj);
			System.out.println("map1:"+map);
		}
		
		//셀렉트 박스 (카테고리 그래프)
		public void ss_select() throws ServletException, IOException{

			String onselect = request.getParameter("select");
			System.out.println("onselect:"+onselect);
			
			
			StatDAO dao = new StatDAO();
			//1. 선택된 값에 따른 데이터를 받아옴.
				//1) 특정 단위기간에 해당하는 카테고리 인덱스
			ArrayList<Integer> ctgIdxList = dao.select1(onselect);
			
			dao = new StatDAO();
				//2) 특정 단위기간에 해당하는 지출금액
			ArrayList<IosDTO> iosMList = dao.select2(onselect);
			//2. 연산을 위한 클래스 생성
			Calculator cal = new Calculator();
			
			ArrayList<Integer> ctgList = new ArrayList<>();
			ArrayList<Integer> mList = new ArrayList<>();
			for(int i = 0;i<ctgIdxList.size();i++) {
				int ctgIdx = ctgIdxList.get(i);
				ctgList.add(ctgIdx);
			}	
			
			for(int i = 0;i<iosMList.size();i++) {
				int iosM = iosMList.get(i).getIosM();
				mList.add(iosM);
			}
			System.out.println("ctgList.size:"+ctgList.size());
			System.out.println("mList.size:"+mList.size());
				ArrayList <Double> avgList = cal.category(ctgList,mList,onselect);
				ArrayList <String> subList = cal.categorySub(ctgList,mList);
				
				//subList 제목을 보내기 위한 리스트
				String cSubList ="";
				for(int k=0;k<subList.size();k++) {
					cSubList += subList.get(k);
					if(k<subList.size()-1) {
						cSubList += "/";
					}
				}
				
				//avgList를 텍스트로 보내기 위한 리스트
				String cAvgList ="";
				for(int k=0;k<avgList.size();k++) {
					cAvgList += avgList.get(k);
					if(k<avgList.size()-1) {
						cAvgList += "/";
					}
				}
				
				
			//================================

				String onselect2 = request.getParameter("select");
				System.out.println("onselect2:"+onselect2);
				
				//1. 선택된 값(단위기간)에 따른 데이터를 받아옴.
					//1) 특정 단위기간에 해당하는 요일정보
				StatDAO dao2 = new StatDAO();
				ArrayList<String> dayList = dao2.day(onselect2);
					//2) 특정단위기간에 해당하는 금액정보
				dao2 = new StatDAO();
				ArrayList<IosDTO> iosMList2 = dao2.select3(onselect2);
				
				//2. 연산을 위한 클래스 생성
				Calculator cal2 = new Calculator();
				
				ArrayList<String> dotwList = new ArrayList<>();
				ArrayList<Integer> mList2 = new ArrayList<>();
				for(int i = 0;i<dayList.size();i++) {
					String ctgIdx = dayList.get(i);
					dotwList.add(ctgIdx);
				}	
				
				for(int i = 0;i<iosMList2.size();i++) {
					int iosM = iosMList2.get(i).getIosM();
					mList2.add(iosM);
				}
				System.out.println("ctgList.size:"+dayList.size());
				System.out.println("mList.size:"+mList2.size());
				
					//연산결과
					ArrayList <Double> avgList2 = cal2.dotw(dayList,mList2,onselect2);
					/*ArrayList <String> subList = cal.categorySub(dayList,mList);*/
					
					//요일 이름을 보내기 위한 리스트
					String dSubList ="";
					for(int k=0;k<dayList.size();k++) {
						dSubList += dayList.get(k);
						if(k<dayList.size()-1) {
							dSubList += "/";
						}
					}
					
					//avgList를 텍스트로 보내기 위한 리스트
					String dAvgList ="";
					for(int k=0;k<avgList2.size();k++) {
						dAvgList += avgList2.get(k);
						if(k<avgList2.size()-1) {
							dAvgList += "/";
						}
					}
					
					
			//json으로 반환
			HashMap<String, String> map = new HashMap<>();
			
			map.put("cSubList", cSubList);
			map.put("cAvgList", cAvgList);
			map.put("dSubList", dSubList);
			map.put("dAvgList", dAvgList);
			Gson json = new Gson();
			String obj = json.toJson(map);
			
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println(obj);
			System.out.println("map1:"+map);
			
		}
		
		
		//메인 원형게이지차트
		public void arc() throws ServletException, IOException{
			String memberId=(String) request.getSession().getAttribute("loginId");
			String tabIdx = request.getParameter("tabIdx"); 	
			System.out.println("멤버아이디와 탭idx : "+memberId+" / "+tabIdx );
					
			//임의로 넣어준 값.
			//String memberId = "admin";
			//String tabIdx = "1";
			
			//사용자 아이디와, 탭idx에 따른 단위기간 5개 뽑아옴
			StatDAO dao = null ;
			dao = new StatDAO();
			ArrayList<GoalDTO> goalList = dao.goalList(memberId,tabIdx);
			System.out.println(goalList.size());
			GoalDTO goaldto = null;
			int goalIdx= goalList.get(0).getGoalIdx();
						
			//1. 특정단위기간에 해당하는 지출금액
			dao = new StatDAO();
			ArrayList<IosDTO> iosList = dao.iosList(goalIdx,memberId,Integer.parseInt(tabIdx));
			System.out.println("iosList:"+iosList.size());
						

			dao = new StatDAO();
			goaldto = dao.goal(goalIdx);
			
			//3. 지출금액의 합계*100/목표지출금액 = 목표지출대비 현지출퍼센트 
			int sum =0;
			int idx=0;
			for(int k=0;k<iosList.size();k++) {
				sum += iosList.get(k).getIosM();
			}

			int golLimit = goaldto.getGoalLimitM();
			
			int avg = sum*100/golLimit;
			int per = 100-avg;
						
			//json으로 반환
					HashMap<String, Object> map = new HashMap<>();
					
					map.put("avg", avg);
					map.put("golLimit", golLimit);
					map.put("sum", sum);
					map.put("per", per);
					Gson json = new Gson();
					String obj = json.toJson(map);
					
					response.setContentType("text/html; charset=UTF-8");
					response.getWriter().println(obj);
					System.out.println("map1:"+map);
		}
	
				
		//메인 이미지 띄우기 
		public void image() throws ServletException, IOException{
			String memberId=(String) request.getSession().getAttribute("loginId");
			
			String tabIdx = request.getParameter("tabIdx"); //재필이가 보내주는 값
			
			/*//임의로 넣어준 값.
			String memberId = "admin";
			String tabIdx = "1";
				*/
			//사용자 아이디와, 탭idx에 따른 단위기간 5개 뽑아옴
			StatDAO dao = null ;
			dao = new StatDAO();
			ArrayList<GoalDTO> goalList = dao.goalList(memberId,tabIdx);
			System.out.println(goalList.size());
			GoalDTO goaldto = null;
			int goalIdx= goalList.get(0).getGoalIdx();
						
			//1. 특정단위기간에 해당하는 지출금액
			dao = new StatDAO();
			ArrayList<IosDTO> iosList = dao.iosList(goalIdx,memberId,Integer.parseInt(tabIdx));
			System.out.println("iosList:"+iosList.size());
						

			dao = new StatDAO();
			goaldto = dao.goal(goalIdx);
			
			//3. 지출금액의 합계*100/목표지출금액 = 목표지출대비 현지출퍼센트 
			int sum =0;
			for(int k=0;k<iosList.size();k++) {
				sum += iosList.get(k).getIosM();
			}

			int golLimit = goaldto.getGoalLimitM();
			
			int avg = sum*100/golLimit;
			int per = 100-avg;				
			
			HashMap<String, Object> map = new HashMap<>();
			
			map.put("avg", avg);
			map.put("golLimit", golLimit);
			map.put("sum", sum);
			map.put("per", per);
			Gson json = new Gson();
			String obj = json.toJson(map);
			
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println(obj);
			System.out.println("map1:"+map);
			
			
		}
		
}

