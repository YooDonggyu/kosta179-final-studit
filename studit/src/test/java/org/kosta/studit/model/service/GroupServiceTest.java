package org.kosta.studit.model.service;

import org.junit.Test;
import org.junit.runner.RunWith;
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
		groupService.updateGroupMemberPosition("26", "1");
	}
	
	@Test
	public void updateGroupMemberStateTest() {
		String[] checkBookmark= {"1","3"};
		groupService.updateGroupMemberState("a@a.com", checkBookmark);
	}
	
}
