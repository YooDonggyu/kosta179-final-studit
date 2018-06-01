package org.kosta.studit.model.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.studit.model.vo.GroupMemberVO;
import org.kosta.studit.model.vo.GroupVO;
import org.kosta.studit.model.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring-model.xml" })
public class GroupServiceTest {

	@Autowired
	private GroupService groupService;

	

	//@Test
	public void findGroupMemberByGroupNoTest() {
		System.out.println(groupService.findGroupMemberByGroupNo("1","1"));
	}
	
	//@Test
	public void updateGroupMemberPositionTest() {
		groupService.updateGroupMemberPosition("39", "1");
	}
	
	//@Test
	public void updateGroupMemberStateTest() {
		String[] checkBookmark= {"1","3"};
		groupService.updateGroupMemberState("a@a.com", checkBookmark);
	}
	
	/**
	 * 스터디 그룹 신청 상태 변경(승인/거절) 및 멤버 등록 TEST
	 * @author 김유란
	 */
	//@Test
	public void updateStudyConditionStateTest() {
		groupService.registerGroupMember("거절", "1", "1");
	}
	
	@Test
	public void updateRecruitConditionTest() {
		groupService.updateRecruitCondition("1");
	}
	
}
