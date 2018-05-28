package org.kosta.studit.model.vo;

public class StudyConditionVO {
	
	private int studyConditionNo;
	private String regdate;
	private String state;
	private String selfAppeal;
	private MemberVO memberVO; //FK
	private RecruitPostVO recruitPostVO; //FK
	public StudyConditionVO() {
		super();
	}
	public StudyConditionVO(int studyConditionNo, String regdate, String state, String selfAppeal, MemberVO memberVO,
			RecruitPostVO recruitPostVO) {
		super();
		this.studyConditionNo = studyConditionNo;
		this.regdate = regdate;
		this.state = state;
		this.selfAppeal = selfAppeal;
		this.memberVO = memberVO;
		this.recruitPostVO = recruitPostVO;
	}
	public int getStudyConditionNo() {
		return studyConditionNo;
	}
	public void setStudyConditionNo(int studyConditionNo) {
		this.studyConditionNo = studyConditionNo;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getSelfAppeal() {
		return selfAppeal;
	}
	public void setSelfAppeal(String selfAppeal) {
		this.selfAppeal = selfAppeal;
	}
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	public RecruitPostVO getRecruitPostVO() {
		return recruitPostVO;
	}
	public void setRecruitPostVO(RecruitPostVO recruitPostVO) {
		this.recruitPostVO = recruitPostVO;
	}
	@Override
	public String toString() {
		return "StudyConditionVO [studyConditionNo=" + studyConditionNo + ", regdate=" + regdate + ", state=" + state
				+ ", selfAppeal=" + selfAppeal + ", memberVO=" + memberVO + ", recruitPostVO=" + recruitPostVO + "]";
	}
}
