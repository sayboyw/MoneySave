package hos.semi.dto;

import java.sql.Date;

public class GoalDTO {
	private int goalIdx;
	private String goalSubject;
	private int goalLimitM;
	private Date goalStart;
	private Date goalEnd;
	private int goalTerm;
	private String memberId;
	private int tabIdx;
	private String tabSubject;
	private String statrtYear;
	private String statrtMonth;
	private String statrtDay;
	private String endtYear;
	private String endMonth;
	private String endDay;
	
	public int getGoalIdx() {
		return goalIdx;
	}
	public String getGoalSubject() {
		return goalSubject;
	}
	public int getGoalLimitM() {
		return goalLimitM;
	}
	public Date getGoalStart() {
		return goalStart;
	}
	public Date getGoalEnd() {
		return goalEnd;
	}
	public int getGoalTerm() {
		return goalTerm;
	}
	public String getMemberId() {
		return memberId;
	}
	public int gettabIdx() {
		return tabIdx;
	}
	public String getTabSubject() {
		return tabSubject;
	}
	public String getStatrtYear() {
		return statrtYear;
	}
	public String getStatrtMonth() {
		return statrtMonth;
	}
	public String getStatrtDay() {
		return statrtDay;
	}
	public String getEndtYear() {
		return endtYear;
	}
	public String getEndMonth() {
		return endMonth;
	}
	public String getEndDay() {
		return endDay;
	}
	public void setGoalIdx(int goalIdx) {
		this.goalIdx = goalIdx;
	}
	public void setGoalSubject(String goalSubject) {
		this.goalSubject = goalSubject;
	}
	public void setGoalLimitM(int goalLimitM) {
		this.goalLimitM = goalLimitM;
	}
	public void setGoalStart(Date goalStart) {
		this.goalStart = goalStart;
	}
	public void setGoalEnd(Date goalEnd) {
		this.goalEnd = goalEnd;
	}
	public void setGoalTerm(int goalTerm) {
		this.goalTerm = goalTerm;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public void settabIdx(int tabIdx) {
		this.tabIdx = tabIdx;
	}
	public void setTabSubject(String tabSubject) {
		this.tabSubject = tabSubject;
	}
	public void setStatrtYear(String statrtYear) {
		this.statrtYear = statrtYear;
	}
	public void setStatrtMonth(String statrtMonth) {
		this.statrtMonth = statrtMonth;
	}
	public void setStatrtDay(String statrtDay) {
		this.statrtDay = statrtDay;
	}
	public void setEndtYear(String endtYear) {
		this.endtYear = endtYear;
	}
	public void setEndMonth(String endMonth) {
		this.endMonth = endMonth;
	}
	public void setEndDay(String endDay) {
		this.endDay = endDay;
	}
	
}
