package org.kosta.studit.model.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring-model.xml" })
public class StudyRoomServiceTest {

	@Autowired
	private StudyRoomService studyRoomService;
	
	/**
	 * 스터디룸 예약현황 정보 조회 테스트
	 * @author 김유란
	 */
	@Test
	public void findStudyRoomConditionByStudyRoomNoAndDateTest() {
		System.out.println(studyRoomService.findStudyRoomConditionByStudyRoomNoAndDate("2018-05-31", "1"));
	}
	
	/**
	 * 스터디룸 예약 신청 취소
	 * @author 김유란
	 */
	@Test
	public void updateStudyRoomConditionByMember() {
		studyRoomService.updateStudyRoomConditionByMember("a@a.com", "25");
	}
}
