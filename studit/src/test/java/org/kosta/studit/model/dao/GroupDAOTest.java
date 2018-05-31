package org.kosta.studit.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.studit.model.PagingBean;
import org.kosta.studit.model.vo.GroupMemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring-model.xml" })
public class GroupDAOTest {
	@Autowired
	private GroupDAO groupDAO;

	/**
	 * 본인이 팀장인 스터디 그룹의 수.
	 * @author 송용준
	 */
	//@Test
	public void findMyLeadStudyGroupCountByEmailTest() {
		int count = groupDAO.findMyLeadStudyGroupCountByEmail("a@a.com");
		System.out.println(count);
	}

	/**
	 * 본인이 팀장인 스터디 그룹 중 팀원을 가진 스터디 그룹 수.
	 * @author 송용준
	 */
	//@Test
	public void findMyLeadGroupHasMemberByEmailTest() {
		//본인이 팀장인 스터드 그룹 중 팀원을 가진 스터디 그룹 정보 리스트
		List<Map<String, Object>> countList = groupDAO.findMyLeadGroupHasMemberByEmail("a@a.com");
		
		for (Map<String, Object> member : countList) {
			System.out.println(member.get("SG_NO"));
			System.out.println(member.get("MEMBERCOUNT"));
			System.out.println(member.get("CONDITION"));
		}
	}

	/**
	 * 스터디 그룹을 생성 : 스터디 모집글의 등록과 동시에 동작
	 * @author 송용준
	 */
	//@Test
	public void createStudyGroupTest() {
		// 모집글 작성자의 이름 : 스터디 그룹의 디폴트 이름
		String memberName = "아이유";
		// 등록하는 모집글의 번호
		int recruitPostNo = 4;

		HashMap<String, Object> createStudyGroupInfo = new HashMap<>();
		createStudyGroupInfo.put("memberName", memberName);
		createStudyGroupInfo.put("recruitPostNo", recruitPostNo);
		groupDAO.createStudyGroup(createStudyGroupInfo);
	}

	/**
	 * 스터디 그룹에 맴버를 등록
	 * @author 송용준
	 */
	//@Test
	public void registerStudyGroupMemberTest() {
		// 모집글 작성자의 이름 : 디폴트는 팀장
		String memberEmail = "a@a.com";
		// 맴버를 추가할 스터디 그룹 번호
		int studyGroupNo = 6;
		
		HashMap<String, Object> registerStudyGroupMemberInfo = new HashMap<>();
		registerStudyGroupMemberInfo.put("memberEmail", memberEmail);
		registerStudyGroupMemberInfo.put("groupPosition", "팀장");
		registerStudyGroupMemberInfo.put("studyGroupNo", studyGroupNo);
		groupDAO.registerStudyGroupMember(registerStudyGroupMemberInfo);
	}
	
	
	/**
	 * 해당 스터디 모집글의 스터디 그룹 번호를 조회
	 * @author 송용준
	 */
	//@Test
	public void findStudyGroupNoByRecruitPostNoTest() {
		//조회할 스터디 그룹과 연결된 모집글 번호
		int recruitPostNo = 4;
		
		int studyGroupNo = groupDAO.findStudyGroupNoByRecruitPostNo(recruitPostNo);
		System.out.println(studyGroupNo);
	}

	
	/**
	 * 회원이메일로 회원이 속한 스터디 그룹 정보 조회
	 * @author 김유란
	 */
	//@Test
	public void findStudyGroupByMemberEmailTest() {
		List<GroupMemberVO> list = groupDAO.findStudyGroupByMemberEmail("b@b.com");
		for(GroupMemberVO vo : list) {
			System.out.println(vo);
		}
	}
	
	/**
	 * 스터디 그룹에 속한 멤버 조회
	 * @author 김유란
	 */
	@Test
	public void findGroupMemberByGroupNoTest() {
		PagingBean pagingBean = new PagingBean(groupDAO.findGroupMemberCountByGroupNo("1"));
		Map<String,Object> map = new HashMap<>();
		map.put("pagingBean", pagingBean);
		map.put("groupNo", "1");
		List<GroupMemberVO> list = groupDAO.findGroupMemberByGroupNo(map);
		for(GroupMemberVO vo : list) {
			System.out.println(vo);
		}
	}
	
	/**
	 * 스터디 그룹 멤버 직책 변경
	 * @author 김유란
	 */
	@Test
	public void updateGroupMemberPositionTest() {
		Map<String,String> map = new HashMap<>();
		map.put("position", "팀장");
		map.put("groupMemberNo", "1");
		groupDAO.updateGroupMemberPosition(map);
	}
	
	
}
