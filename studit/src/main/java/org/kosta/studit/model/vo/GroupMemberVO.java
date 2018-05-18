package org.kosta.studit.model.vo;

public class GroupMemberVO {
	private int groupMemberNo;
	private String email;
	private String position;
	private String state;
	private GroupVO groupVO; //FK
	
	public GroupMemberVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public GroupMemberVO(int groupMemberNo, String email, String position, String state, GroupVO groupVO) {
		super();
		this.groupMemberNo = groupMemberNo;
		this.email = email;
		this.position = position;
		this.state = state;
		this.groupVO = groupVO;
	}
	public int getGroupMemberNo() {
		return groupMemberNo;
	}
	public void setGroupMemberNo(int groupMemberNo) {
		this.groupMemberNo = groupMemberNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public GroupVO getGroupVO() {
		return groupVO;
	}
	public void setGroupVO(GroupVO groupVO) {
		this.groupVO = groupVO;
	}
	@Override
	public String toString() {
		return "GroupMemberVO [groupMemberNo=" + groupMemberNo + ", email=" + email + ", position=" + position
				+ ", state=" + state + ", groupVO=" + groupVO + "]";
	}
	
}
