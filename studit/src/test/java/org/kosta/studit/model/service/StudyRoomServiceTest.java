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
	
	@Test
	public void findStudyRoomConditionByStudyRoomNoAndDateTest() {
		System.out.println(studyRoomService.findStudyRoomConditionByStudyRoomNoAndDate("2018-05-31", "1"));
	}
}
