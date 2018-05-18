package org.kosta.studit.model.vo;

public class GroupVO {
	private int groupNo;
	private String name;
	private RecruitPostVO recruitPostVO;
	
	public GroupVO(int groupNo, String name, RecruitPostVO recruitPostVO) {
		super();
		this.groupNo = groupNo;
		this.name = name;
		this.recruitPostVO = recruitPostVO;
	}
	public int getGroupNo() {
		return groupNo;
	}
	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public RecruitPostVO getRecruitPostVO() {
		return recruitPostVO;
	}
	public void setRecruitPostVO(RecruitPostVO recruitPostVO) {
		this.recruitPostVO = recruitPostVO;
	}
	@Override
	public String toString() {
		return "GroupVO [groupNo=" + groupNo + ", name=" + name + ", recruitPostVO=" + recruitPostVO + "]";
	}
	
	
}
