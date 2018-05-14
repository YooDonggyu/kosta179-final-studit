package org.kosta.studit.model.vo;

public class StudyConditionVO {
	private int studyConditionNo;
	private String regdate;
	private String state;
	private String selfAppeal;
	private MemberVO memberVO; //FK
	private RecruitPostVO recruitPostVO; //FK
}
