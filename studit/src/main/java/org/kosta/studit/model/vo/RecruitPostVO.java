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
	private MemberVO memberVO; //FK
	private SmallCategoryVO smallCategoryVO;//FK
	
}
