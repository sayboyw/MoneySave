package hos.semi.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import hos.semi.dto.CalDTO;
import hos.semi.dto.CategoryDTO;
import hos.semi.dto.GoalDTO;

public class CalDAO {

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	// 객체화 시 바로 DB 연결
	public CalDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 지출 내역 리스트 가져오기
		public ArrayList<CalDTO> outcomelist(int tabIdx, Date clickDate2, String memberId) {
			
			ArrayList<CalDTO> appList1 = new ArrayList<CalDTO>();
			
			String sql1 = "SELECT iosIdx, ctgIdx, iosSubject, iosM, iosMemo, iosDate FROM ios_tb "
					+ "WHERE iosSel = 0 AND tabIdx =? AND memberId =? AND iosDate = ?";
			
			try {
				ps = conn.prepareStatement(sql1);
				ps.setInt(1, tabIdx);
				ps.setString(2, memberId);
				ps.setDate(3, clickDate2);
				rs = ps.executeQuery();
				
				while(rs.next()) {
					CalDTO calDTO = new CalDTO();
					calDTO.setIosIdx(rs.getInt("iosIdx"));
					calDTO.setCtgIdx(rs.getInt("ctgIdx"));
					calDTO.setIosSubject(rs.getString("iosSubject"));
					calDTO.setIosM(rs.getInt("iosM"));
					calDTO.setIosMemo(rs.getString("iosMemo"));
					calDTO.setIosDate(rs.getDate("iosDate"));
					System.out.println("지출 dao : "+calDTO.getIosSubject());
					appList1.add(calDTO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					rs.close();
					ps.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			System.out.println("지출 데이터 보냄 : "+appList1.size());
			return appList1;
		}

		// 수입 내역 리스트
				public ArrayList<CalDTO> incomelist(int tabIdx, Date clickDate2, String memberId) {
					ArrayList<CalDTO> appList2 = new ArrayList<CalDTO>();

					String sql = "SELECT iosIdx, ctgIdx, iosSubject, iosM, iosMemo, iosDate FROM ios_tb "
							+ "WHERE iosSel = 1 AND tabIdx =? AND memberId =? AND iosDate = ?";
					
					try {
						ps = conn.prepareStatement(sql);
						ps.setInt(1, tabIdx);
						ps.setString(2, memberId);
						ps.setDate(3, clickDate2);
						rs = ps.executeQuery();
						
						while(rs.next()) {
							CalDTO calDTO = new CalDTO();
							calDTO.setIosIdx(rs.getInt("iosIdx"));
							calDTO.setCtgIdx(rs.getInt("ctgIdx"));
							calDTO.setIosSubject(rs.getString("iosSubject"));
							calDTO.setIosM(rs.getInt("iosM"));
							calDTO.setIosMemo(rs.getString("iosMemo"));
							System.out.println("수입 dao : "+calDTO.getIosSubject());
							appList2.add(calDTO);
						}
					} catch (SQLException e) {
						e.printStackTrace();
					} finally {
						try {
							rs.close();
							ps.close();
							conn.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
					System.out.println("수입 데이터 보냄 : "+appList2.size());
					return appList2;
				}

				// 데이터 수정할 것 가져오기
				public CalDTO update(String iosIdx) {
					CalDTO ca_dto = new CalDTO();
					String sql = "SELECT iosSel, ctgIdx, iosSubject, iosM, iosMemo, iosDate, iosIdx FROM ios_tb WHERE iosIdx = ?";
					try {
						ps = conn.prepareStatement(sql);
						ps.setInt(1, Integer.parseInt(iosIdx));
						rs = ps.executeQuery();
						
						while(rs.next()) {
							ca_dto.setIosSel(rs.getInt("iosSel"));
							ca_dto.setCtgIdx(rs.getInt("ctgIdx"));
							ca_dto.setIosSubject(rs.getString("iosSubject"));
							ca_dto.setIosM(rs.getInt("iosM"));
							ca_dto.setIosMemo(rs.getString("iosMemo"));
							ca_dto.setIosDate(rs.getDate("iosDate"));
							ca_dto.setIosIdx(rs.getInt("iosIdx"));
						}
						System.out.println("ca_dto.getIosIdx() : "+ca_dto.getIosIdx());
					} catch (SQLException e) {
						e.printStackTrace();
					} finally {
						try {
							rs.close();
							ps.close();
							conn.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
					return ca_dto;
				}

				// 수입,지출내역 삭제
				public int delete(String iosIdx) {
					int success = 0;
					String sql = "DELETE FROM ios_tb WHERE iosIdx = ?";
					try {
						ps = conn.prepareStatement(sql);
						ps.setInt(1, Integer.parseInt(iosIdx));
						success = ps.executeUpdate();
					} catch (SQLException e) {
						e.printStackTrace();
					} finally {
						try {
							ps.close();
							conn.close();
						} catch (SQLException e) {}
					}
					return success;
				}

				//카테고리 리스트 호출 위해 DB접속
				public ArrayList<CategoryDTO> ca_addCa(int addCategory) {
					
					ArrayList<CategoryDTO> cal_ctgList = new ArrayList<CategoryDTO>();
					String sql = "SELECT ctgSub, ctgIdx FROM ctg_tb WHERE ctgIOS = ?";
					
					try {
						ps = conn.prepareStatement(sql);
						ps.setInt(1, addCategory);
						rs = ps.executeQuery();
						
						while(rs.next()){
							CategoryDTO dto = new CategoryDTO();
							dto.setCtgSub(rs.getString("ctgSub"));
							dto.setCtgIdx(rs.getInt("ctgIdx"));
							cal_ctgList.add(dto);
						}
						System.out.println("CategoryDAO(); ca_addCa(); cal_ctgList : "+cal_ctgList);
					} catch (SQLException e) {
						e.printStackTrace();
						return null;
					}finally{
						try {
							rs.close();
							ps.close();
							conn.close();
						} catch (SQLException e) {}
					}

					return cal_ctgList;
				}
				
				public int pickGoalIdx(Date iosDate) {
					
					String sql = "SELECT goalIdx FROM goal_tb WHERE goalStart <= ? AND goalEnd >= ?";
					int goalIdx = 0;
					
					try {
						ps = conn.prepareStatement(sql);
						ps.setDate(1, iosDate);
						ps.setDate(2, iosDate);
						rs = ps.executeQuery();
						if(rs.next()){
							goalIdx = rs.getInt("goalIdx");
						}
						System.out.println("goalIdx : "+goalIdx);
					} catch (Exception e) {
						e.printStackTrace();
					}finally{
						try {
							rs.close();
							ps.close();
							conn.close();
						} catch (SQLException e) {}
					}
					return goalIdx;
				}

/*				public int pickGoalIdx(Date goalStart) {
					
					String sql = "SELECT goalIdx FROM goal_tb WHERE goalStart = ?";
					int goalIdx = 0;
					
					try {
						ps = conn.prepareStatement(sql);
						ps.setDate(1, goalStart);
						rs = ps.executeQuery();
						if(rs.next()) {
							goalIdx = rs.getInt("goalIdx");
						}
					} catch (SQLException e) {
						e.printStackTrace();
					}finally {
						try {
							rs.close();
							ps.close();
							conn.close();
						} catch (SQLException e) {}
					}
					return goalIdx;
				}*/

				// 데이터 추가
				public int calAdd(CalDTO dto) {
					
					String sql = "INSERT INTO ios_tb VALUES(ios_seq.NEXTVAL,?,?,?,?,?,?,?,?,?,?)";
					
					int success = 0;
					
					try {
						ps = conn.prepareStatement(sql);
						ps.setInt(1, dto.getIosSel());
						ps.setInt(2, dto.getCtgIdx());
						ps.setString(3, dto.getIosSubject());
						ps.setInt(4, dto.getIosM());
						if(dto.getIosMemo() != null) {
							ps.setString(5, dto.getIosMemo());
						}
						ps.setDate(6, dto.getIosDate());
						ps.setString(7, dto.getIosDOTW());
						ps.setInt(8, dto.getTabIdx());
						ps.setString(9, dto.getMemberId());
						ps.setInt(10, dto.getGoalIdx());
						
						success = ps.executeUpdate();
						
					} catch (SQLException e) {
						e.printStackTrace();
						return 0;
					}finally {
						try {
							ps.close();
							conn.close();
						} catch (SQLException e) {}
					}
					return success;
				}

				// 데이터 수정
				public int ca_upDB(CalDTO dto) {
					
					String sql = "UPDATE ios_tb SET iosSel=?, ctgIdx=?, iosSubject=?, iosM=?, iosMemo=?, iosDate=?, "
							+ "iosDOTW=?, tabIdx=?, memberId=?, goalIdx=? WHERE iosIdx = ?";
					
					int success = 0;
					
					try {
						ps = conn.prepareStatement(sql);
						ps.setInt(1, dto.getIosSel());
						ps.setInt(2, dto.getCtgIdx());
						ps.setString(3, dto.getIosSubject());
						ps.setInt(4, dto.getIosM());
						if(dto.getIosMemo() != null) {				//메모가 null 일때는?
							ps.setString(5, dto.getIosMemo());
						}
						ps.setDate(6, dto.getIosDate());
						ps.setString(7, dto.getIosDOTW());
						ps.setInt(8, dto.getTabIdx());
						ps.setString(9, dto.getMemberId());
						ps.setInt(10, dto.getGoalIdx());
						ps.setInt(11, dto.getIosIdx());
						
						success = ps.executeUpdate();
						
					} catch (SQLException e) {
						e.printStackTrace();
						return 0;
					}finally {
						try {
							ps.close();
							conn.close();
						} catch (SQLException e) {}
					}
					return success;
				}

				// 지출 토글 버튼
				public ArrayList<CalDTO> outcomeShow(String tabIdx, String clickYear, String clickMonth, String memberId) {
					System.out.println("dao에 들어옴");
					String sql = "SELECT iosM, iosDate FROM ios_tb WHERE memberId=? AND tabIdx=? AND iosSel = 0";
					ArrayList<CalDTO> iosMList = new ArrayList<CalDTO>();
					try {
						System.out.println("try 내부");
						ps = conn.prepareStatement(sql);
						ps.setString(1, memberId);
						ps.setInt(2, Integer.parseInt(tabIdx));
						System.out.println(memberId+tabIdx);
						rs = ps.executeQuery();
						//System.out.println("이거 진짜 : "+rs.next());
						while(rs.next()) {
						Date outDate = rs.getDate("iosDate");
							SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
							String stDate = fmt.format(outDate);
							System.out.println("뽑힌 날짜 : "+stDate);
						
							
						String[] date = stDate.split("-");
							System.out.println(date[0]+" / "+clickYear+" / "+date[1]+" / "+clickMonth+" / "+date[2]);
							
							if(date[0].equals(clickYear) && date[1].equals(clickMonth)) {
								System.out.println("syso");
								CalDTO dto = new CalDTO();
								dto.setIosM(rs.getInt("iosM"));
								dto.setShowDate(Integer.parseInt(date[2]));
								iosMList.add(dto);
							}
						
						}

						//System.out.println(iosMList.get(0).getIosM());
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
					return iosMList;
				}

				// 수입 토글 버튼
				public ArrayList<CalDTO> incomeShow(String tabIdx, String clickYear, String clickMonth, String memberId) {
					String sql = "SELECT iosM, iosDate FROM ios_tb WHERE memberId=? AND tabIdx=? AND iosSel = 1";
					
					ArrayList<CalDTO> iosMList = new ArrayList<CalDTO>();
					try {
						ps = conn.prepareStatement(sql);
						ps.setString(1, memberId);
						ps.setInt(2, Integer.parseInt(tabIdx));
						rs = ps.executeQuery();
						
						while(rs.next()) {
							Date inDate = rs.getDate("iosDate");
							SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
							String stDate = fmt.format(inDate);
							System.out.println(stDate);
							
							String[] date = stDate.split("-");
							System.out.println(date[0]+" / "+clickYear+" / "+date[1]+" / "+clickMonth+" / "+date[2]);
							
							if(date[0].equals(clickYear) && date[1].equals(clickMonth)) {
								System.out.println("syso");
								CalDTO dto = new CalDTO();
								dto.setIosM(rs.getInt("iosM"));
								dto.setShowDate(Integer.parseInt(date[2]));
								iosMList.add(dto);
							}
						}
						//System.out.println(iosMList.get(0).getIosM());
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
					return iosMList;
				}

				// 단위기간 불러오기
				public GoalDTO find(Date dtDate, String tabIdx, String memberId) {
					String sql = "SELECT goalIdx, goalSubject FROM goal_tb WHERE goalStart <= ? AND goalEnd >= ? AND tabIdx=? AND memberId=?";
					GoalDTO dto = new GoalDTO();
					
					try {
						ps = conn.prepareStatement(sql);
						ps.setDate(1, dtDate);
						ps.setDate(2, dtDate);
						ps.setInt(3, Integer.parseInt(tabIdx));
						ps.setString(4, memberId);
						rs = ps.executeQuery();
						
						while(rs.next()) {
							dto.setGoalIdx(rs.getInt("goalIdx"));
							dto.setGoalSubject(rs.getString("goalSubject"));
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
				
				public ArrayList<String> ctgSubjectCall() {
					
					ArrayList<String> ctgNames = new ArrayList<String>();
					int ctgIdx = 1;
					String sql = "SELECT ctgSub FROM ctg_tb";
					
					try {
						ps = conn.prepareStatement(sql);
						rs = ps.executeQuery();
						while(rs.next()) {
							ctgNames.add(rs.getString("ctgSub"));
						}
						System.out.println("ctgNames.get(0) : "+ctgNames.get(0));
					} catch (SQLException e) {
						e.printStackTrace();
					}finally {
						try {
							rs.close();
							ps.close();
							conn.close();
						} catch (SQLException e) {}
					}
					return ctgNames;
				}
	
				public ArrayList<CalDTO> ca_calMain1(Date today, String tabIdx, String memberId) {
					
					ArrayList<CalDTO> calMainList1 = new ArrayList<>();
					
					String sql = "SELECT * FROM("
							+ "SELECT ROWNUM as idx,iosSubject, iosM FROM("
							+ "SELECT iosSubject, iosM FROM ios_tb WHERE tabIdx=? AND memberId=? AND iosDate=? AND iosSel =0 ORDER BY iosM DESC))"
							+ "WHERE idx >= 1 AND idx <= 3";
					
					try {
						ps = conn.prepareStatement(sql);
						ps.setInt(1, Integer.parseInt(tabIdx));
						ps.setString(2, memberId);
						ps.setDate(3, today);
						rs = ps.executeQuery();
						
						while(rs.next()) {
							CalDTO dto = new CalDTO();
							dto.setIosSubject(rs.getString("iosSubject"));
							dto.setIosM(rs.getInt("iosM"));
							calMainList1.add(dto);
						}
						
					} catch (SQLException e) {
						e.printStackTrace();
					}finally {
						try {
							rs.close();
							ps.close();
							conn.close();
						} catch (SQLException e) {}
					}
					return calMainList1;
				}

				public ArrayList<CalDTO> ca_calMain2(Date today, String tabIdx, String memberId) {
					ArrayList<CalDTO> calMainList2 = new ArrayList<>();
					
					String sql = "SELECT * FROM("
							+ "SELECT ROWNUM as idx,iosSubject, iosM FROM("
							+ "SELECT iosSubject, iosM FROM ios_tb WHERE tabIdx=? AND memberId=? AND iosDate=? AND iosSel =1 ORDER BY iosM DESC))"
							+ "WHERE idx >= 1 AND idx <= 3";
					
					try {
						ps = conn.prepareStatement(sql);
						ps.setInt(1, Integer.parseInt(tabIdx));
						ps.setString(2, memberId);
						ps.setDate(3, today);
						rs = ps.executeQuery();
						
						while(rs.next()) {
							CalDTO dto = new CalDTO();
							dto.setIosSubject(rs.getString("iosSubject"));
							dto.setIosM(rs.getInt("iosM"));
							calMainList2.add(dto);
						}
						
					} catch (SQLException e) {
						e.printStackTrace();
					}finally {
						try {
							rs.close();
							ps.close();
							conn.close();
						} catch (SQLException e) {}
					}
					return calMainList2;
				}
	
	
	
	
}
