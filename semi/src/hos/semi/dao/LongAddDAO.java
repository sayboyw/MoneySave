package hos.semi.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import hos.semi.dto.longTurmDTO;

public class LongAddDAO {
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public LongAddDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int change(Date stDate2, Date edDate2) {
		System.out.println(stDate2);
		System.out.println(edDate2);

		int turm =0;
		String sql ="SELECT to_date(?,'YYYY-MM-DD') -to_date(?,'YYYY-MM-DD') FROM dual";
			
			
			try {
				ps = conn.prepareStatement(sql);
				ps.setDate(1, edDate2);
				ps.setDate(2, stDate2);
				rs = ps.executeQuery();
				
				if(rs.next()) {
					turm = rs.getInt(1);
				}
			} catch (SQLException e) {
				e.printStackTrace();
				return turm;
			}finally {
				
				try {
					rs.close();
					ps.close();
					conn.close();
				} catch (SQLException e) {}
			}
		return turm;
	}

	public int longadd(String loginId, String subject, Date stDate2, Date edDate2, String goalMoney, int term) {
		int success = 0;
		String sql = "INSERT INTO longTerm_tb VALUES(long_seq.NEXTVAL,?,0,?,?,?,?,?)";
		
				try {
					ps = conn.prepareStatement(sql);
					ps.setString(1, subject);
					ps.setInt(2, Integer.parseInt(goalMoney));
					ps.setString(3, loginId);
					ps.setDate(4, stDate2);
					ps.setDate(5, edDate2);
					ps.setInt(6, term);
					success = ps.executeUpdate();
				} catch (SQLException e) {
					e.printStackTrace();
					return success;
				}finally {
					try {
						ps.close();
						conn.close();
					} catch (SQLException e) {}
					
				}
				
		return success;
	}

