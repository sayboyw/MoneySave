package hos.semi.dto;

import java.sql.Date;

public class CalDTO {

	private int iosIdx;
	private int iosSel;
	private int ctgIdx;
	
	private String iosSubject;
	private int iosM;
	private String iosMemo;
	private Date iosDate;
	private String iosDOTW;
	private int tabIdx;
	private String memberId;
	private int goalIdx;
	private int showDate;
	
	
	public int getIosIdx() {
		return iosIdx;
	}
	public int getIosSel() {
		return iosSel;
	}
	public int getCtgIdx() {
		return ctgIdx;
	}
	public String getIosSubject() {
		return iosSubject;
	}
	public int getIosM() {
		return iosM;
	}
	public String getIosMemo() {
		return iosMemo;
	}
	public Date getIosDate() {
		return iosDate;
	}
	public String getIosDOTW() {
		return iosDOTW;
	}
	public int getTabIdx() {
		return tabIdx;
	}
	public String getMemberId() {
		return memberId;
	}
	public int getGoalIdx() {
		return goalIdx;
	}
	public int getShowDate() {
		return showDate;
	}
	public void setIosIdx(int iosIdx) {
		this.iosIdx = iosIdx;
	}
	public void setIosSel(int iosSel) {
		this.iosSel = iosSel;
	}
	public void setCtgIdx(int ctgIdx) {
		this.ctgIdx = ctgIdx;
	}
	public void setIosSubject(String iosSubject) {
		this.iosSubject = iosSubject;
	}
	public void setIosM(int iosM) {
		this.iosM = iosM;
	}
	public void setIosMemo(String iosMemo) {
		this.iosMemo = iosMemo;
	}
	public void setIosDate(Date iosDate) {
		this.iosDate = iosDate;
	}
	public void setIosDOTW(String iosDOTW) {
		this.iosDOTW = iosDOTW;
	}
	public void setTabIdx(int tabIdx) {
		this.tabIdx = tabIdx;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public void setGoalIdx(int goalIdx) {
		this.goalIdx = goalIdx;
	}
	public void setShowDate(int showDate) {
		this.showDate = showDate;
	}
	
	
	
}
