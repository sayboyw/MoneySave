package hos.semi.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import hos.semi.dto.GoalDTO;

public class TabDAO {

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs =null;
	
	public TabDAO() {
		
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	//회원가입시 탭생성
		public int tabCreate(String id) {
			System.out.println("탭 생성 시작");
			int tabSuccess=0;
			String sql="INSERT INTO tab_tb VALUES('1','기본',?)";
			//이거하기전에 tab_tb 삭제하고 기본키 안주고 다시만들어서 해야함
			try {
				ps =conn.prepareStatement(sql);
				ps.setString(1, id);
				tabSuccess = ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				return 0;
			}finally {
				try {
					ps.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			System.out.println("탭 생성시에 반환할 success값 : "+tabSuccess);
		return tabSuccess;
			
		}

		//탭생성후 goal테이블에도 생성
		public int goalCreate(String id) {
			int goalSuccess=0;
			String sql = "INSERT INTO goal_tb values(goal_seq.NEXTVAL,'1번 단위기간',0,sysdate,sysdate,0,?,'1')";
			try {
				ps=conn.prepareStatement(sql);
				ps.setString(1, id);
				goalSuccess = ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				try {
					ps.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			System.out.println("goal탭 생성시에 반환할 success값 : "+goalSuccess);
		return goalSuccess;
		}
		
		//Term 구해오기
		public int goalTerm(Date tb_stDate, Date tb_enDate) {
			String sql = "SELECT to_date(?)-to_date(?) FROM goal_tb";
			int Term = 0;
			try {
				ps = conn.prepareStatement(sql);
				ps.setDate(1, tb_enDate);
				ps.setDate(2, tb_stDate);
				rs = ps.executeQuery();
				if(rs.next()) {
					Term = rs.getInt(1);
				}
			} catch (SQLException e) {
				e.printStackTrace();
				return 0;
			}finally {
				try {
					rs.close();
					ps.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return Term;
		}

		//탭 제목 수정
		public int jp_tabUpdate(String loginId, String tb_tabSubject, int tabIdx) {
			int success = 0;
			String sql = "UPDATE tab_tb SET tabSubject=? WHERE MEMBERID=? AND tabIdx=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, tb_tabSubject);
				ps.setString(2, loginId);
				ps.setInt(3, tabIdx);
				success = ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				return 0;
			}finally {
				try {
					ps.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			return success;
		}


		//단위기간 수정
		public int jp_goalUpdate(String loginId, int tabIdx, int goalLimitM, String tb_goalSubject, Date tb_stDate, Date tb_enDate,
				int termday) {
			int success = 0;
			String sql = "UPDATE goal_tb SET goalSubject=?, goalLimitM=?, goalStart=?, goalEnd=?, goalTerm=?"
					+ "WHERE MEMBERID=? AND tabIdx=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, tb_goalSubject);
				ps.setInt(2, goalLimitM);
				ps.setDate(3, tb_stDate);
				ps.setDate(4, tb_enDate);
				ps.setInt(5, termday);
				ps.setString(6, loginId);
				ps.setInt(7, tabIdx);
				success = ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				return 0;
			}finally {
				try {
					ps.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			System.out.println("goalAdd : "+success);
			return success;
		}

		//탭이 2개일 때 2번 생성
		public int tb_add2(String loginId, int tabIdx, int goalLimitM, String tb_goalSubject, Date tb_stDate,
				Date tb_enDate, int termday, String tb_tabSubject) {
			
			int success1 = 0;
			int success2 = 0;
			try {
				//id JJP의 tabIdx 2번으로 탭 추가
				String sql = "INSERT INTO tab_tb VALUES('2',?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1, tb_tabSubject);
				ps.setString(2, loginId);
				success1 = ps.executeUpdate(); //1 리턴
				System.out.println("success1: "+success1);
				if(success1==1) {
					//탭이 1개면 무조건 Tab1 이기 때문에 Tab2 번으로 새 탭 추가
					String sql2 = "INSERT INTO goal_tb (goalidx, goalSubject, goalLimitM, goalStart, goalEnd, goalTerm, MEMBERID, tabIdx)"
							+ "VALUES(goal_seq.NEXTVAL,?,?,?,?,?,?,'2')";
					ps = conn.prepareStatement(sql2);
					ps.setString(1, tb_goalSubject);
					ps.setInt(2, goalLimitM);
					ps.setDate(3, tb_stDate);
					ps.setDate(4, tb_enDate);
					ps.setInt(5, termday);
					ps.setString(6, loginId);
					success2 = ps.executeUpdate();
					System.out.println("tabAdd : "+success2);
				}
			} catch (SQLException e) {
				e.printStackTrace();
				return 0;
			}finally {
				try {
					ps.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return success2;
			
		}

		//탭 2개일 때 3번 생성
		public int tb_add3(String loginId, int tabIdx, int goalLimitM, String tb_goalSubject, Date tb_stDate,
				Date tb_enDate, int termday, String tb_tabSubject) {
			
			int success1 = 0;
			int success2 = 0;
			try {
				//id JJP의 tabIdx 3번으로 탭 추가
				String sql = "INSERT INTO tab_tb VALUES('3',?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1, tb_tabSubject);
				ps.setString(2, loginId);
				success1 = ps.executeUpdate(); //1 리턴
				System.out.println("success1: "+success1);
				if(success1==1) {
					String sql2 = "INSERT INTO goal_tb (goalidx, goalSubject, goalLimitM, goalStart, goalEnd, goalTerm, MEMBERID, tabIdx)"
							+ "VALUES(goal_seq.NEXTVAL,?,?,?,?,?,?,'3')";
					ps = conn.prepareStatement(sql2);
					ps.setString(1, tb_goalSubject);
					ps.setInt(2, goalLimitM);
					ps.setDate(3, tb_stDate);
					ps.setDate(4, tb_enDate);
					ps.setInt(5, termday);
					ps.setString(6, loginId);
					success2 = ps.executeUpdate();
					System.out.println("tabAdd : "+success2);
				}
			} catch (SQLException e) {
				e.printStackTrace();
				return 0;
			}finally {
				try {
					ps.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return success2;
			
		}

		//삭제 할 탭 idx 가져오기
		public int tb_num1(String loginId, int tabIdx) {
			int result = 0;
			String sql = "SELECT tabIdx FROM tab_tb WHERE tabIdx=? and memberId=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setInt(1, tabIdx);
				ps.setString(2, loginId);
				rs = ps.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
					System.out.println("tabIdx: "+result);
				}
			} catch (SQLException e) {
				e.printStackTrace();
				return 0;
			}finally {
				try {
					rs.close();
					ps.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return result;
		}

		//탭 삭제
		public int tb_TabDelete(String loginId, int tabIdx) {
			int result = 0;
			String sql = "DELETE FROM tab_tb WHERE MEMBERID=? AND tabIdx=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, loginId);
				ps.setInt(2, tabIdx);
				result = ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				return 0;
			}finally {
				try {
					ps.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return result;
		}

		//탭 삭제 후 goal_tb에 있던 데이터 값 삭제
		public int tb_goaldelete(String loginId, int tabIdx) {
			int result=0;
			String sql = "DELETE FROM goal_tb WHERE MEMBERID=? AND tabIdx=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1,loginId);
				ps.setInt(2, tabIdx);
				result = ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				return 0;
			}finally {
				try {
					ps.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return result;
		}

		//탭 삭제 후 ios_tb에 있던 데이터 값 삭제
		public int tb_iosDelete(String loginId, int tabIdx) {
			int result=0;
			String sql = "DELETE FROM ios_tb WHERE MEMBERID=? AND tabIdx=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1,loginId);
				ps.setInt(2, tabIdx);
				result = ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				return 0;
			}finally {
				try {
					ps.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return result;
		}

		//탭 띄우기
		public ArrayList<GoalDTO> tb_check(String loginId) {
			ArrayList<GoalDTO> list = new ArrayList<GoalDTO>();
			String sql = "SELECT * FROM tab_tb WHERE MEMBERID=? ORDER BY tabIdx ASC";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, loginId);
				rs = ps.executeQuery();
				while(rs.next()) {
					GoalDTO dto = new GoalDTO();
					dto.settabIdx(rs.getInt("tabIdx"));
					dto.setTabSubject(rs.getString("tabsubject"));
					list.add(dto);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				try {
					rs.close();
					ps.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			System.out.println("dao: "+list);
			return list;
		}

		//날짜 자르기
		public GoalDTO tb_day(int tabIdx, String loginId) {
			GoalDTO dto = new GoalDTO();
			String sql = "SELECT GOALSTART, GOALEND FROM goal_tb WHERE MEMBERID=? AND tabIdx=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, loginId);
				ps.setInt(2, tabIdx);
				rs = ps.executeQuery();
				while(rs.next()) {
					dto.setGoalStart(rs.getDate("goalStart"));
					dto.setGoalEnd(rs.getDate("goalEnd"));
					dto.settabIdx(tabIdx);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				try {
					rs.close();
					ps.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}	
			return dto;
		}

		//탭 구분하기
		public boolean check(String loginId, int tabIdx) {

			boolean result = false;
			String sql = "SELECT tabIdx FROM tab_tb WHERE memberid=? AND tabIdx=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, loginId);
				ps.setInt(2, tabIdx);
				rs = ps.executeQuery();
				if(rs.next()) {
					result = true;
				}
			} catch (SQLException e) {
				e.printStackTrace();
				result = false;
			}finally {
				try {
					rs.close();
					ps.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return result;
		}

		//탭 데이터 불러오기
		public ArrayList<GoalDTO> list(String loginId, int tabIdx, String tb_startYear, String tb_startMonth,
				String tb_startDay, String tb_endYear, String tb_endMonth, String tb_endDay) {
			
			ArrayList<GoalDTO> list = new ArrayList<GoalDTO>();
			/*String sql = "SELECT tabSubject FROM  TAB_TB WHERE tabIdx=?";*/
			String sql = "SELECT goalSubject, goalLimitM, goalStart, goalEnd, (SELECT tabSubject FROM TAB_TB WHERE tabIdx=? AND memberid=?) AS tabSubject FROM GOAL_TB WHERE tabIdx=? AND memberid=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setInt(1, tabIdx);
				ps.setString(2, loginId);
				ps.setInt(3, tabIdx);
				ps.setString(4, loginId);
				rs = ps.executeQuery();
				while(rs.next()) {
					GoalDTO dto = new GoalDTO();
					dto.setTabSubject(rs.getString("tabSubject"));
					dto.setGoalSubject(rs.getString("goalSubject"));
					dto.setGoalLimitM(rs.getInt("goalLimitM"));
					dto.setGoalStart(rs.getDate("goalStart"));
					dto.setGoalEnd(rs.getDate("goalEnd"));
					dto.setStatrtYear(tb_startYear);
					dto.setStatrtMonth(tb_startMonth);
					dto.setStatrtDay(tb_startDay);
					dto.setEndtYear(tb_endYear);
					dto.setEndMonth(tb_endMonth);
					dto.setEndDay(tb_endDay);
					dto.settabIdx(tabIdx);
					list.add(dto);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				try {
					rs.close();
					ps.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			}
			System.out.println("list: "+list);
			return list;
		}


		
	
		
		
}
