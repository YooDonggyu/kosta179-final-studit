package org.kosta.studit.model.vo;

public class RecruitPostCommentVO {
	private int recruitCommentNo;
	private String content;
	private String regdate;
	private RecruitPostVO recruitPostVO; //FK
	private MemberVO memberVO;//FK
	public RecruitPostCommentVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RecruitPostCommentVO(int recruitCommentNo, String content, String regdate, RecruitPostVO recruitPostVO,
			MemberVO memberVO) {
		super();
		this.recruitCommentNo = recruitCommentNo;
		this.content = content;
		this.regdate = regdate;
		this.recruitPostVO = recruitPostVO;
		this.memberVO = memberVO;
	}
	public int getRecruitCommentNo() {
		return recruitCommentNo;
	}
	public void setRecruitCommentNo(int recruitCommentNo) {
		this.recruitCommentNo = recruitCommentNo;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public RecruitPostVO getRecruitPostVO() {
		return recruitPostVO;
	}
	public void setRecruitPostVO(RecruitPostVO recruitPostVO) {
		this.recruitPostVO = recruitPostVO;
	}
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	@Override
	public String toString() {
		return "RecruitPostCommentVO [recruitCommentNo=" + recruitCommentNo + ", content=" + content + ", regdate="
				+ regdate + ", recruitPostVO=" + recruitPostVO + ", memberVO=" + memberVO + "]";
	}
	
	
	
}
