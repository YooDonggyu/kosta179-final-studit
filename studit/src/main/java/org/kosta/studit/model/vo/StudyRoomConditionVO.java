package org.kosta.studit.model.vo;

public class StudyRoomConditionVO {
	private int studyRoomConditionNo;
	private String useDate;
	private String regDate;
	private String startTime;
	private String endTime;
	private String state;
	private MemberVO memberVO; //FK
	private StudyRoomVO studyRoomVO; //FK
	public StudyRoomConditionVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public StudyRoomConditionVO(int studyRoomConditionNo, String useDate, String regDate, String startTime,
			String endTime, String state, MemberVO memberVO, StudyRoomVO studyRoomVO) {
		super();
		this.studyRoomConditionNo = studyRoomConditionNo;
		this.useDate = useDate;
		this.regDate = regDate;
		this.startTime = startTime;
		this.endTime = endTime;
		this.state = state;
		this.memberVO = memberVO;
		this.studyRoomVO = studyRoomVO;
	}
	public int getStudyRoomConditionNo() {
		return studyRoomConditionNo;
	}
	public void setStudyRoomConditionNo(int studyRoomConditionNo) {
		this.studyRoomConditionNo = studyRoomConditionNo;
	}
	public String getUseDate() {
		return useDate;
	}
	public void setUseDate(String useDate) {
		this.useDate = useDate;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	public StudyRoomVO getStudyRoomVO() {
		return studyRoomVO;
	}
	public void setStudyRoomVO(StudyRoomVO studyRoomVO) {
		this.studyRoomVO = studyRoomVO;
	}
	@Override
	public String toString() {
		return "StudyRoomConditionVO [studyRoomConditionNo=" + studyRoomConditionNo + ", useDate=" + useDate
				+ ", regDate=" + regDate + ", startTime=" + startTime + ", endTime=" + endTime + ", state=" + state
				+ ", memberVO=" + memberVO + ", studyRoomVO=" + studyRoomVO + "]";
	}
	
	
	
}
