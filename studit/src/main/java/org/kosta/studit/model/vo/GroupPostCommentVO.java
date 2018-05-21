package org.kosta.studit.model.vo;

public class GroupPostCommentVO {
	private int groupCommentNo;
	private String content;
	private String regdate;
	private GroupPostVO groupPostVO; //FK
	private MemberVO memberVO;//FK
	public GroupPostCommentVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public GroupPostCommentVO(int groupCommentNo, String content, String regdate, GroupPostVO groupPostVO,
			MemberVO memberVO) {
		super();
		this.groupCommentNo = groupCommentNo;
		this.content = content;
		this.regdate = regdate;
		this.groupPostVO = groupPostVO;
		this.memberVO = memberVO;
	}
	public int getGroupCommentNo() {
		return groupCommentNo;
	}
	public void setGroupCommentNo(int groupCommentNo) {
		this.groupCommentNo = groupCommentNo;
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
	public GroupPostVO getGroupPostVO() {
		return groupPostVO;
	}
	public void setGroupPostVO(GroupPostVO groupPostVO) {
		this.groupPostVO = groupPostVO;
	}
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	@Override
	public String toString() {
		return "GroupPostCommentVO [groupCommentNo=" + groupCommentNo + ", content=" + content + ", regdate=" + regdate
				+ ", groupPostVO=" + groupPostVO + ", memberVO=" + memberVO + "]";
	}
	
	
	
}