	public ArrayList<longTurmDTO> longlist(String memberId) {
		
		ArrayList<longTurmDTO> longTurm = new ArrayList<longTurmDTO>();
		String sql = "SELECT *FROM longTerm_tb WHERE memberId=?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,memberId);
			rs=ps.executeQuery();
			while(rs.next()) {
				System.out.println(rs.getInt("longIdx"));
				
				longTurmDTO dto= new longTurmDTO();
				
				dto.setLongIdx(rs.getInt("longIdx"));
				dto.setLongSubject(rs.getString("longSubject"));
				dto.setLongStackM(rs.getInt("longStackM"));
				dto.setLongGoalM(rs.getInt("longGoalM"));
				dto.setMemberId(rs.getString("memberId"));
				dto.setLongStart(rs.getDate("longStart"));
				dto.setLongEnd(rs.getDate("longEnd"));
				dto.setLongTerm(rs.getInt("longTerm"));					
				longTurm.add(dto);
				System.out.println(longTurm.get(0).getLongSubject());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			ps.close();
			conn.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(longTurm);
		return longTurm;
	}

	public longTurmDTO detail(String idx) {
		
		longTurmDTO dto = null;
		String sql="SELECT * FROM longTerm_tb WHERE longIdx=?";
			
			try {
				ps = conn.prepareStatement(sql);
				ps.setInt(1, Integer.parseInt(idx));
				rs = ps.executeQuery();
				
				if(rs.next()){
					dto = new longTurmDTO();
					dto.setLongIdx(rs.getInt("LongIdx"));
					dto.setLongSubject(rs.getString("longSubject"));
					dto.setLongStackM(rs.getInt("longStackM"));
					dto.setLongGoalM(rs.getInt("longGoalM"));
					dto.setMemberId(rs.getString("memberId"));
					dto.setLongStart(rs.getDate("longStart"));
					dto.setLongEnd(rs.getDate("longEnd"));
					dto.setLongTerm(rs.getInt("longTerm"));
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
				return null;
			}finally {
				try {
					rs.close();
					ps.close();
					conn.close();
				} catch (SQLException e) {}
			}
			return dto;
	}

	public int upchange(Date upstDate2, Date upedDate2) {
		System.out.println(upstDate2);
		System.out.println(upedDate2);

		int upturm =0;
		String sql ="SELECT to_date(?,'YYYY-MM-DD') -to_date(?,'YYYY-MM-DD') FROM dual";
			
			
			try {
				ps = conn.prepareStatement(sql);
				ps.setDate(1, upedDate2);
				ps.setDate(2, upstDate2);
				rs = ps.executeQuery();
				
				if(rs.next()) {
					upturm = rs.getInt(1);
				}
			} catch (SQLException e) {
				e.printStackTrace();
				return upturm;
			}finally {
				
				try {
					rs.close();
					ps.close();
					conn.close();
				} catch (SQLException e) {}
			}
		return upturm;
	}

	public int longupdate(String uplongIdx, String upsubject, Date upstDate2, Date upedDate2, String upgoalMoney,
			int upterm) {
		System.out.println(upsubject);
		System.out.println(upstDate2);
		System.out.println(upedDate2);
		System.out.println(upgoalMoney);
		System.out.println(upterm);
		
		int success = 0;
		String sql = "UPDATE longTerm_tb SET longSubject=?,longGoalM=?,longStart=?,longEnd=? WHERE longIdx=?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,upsubject);
			ps.setInt(2, Integer.parseInt(upgoalMoney));
			ps.setDate(3, upstDate2);
			ps.setDate(4, upedDate2);
			ps.setString(5, uplongIdx);
			success = ps.executeUpdate();
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
		
		return success;
	}

	public int del(int idx) {
		int success =0;
		String sql ="DELETE FROM longTerm_tb WHERE longIdx=?";
		
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1,idx);
			success = ps.executeUpdate();
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
		
		return success;
	}

	public ArrayList<longTurmDTO> ca_longTermList(String memberId) {
		
		ArrayList<longTurmDTO> longList = new ArrayList<longTurmDTO>();
		
		String sql = "SELECT * FROM longTerm_tb WHERE memberId=?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, memberId);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				longTurmDTO dto = new longTurmDTO();
				dto.setLongIdx(rs.getInt("longIdx"));
				dto.setLongSubject(rs.getString("longSubject"));
				dto.setLongStackM(rs.getInt("longStackM"));
				dto.setLongGoalM(rs.getInt("longGoalM"));
				dto.setLongStart(rs.getDate("longStart"));
				dto.setLongEnd(rs.getDate("longEnd"));
				dto.setLongTerm(rs.getInt("longTerm"));
				longList.add(dto);
			}
			//System.out.println("longList.get(0).getLongSubject() :"+longList.get(0).getLongSubject());
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				rs.close();
				ps.close();
				conn.close();
			} catch (SQLException e) {}
		}
		return longList;
	}

	public int ca_upCompl2(String memberId, String longIdx, String longStackM) {
		
		String sql = "Update longTerm_tb SET longStackM=(longStackM+?) WHERE memberId=? AND longIdx=?";
		int success = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(longStackM));
			ps.setString(2, memberId);
			ps.setInt(3, Integer.parseInt(longIdx));
			
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				ps.close();
				conn.close();
			} catch (SQLException e) {}
		}
		return success;
	}
	
	//메인 장기그래프 정보불러오기
	public ArrayList<longTurmDTO> mainLong(String memberId) {
			
			ArrayList<longTurmDTO> longTurm = new ArrayList<longTurmDTO>();
			String sql = "SELECT *FROM longTerm_tb WHERE memberId=? ORDER BY longIdx ASC";
			
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1,memberId);
				rs=ps.executeQuery();
				
				if(rs.next()) {
					System.out.println(rs.getInt("longIdx"));
					
					longTurmDTO dto= new longTurmDTO();
					
					dto.setLongIdx(rs.getInt("longIdx"));
					dto.setLongSubject(rs.getString("longSubject"));
					dto.setLongStackM(rs.getInt("longStackM"));
					dto.setLongGoalM(rs.getInt("longGoalM"));
					dto.setMemberId(rs.getString("memberId"));
					dto.setLongStart(rs.getDate("longStart"));
					dto.setLongEnd(rs.getDate("longEnd"));
					dto.setLongTerm(rs.getInt("longTerm"));						
					longTurm.add(dto);
				}
				}catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				ps.close();
				conn.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			System.out.println("-----------------------------------");
			System.out.println(longTurm);
			return longTurm;
		}


	

}
