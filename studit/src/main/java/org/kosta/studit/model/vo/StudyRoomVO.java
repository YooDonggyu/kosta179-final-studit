package org.kosta.studit.model.vo;

public class StudyRoomVO {
	private int studyRoomNo;
	private String name;
	private String capacity;
	private String price;
	private String content;
	private CompanyVO companyVO;//FK
	public StudyRoomVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public StudyRoomVO(int studyRoomNo, String name, String capacity, String price, String content,
			CompanyVO companyVO) {
		super();
		this.studyRoomNo = studyRoomNo;
		this.name = name;
		this.capacity = capacity;
		this.price = price;
		this.content = content;
		this.companyVO = companyVO;
	}
	public int getStudyRoomNo() {
		return studyRoomNo;
	}
	public void setStudyRoomNo(int studyRoomNo) {
		this.studyRoomNo = studyRoomNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCapacity() {
		return capacity;
	}
	public void setCapacity(String capacity) {
		this.capacity = capacity;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public CompanyVO getCompanyVO() {
		return companyVO;
	}
	public void setCompanyVO(CompanyVO companyVO) {
		this.companyVO = companyVO;
	}
	@Override
	public String toString() {
		return "StudyRoomVO [studyRoomNo=" + studyRoomNo + ", name=" + name + ", capacity=" + capacity + ", price="
				+ price + ", content=" + content + ", companyVO=" + companyVO + "]";
	}
	
	
	
}
