package org.kosta.studit.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.studit.model.PagingBean;
import org.kosta.studit.model.vo.StudyConditionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring-model.xml"})
public class RecruitDAOTest {
	@Autowired
	RecruitDAO recruitDAO;
	
	/**
	 * 신청한 스터디 중 승인대기중인 스터디 수를 확인.
	 * @author 송용준
	 */
	@Test
	public void findWaitStudyByEmail() {
		System.out.println(recruitDAO.findWaitStudyByEmail("c@c.com"));
	}
	
	/**
	 * 회원의 스터디 신청 현황을 받아오는 메서드
	 * @author 변태섭
	 */
	//@Test
	public void findStudyConditionByMemberEmail() {
		String memberEmail = "test@a.com";
		PagingBean pb = new PagingBean(recruitDAO.findCountStudyConditionByMemberEmail(memberEmail));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberEmail", memberEmail);
		map.put("pb", pb);
		
		List<StudyConditionVO> list=recruitDAO.findStudyConditionByMemberEmail(map);
		for(StudyConditionVO scVO : list) {
			System.out.println(scVO);
		}
		System.out.println("**********************************************************************");
		for(StudyConditionVO scVO : list) {
			System.out.println("No: "+scVO.getStudyConditionNo()
					+", Category: "+scVO.getRecruitPostVO().getSmallCategoryVO().getName()
					+", Location: "+scVO.getRecruitPostVO().getLocation()
					+", Title: "+scVO.getRecruitPostVO().getTitle()
					+", Writer: "+scVO.getMemberVO().getName()
					+", regDate: "+scVO.getRegdate()
					+", Status: "+scVO.getState()
					);
		}
	}
	
	/**
	 * 스터디 신청 내역을 가져오는 메서드
	 * 
	 * @author 변태섭
	 */
	@Test
	public void findCountStudyConditionByMemberEmail() {
		System.out.println("스터디 내역 개수: "+recruitDAO.findCountStudyConditionByMemberEmail("test@a.com"));
	}
}
