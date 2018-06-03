package org.kosta.studit.model.vo;

public class GroupPostVO {
	private int groupPostNo;
	private String title;
	private String content;
	private String regdate;
	private String hit;
	private GroupMemberVO groupMemberVO;
	private GroupVO groupVO; //FK
	
	public GroupPostVO() {
		super();
	}
	
	public GroupPostVO(String title, String content, GroupMemberVO groupMemberVO, GroupVO groupVO) {
		super();
		this.title = title;
		this.content = content;
		this.groupMemberVO = groupMemberVO;
		this.groupVO = groupVO;
	}



	public GroupPostVO(String title, String regdate, String hit, GroupMemberVO groupMemberVO) {
		super();
		this.title = title;
		this.regdate = regdate;
		this.hit = hit;
		this.groupMemberVO = groupMemberVO;
	}
	
	public GroupPostVO(int groupPostNo, String title, String regdate, String hit, GroupMemberVO groupMemberVO) {
		super();
		this.groupPostNo = groupPostNo;
		this.title = title;
		this.regdate = regdate;
		this.hit = hit;
		this.groupMemberVO = groupMemberVO;
	}

	public GroupPostVO(int groupPostNo, String title, String content, String regdate, String hit,
			GroupMemberVO groupMemberVO, GroupVO groupVO) {
		super();
		this.groupPostNo = groupPostNo;
		this.title = title;
		this.content = content;
		this.regdate = regdate;
		this.hit = hit;
		this.groupMemberVO = groupMemberVO;
		this.groupVO = groupVO;
	}
	public int getGroupPostNo() {
		return groupPostNo;
	}
	public void setGroupPostNo(int groupPostNo) {
		this.groupPostNo = groupPostNo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public String getHit() {
		return hit;
	}
	public void setHit(String hit) {
		this.hit = hit;
	}
	public GroupMemberVO getGroupMemberVO() {
		return groupMemberVO;
	}
	public void setGroupMemberVO(GroupMemberVO groupMemberVO) {
		this.groupMemberVO = groupMemberVO;
	}
	public GroupVO getGroupVO() {
		return groupVO;
	}
	public void setGroupVO(GroupVO groupVO) {
		this.groupVO = groupVO;
	}
	@Override
	public String toString() {
		return "GroupPostVO [groupPostNo=" + groupPostNo + ", title=" + title + ", content=" + content + ", regdate="
				+ regdate + ", hit=" + hit + ", groupMemberVO=" + groupMemberVO + ", groupVO=" + groupVO + "]";
	}
	
}
