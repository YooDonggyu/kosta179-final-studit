package org.kosta.studit.model.vo;

public class RecruitPostVO {
	private int recruitPostNo;
	private String title;
	private String content;
	private String regdate;
	private int hit;
	private int capacity;
	private String location;
	private String condition;
	private MemberVO memberVO; // FK
	private SmallCategoryVO smallCategoryVO;// FK

	public RecruitPostVO() {
		super();
	}

	public RecruitPostVO(String title, String content, int capacity, String location, int smallCategory_no) {
		super();
		this.title = title;
		this.content = content;
		this.capacity = capacity;
		this.location = location;
		this.smallCategoryVO = new SmallCategoryVO(smallCategory_no);
	}

	public RecruitPostVO(int recruitPostNo, String title, String content, int capacity, String location) {
		super();
		this.recruitPostNo = recruitPostNo;
		this.title = title;
		this.content = content;
		this.capacity = capacity;
		this.location = location;
	}

	public RecruitPostVO(int recruitPostNo, String title, String content, String regdate, int hit, int capacity,
			String location, String condition, MemberVO memberVO, SmallCategoryVO smallCategoryVO) {
		super();
		this.recruitPostNo = recruitPostNo;
		this.title = title;
		this.content = content;
		this.regdate = regdate;
		this.hit = hit;
		this.capacity = capacity;
		this.location = location;
		this.condition = condition;
		this.memberVO = memberVO;
		this.smallCategoryVO = smallCategoryVO;
	}

	public RecruitPostVO(int recruitPostNo) {
		super();
		this.recruitPostNo = recruitPostNo;
	}

	public int getRecruitPostNo() {
		return recruitPostNo;
	}

	public void setRecruitPostNo(int recruitPostNo) {
		this.recruitPostNo = recruitPostNo;
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

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public int getCapacity() {
		return capacity;
	}

	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public MemberVO getMemberVO() {
		return memberVO;
	}

	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}

	public SmallCategoryVO getSmallCategoryVO() {
		return smallCategoryVO;
	}

	public void setSmallCategoryVO(SmallCategoryVO smallCategoryVO) {
		this.smallCategoryVO = smallCategoryVO;
	}

	@Override
	public String toString() {
		return "RecruitPostVO [recruitPostNo=" + recruitPostNo + ", title=" + title + ", content=" + content
				+ ", regdate=" + regdate + ", hit=" + hit + ", capacity=" + capacity + ", location=" + location
				+ ", condition=" + condition + ", memberVO=" + memberVO + ", smallCategoryVO=" + smallCategoryVO + "]";
	}

}
