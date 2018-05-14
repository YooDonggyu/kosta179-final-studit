package org.kosta.studit.model.vo;

public class StudyRoomConditionVO {
	private int studyRoomConditionNo;
	private String useDate;
	private String startTime;
	private String endTime;
	private String state;
	private MemberVO memberVO; //FK
	private StudyRoomVO studyRoomVO; //FK
	
}
