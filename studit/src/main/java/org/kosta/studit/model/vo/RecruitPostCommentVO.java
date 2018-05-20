package org.kosta.studit.model.vo;

public class RecruitPostCommentVO {
	private int recruitCommentNo;
	private String content;
	private String name;
	private String regdate;
	private RecruitPostVO recruitPostVO; //FK
	public RecruitPostCommentVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RecruitPostCommentVO(int recruitCommentNo, String content, String name, String regdate,
			RecruitPostVO recruitPostVO) {
		super();
		this.recruitCommentNo = recruitCommentNo;
		this.content = content;
		this.name = name;
		this.regdate = regdate;
		this.recruitPostVO = recruitPostVO;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	@Override
	public String toString() {
		return "RecruitPostCommentVO [recruitCommentNo=" + recruitCommentNo + ", content=" + content + ", name=" + name
				+ ", regdate=" + regdate + ", recruitPostVO=" + recruitPostVO + "]";
	}
	
}
