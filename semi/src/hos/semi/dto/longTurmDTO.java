package hos.semi.dto;

import java.sql.Date;

public class longTurmDTO {
	
	private int longIdx;
	private String longSubject;
	private int longStackM;
	private int longGoalM;
	private String memberId;
	private Date longStart;
	private Date longEnd;
	private int longTerm;

	private String syear;
	private String smonth;
	private String sday;
	
	private String eyear;
	private String emonth;
	private String eday;
	
	public longTurmDTO(){
		
	}

	public int getLongIdx() {
		return longIdx;
	}

	public String getLongSubject() {
		return longSubject;
	}

	public int getLongStackM() {
		return longStackM;
	}

	public int getLongGoalM() {
		return longGoalM;
	}

	public String getMemberId() {
		return memberId;
	}

	public Date getLongStart() {
		return longStart;
	}

	public Date getLongEnd() {
		return longEnd;
	}

	public int getLongTerm() {
		return longTerm;
	}

	public void setLongIdx(int longIdx) {
		this.longIdx = longIdx;
	}

	public void setLongSubject(String longSubject) {
		this.longSubject = longSubject;
	}

	public void setLongStackM(int longStackM) {
		this.longStackM = longStackM;
	}

	public void setLongGoalM(int longGoalM) {
		this.longGoalM = longGoalM;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public void setLongStart(Date longStart) {
		this.longStart = longStart;
	}

	public void setLongEnd(Date longEnd) {
		this.longEnd = longEnd;
	}

	public void setLongTerm(int longTerm) {
		this.longTerm = longTerm;
	}

	public String getSyear() {
		return syear;
	}

	public String getSmonth() {
		return smonth;
	}

	public String getSday() {
		return sday;
	}

	public String getEyear() {
		return eyear;
	}

	public String getEmonth() {
		return emonth;
	}

	public String getEday() {
		return eday;
	}

	public void setSyear(String syear) {
		this.syear = syear;
	}

	public void setSmonth(String smonth) {
		this.smonth = smonth;
	}

	public void setSday(String sday) {
		this.sday = sday;
	}

	public void setEyear(String eyear) {
		this.eyear = eyear;
	}

	public void setEmonth(String emonth) {
		this.emonth = emonth;
	}

	public void setEday(String eday) {
		this.eday = eday;
	}
	
	

}
