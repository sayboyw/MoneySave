package hos.semi.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import hos.semi.dto.MemberDTO;

public class MemberDAO {

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs =null;
	
	public MemberDAO() {
		
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
		//로그인
		public boolean login(String id, String pw) {
			String sql = "SELECT memberid FROM member_tb WHERE memberid=? and memberpw=?";
			boolean success=false;
			
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, id);
				ps.setString(2, pw);
				rs = ps.executeQuery();
				success = rs.next();	//rs.next()의 값은 true,false
			} catch (SQLException e) {
				e.printStackTrace();
				return success;
			}finally {
			
				try {
					rs.close();
					ps.close();
					conn.close();
				} catch (SQLException e) {}
				
			}
			System.out.println("dao에서 리턴할 값 : "+success );
			return success;
		}
		//ID중복확인
		public boolean overlay(String id) {
			System.out.println("아이디중복확인 함수 실행");
			boolean over = false;
			
			String sql="SELECT memberid FROM member_tb WHERE memberid=?";
			
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, id);
				rs = ps.executeQuery();
				over=rs.next();
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
			System.out.println("dao에서 내보낼 over 값 : "+over);
			return over;
		}
		//회원가입
		public int join(MemberDTO memdto) {
			System.out.println("join 시작");
			int success=0;
			String sql=" insert into member_tb"
					+ "(memberid,memberpw,membername,memberphone,memberemail,membergender) values(?,?,?,?,?,?)";
			
			try {
				ps =conn.prepareStatement(sql);
				ps.setString(1, memdto.getMemberid());
				ps.setString(2, memdto.getMemberpw());
				ps.setString(3, memdto.getMemberName());
				ps.setString(4, memdto.getMemberPhone());
				ps.setString(5, memdto.getMemberEmail());
				ps.setString(6, memdto.getMemberGender());
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
			System.out.println("반환할 success값 : "+success);
		return success;
	}
		//멤버 - 회원탈퇴
		public int memberDel(String id,String pw) {
			System.out.println("memberDel 시작");
			int success = 0;
			String pwchk="";
			String sql = "SELECT memberpw FROM member_tb WHERE memberid=?";
			
			try {
				ps=conn.prepareStatement(sql);
				ps.setString(1,id);
				rs=ps.executeQuery();
				
				if(rs.next()) {
					pwchk=rs.getString("memberpw");
					if(pwchk.equals(pw)) {
						//비밀번호가 일치하면 회원삭제 진행
						String delsql = "DELETE FROM member_tb WHERE memberid=?";
						ps=conn.prepareStatement(delsql);
						ps.setString(1,id);
						success = ps.executeUpdate();
					}
					
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				try {
					rs.close();
					ps.close();
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
			System.out.println("회원삭제성공여부 1|0 : " +success);
			return success;
		}	
		
		//회원정보보기
		public MemberDTO memView(String id) {
			System.out.println("memView 시작");
			MemberDTO dto =null;
			String sql = "SELECT memberid,memberpw,membername,memberphone,memberemail"
					+ " FROM member_tb WHERE memberid=?";
			try {
				ps = conn.prepareStatement(sql);
				System.out.println(ps);
				ps.setString(1,id);
				rs=ps.executeQuery();

				if(rs.next()) {
					dto = new MemberDTO();
					dto.setMemberid(rs.getString("memberid"));
					dto.setMemberpw(rs.getString("memberpw"));
					System.out.println("받아온 비밀번호"+rs.getString("memberpw"));
					dto.setMemberName(rs.getString("membername"));
					dto.setMemberPhone(rs.getString("memberphone"));
					dto.setMemberEmail(rs.getString("memberemail"));
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
		//회원정보 수정하기
		public MemberDTO memUpdate(String id, String pw, String name, String phone, String email) {
			System.out.println("memUpdate 시작");
			int success=0;
			MemberDTO dto =null;
			String sql = "UPDATE member_tb SET memberpw=?,membername=?,memberphone=?,memberemail=? WHERE memberid=?";
			try {
				ps = conn.prepareStatement(sql);
				System.out.println(ps);
				ps.setString(1,pw);
				ps.setString(2,name);
				ps.setString(3,phone);
				ps.setString(4,email);
				ps.setString(5,id);
				success= ps.executeUpdate();
				
				if(success==1) {
					sql = "SELECT memberid,memberpw,membername,memberphone,memberemail"
							+ " FROM member_tb WHERE memberid=?";
					ps=conn.prepareStatement(sql);
					ps.setString(1, id);
					rs=ps.executeQuery();
					
					if(rs.next()) {
						dto = new MemberDTO();
						dto.setMemberid(rs.getString("memberid"));
						dto.setMemberpw(rs.getString("memberpw"));
						System.out.println("바뀐 비밀번호 :"+rs.getString("memberpw"));
						dto.setMemberName(rs.getString("membername"));
						dto.setMemberPhone(rs.getString("memberphone"));
						dto.setMemberEmail(rs.getString("memberemail"));
					}
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
			return dto;
		}
		//관리자 - 회원탈퇴
		public int adminDel(String id) {
			System.out.println("관리자-회원탈퇴 시작");
			int success=0;
			String sql= "DELETE FROM member_tb WHERE memberid=?";
			try {
				ps=conn.prepareStatement(sql);
				ps.setString(1,id);
				success=ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			System.out.println("dao에서 success값 : "+success);
			return success;
		}
		
		//관리자-회원정보 불러오기
		public ArrayList<MemberDTO> memberList() {
			ArrayList<MemberDTO> list = new ArrayList<MemberDTO>();
			String sql = "SELECT memberId,memberPw,memberName,memberPhone,memberEmail From member_tb WHERE admin=0";
			try {
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				
				while(rs.next()) {
					MemberDTO dto = new MemberDTO();
					dto.setMemberid(rs.getString("memberId"));
					dto.setMemberpw(rs.getString("memberPw"));
					dto.setMemberName(rs.getString("memberName"));
					dto.setMemberPhone(rs.getString("memberPhone"));
					dto.setMemberEmail(rs.getString("memberEmail"));
					list.add(dto);	
				}
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					rs.close();
					ps.close();
					conn.close();
				} catch (SQLException e) {}
			}
			
			return list;
		}
		
		//관리자여부 확인
		public int adminconfirm(String id) {
			int result =0;
			//0 : 일반회원 1 : 관리자
			String sql = "SELECT admin FROM member_tb WHERE memberid=?";
			
			try {
				ps=conn.prepareStatement(sql);
				ps.setString(1,id);
				rs=ps.executeQuery();
				if(rs.next()) {
					System.out.println(rs.getInt("admin"));
					if(rs.getInt("admin")==0) {
						result=0;
					}else {
						result=1;
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					rs.close();
					ps.close();
					conn.close();
				} catch (SQLException e) {}
			}
			System.out.println("result 변수 값 : "+result);
			return result;
			
			
		}
		
}

			
