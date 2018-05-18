package org.kosta.studit.model.vo;

public class SmallCategoryVO {
	private int smallCategoryNo;
	private String name;
	private BigCategoryVO bigCategoryVO;//FK
	public SmallCategoryVO() {
		super();
	}
	public SmallCategoryVO(int smallCategoryNo, String name, BigCategoryVO bigCategoryVO) {
		super();
		this.smallCategoryNo = smallCategoryNo;
		this.name = name;
		this.bigCategoryVO = bigCategoryVO;
	}
	public int getSmallCategoryNo() {
		return smallCategoryNo;
	}
	public void setSmallCategoryNo(int smallCategoryNo) {
		this.smallCategoryNo = smallCategoryNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public BigCategoryVO getBigCategoryVO() {
		return bigCategoryVO;
	}
	public void setBigCategoryVO(BigCategoryVO bigCategoryVO) {
		this.bigCategoryVO = bigCategoryVO;
	}
	@Override
	public String toString() {
		return "SmallCategoryVO [smallCategoryNo=" + smallCategoryNo + ", name=" + name + ", bigCategoryVO="
				+ bigCategoryVO + "]";
	}
}
