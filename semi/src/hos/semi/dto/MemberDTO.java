package hos.semi.dto;

public class MemberDTO {

	//이곳에서의 변수명은 db테이블의 컬럼명과 동일해야함
			private String memberid;
			private String memberpw;
			private String memberName;
			private String memberPhone;
			private String memberEmail;
			private String memberGender;
			private int memberTabNum;
			private int admin;
	
	
	public MemberDTO(String id, String pw, String name, String phone, String email, String gender) {
		this.memberid=id;
		this.memberpw=pw;
		this.memberName=name;
		this.memberPhone=phone;
		this.memberEmail=email;
		this.memberGender=gender;
	}


	public MemberDTO() {
		
	}


	public String getMemberid() {
		return memberid;
	}


	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}


	public String getMemberpw() {
		return memberpw;
	}


	public void setMemberpw(String memberpw) {
		this.memberpw = memberpw;
	}


	public String getMemberName() {
		return memberName;
	}


	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}


	public String getMemberPhone() {
		return memberPhone;
	}


	public void setMemberPhone(String memberPhone) {
		this.memberPhone = memberPhone;
	}


	public String getMemberEmail() {
		return memberEmail;
	}


	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}


	public String getMemberGender() {
		return memberGender;
	}


	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}


	public int getMemberTabNum() {
		return memberTabNum;
	}


	public void setMemberTabNum(int memberTabNum) {
		this.memberTabNum = memberTabNum;
	}


	public int getAdmin() {
		return admin;
	}


	public void setAdmin(int admin) {
		this.admin = admin;
	}
		
		
		
		
		
		
		
		
		
		
}
