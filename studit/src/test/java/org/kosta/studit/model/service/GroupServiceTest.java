package org.kosta.studit.model.service;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.studit.model.dao.RecruitDAO;
import org.kosta.studit.model.vo.GroupPostListVO;
import org.kosta.studit.model.vo.RecruitPostVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring-model.xml" })
public class GroupServiceTest {

	@Autowired
	private GroupService groupService;
	@Autowired
	private RecruitDAO recruitDAO;

	

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
	
	//@Test
	public void updateRecruitConditionTest() {
		groupService.updateRecruitCondition("1");
	}
	
	//@Test
	public void createAdditionalRecruitTest() {
		RecruitPostVO recruitPostVO = recruitDAO.findDetailRecruitPostAndCategoryByRecruitNo(12);
		String[] day= {"월", "화", "수"};
		groupService.createAdditionalRecruit(recruitPostVO, day);
		
		
	}
	
	@Test
	public void updateGroupNameTest() {
		groupService.updateGroupName("7", "또바꿈");
	}
	
	@Test
	public void findGroupBoard() {
		Map<String, Object> map=new HashMap<>();
		map.put("sgNo", 3);
		GroupPostListVO glist=groupService.findGroupBoard(map);
		for(int i=0; i<glist.getList().size(); i++) {
			System.out.println(glist.getList().get(i).getTitle());
			System.out.println("------------------");
			System.out.println(glist.getList().get(i).getGroupMemberVO().getMemberVO().getName());
			
		}
	}
	
}









