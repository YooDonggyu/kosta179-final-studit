package org.kosta.studit.model.vo;

public class GroupMemberVO {
	private int groupMemberNo;
	private String position;
	private String state;
	private MemberVO memberVO;
	private GroupVO groupVO; // FK

	public GroupMemberVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public GroupMemberVO(int groupMemberNo, String position, String state, MemberVO memberVO, GroupVO groupVO) {
		super();
		this.groupMemberNo = groupMemberNo;
		this.position = position;
		this.state = state;
		this.memberVO = memberVO;
		this.groupVO = groupVO;
	}

	public int getGroupMemberNo() {
		return groupMemberNo;
	}

	public void setGroupMemberNo(int groupMemberNo) {
		this.groupMemberNo = groupMemberNo;
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

	public MemberVO getMemberVO() {
		return memberVO;
	}

	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}

	public GroupVO getGroupVO() {
		return groupVO;
	}

	public void setGroupVO(GroupVO groupVO) {
		this.groupVO = groupVO;
	}

	@Override
	public String toString() {
		return "GroupMemberVO [groupMemberNo=" + groupMemberNo + ", position=" + position + ", state=" + state
				+ ", memberVO=" + memberVO + ", groupVO=" + groupVO + "]";
	}

}
