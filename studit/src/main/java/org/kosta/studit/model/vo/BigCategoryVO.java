package org.kosta.studit.model.vo;

public class BigCategoryVO {
	private int bigCategoryNo;
	private String name;

	public BigCategoryVO() {
		super();

	}

	public BigCategoryVO(int bigCategoryNo, String name) {
		super();
		this.bigCategoryNo = bigCategoryNo;
		this.name = name;
	}

	public int getBigCategoryNo() {
		return bigCategoryNo;
	}

	public void setBigCategoryNo(int bigCategoryNo) {
		this.bigCategoryNo = bigCategoryNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "BigCategoryVO [bigCategoryNo=" + bigCategoryNo + ", name=" + name + "]";
	}

}
