package hos.semi.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import hos.semi.dto.CategoryDTO;
import hos.semi.dto.GoalDTO;
import hos.semi.dto.IosDTO;

public class StatDAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	public StatDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<GoalDTO> goalList(String memberId, String tabIdx) {
		String sql = "SELECT goalIdx FROM "
				+ "(SELECT ROW_NUMBER() OVER(ORDER BY goalIdx DESC) AS rnum, "
				+ "goalIdx FROM goal_tb WHERE memberId=? AND tabIdx=?)WHERE rnum BETWEEN 1 AND 5";
		
		ArrayList<GoalDTO> goalList = new ArrayList<GoalDTO>();
		
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, memberId);
			ps.setString(2, tabIdx);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				GoalDTO gdto = new GoalDTO();
				gdto.setGoalIdx(rs.getInt("goalIdx"));
				goalList.add(gdto);
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
		return goalList;
	}
	
	public ArrayList<IosDTO> iosList(int goalIdx, String memberId,int tabIdx) {
		
		ArrayList<IosDTO> iosMList = new ArrayList<IosDTO>();
		//지출쿼리 
		String sql = "SELECT * FROM ios_tb "
				+ "WHERE goalIdx=? AND memberId=? AND tabIdx=? AND iosSel=0";
		
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1, goalIdx);
			ps.setString(2, memberId);
			ps.setInt(3, tabIdx);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				IosDTO idto = new IosDTO();
				idto.setIosM(rs.getInt("iosM"));
				idto.setGoalIdx(rs.getInt("goalIdx"));
				iosMList.add(idto);
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
		return iosMList;
	}

	public GoalDTO goal(int goalIdx) {
		GoalDTO dto = new GoalDTO();
		
		String sql = "SELECT * FROM goal_tb WHERE goalIdx=?";
		
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1, goalIdx);
			rs=ps.executeQuery();
			
			if(rs.next()) {
				dto.setGoalSubject(rs.getString("goalSubject"));
				dto.setGoalTerm(rs.getInt("goalTerm"));
				dto.setGoalLimitM(rs.getInt("goalLimitM"));
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
	
	//특정 단위기간에 대한 ios테이블의 ctgIdx
	public ArrayList<Integer> select1(String onselect) {
		ArrayList<Integer> ctgIdxList = new ArrayList<>();
		IosDTO dto = null;
		String sql = "SELECT ctgIdx FROM ios_tb WHERE goalIdx=? AND iosSel=0";
		
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(onselect));
			rs=ps.executeQuery();
			System.out.println(rs);
			
			while(rs.next()) {
				dto = new IosDTO();
				dto.setCtgIdx(rs.getInt("ctgIdx"));
				//dto.setIosSubject(rs.getString("iosSubject"));
				//dto.setIosDOTW(rs.getString("iosDOTW"));
				System.out.println("dto.getCtgIdx():"+dto.getCtgIdx());
				if(!ctgIdxList.contains(dto.getCtgIdx())) {//중복제거
					ctgIdxList.add(dto.getCtgIdx());
				}
				System.out.println("ctgIdxList모양:"+ctgIdxList);	
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				rs.close();
				ps.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ctgIdxList;
	}
	
	//특정 단위기간에 대한 ios테이블의 iosM
	public ArrayList<IosDTO> select2(String onselect) {
		ArrayList<IosDTO> iosMList = new ArrayList<>();
		IosDTO dto = null;
		String sql = "SELECT iosM FROM ios_tb WHERE goalIdx=? AND iosSel=0";
		
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(onselect));
			rs=ps.executeQuery();
			System.out.println(rs);
			
			while(rs.next()) {
				dto = new IosDTO();
				dto.setIosM(rs.getInt("iosM"));
				iosMList.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				rs.close();
				ps.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return iosMList;
	}
	
	//특정 카테고리에 해당하는 지출금액 가져오기
	public ArrayList<IosDTO> ctg(int ctgIdx,String onselect) {

		ArrayList<IosDTO> mList = new ArrayList<>();
		String sql = "SELECT * FROM ios_tb WHERE ctgIdx=? AND goalIdx=? AND iosSel=0";
		
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1, ctgIdx);
			ps.setInt(2, Integer.parseInt(onselect));
			rs=ps.executeQuery();
			
			while(rs.next()) {
				IosDTO dto = new IosDTO();
				dto.setIosM(rs.getInt("iosM"));
				mList.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				rs.close();
				ps.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return mList;
	}
	
	//특정 요일에 해당하는 지출금액
			public ArrayList<IosDTO> dotwM(String day, String onselect2) {

				ArrayList<IosDTO> dotwMList = new ArrayList<>();
				String sql = "SELECT * FROM ios_tb WHERE iosDOTW=? AND goalIdx=? AND iosSel=0";
				
				try {
					ps=conn.prepareStatement(sql);
					ps.setString(1, day);
					ps.setInt(2, Integer.parseInt(onselect2));
					rs=ps.executeQuery();
					
					while(rs.next()) {
						IosDTO dto = new IosDTO();
						dto.setIosM(rs.getInt("iosM"));
						dotwMList.add(dto);
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
					return null;
				}finally {
					try {
						rs.close();
						ps.close();
						conn.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				return dotwMList;
			}
		
	public CategoryDTO ctgSub(int ctgIdx) {

		String sql = "SELECT * FROM ctg_tb WHERE ctgIdx=?";
		CategoryDTO dto = new CategoryDTO();
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1, ctgIdx);
			rs=ps.executeQuery();
			
			if(rs.next()) {
				dto.setCtgSub(rs.getString("ctgSub"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
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
	
	//단위기간에 해당하는 요일정보
	public ArrayList<String> day(String onselect2) {

		ArrayList<String> dayList = new ArrayList<>();
		IosDTO dto = null;
		String sql = "SELECT iosDOTW FROM ios_tb WHERE goalIdx=? AND iosSel=0";
		
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(onselect2));
			rs=ps.executeQuery();
			System.out.println(rs);
			
			while(rs.next()) {
				dto = new IosDTO();
				dto.setIosDOTW(rs.getString("iosDOTW"));
				System.out.println("dto.getIosDOTW():"+dto.getIosDOTW());
				if(!dayList.contains(dto.getIosDOTW())) {//중복제거
					dayList.add(dto.getIosDOTW());
				}
				System.out.println("dayList모양:"+dayList);	
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				rs.close();
				ps.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return dayList;
	}

	public ArrayList<IosDTO> select3(String onselect2) {
		ArrayList<IosDTO> iosMList = new ArrayList<>();
		IosDTO dto = null;
		String sql = "SELECT iosM FROM ios_tb WHERE goalIdx=? AND iosSel=0";
		
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(onselect2));
			rs=ps.executeQuery();
			System.out.println(rs);
			
			while(rs.next()) {
				dto = new IosDTO();
				dto.setIosM(rs.getInt("iosM"));
				iosMList.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				rs.close();
				ps.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return iosMList;
	}


}
