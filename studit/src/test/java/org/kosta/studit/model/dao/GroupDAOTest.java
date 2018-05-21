package org.kosta.studit.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
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
	// @Test
	public void findMyLeadStudyGroupCountByEmail() {
		int count = groupDAO.findMyLeadStudyGroupCountByEmail("a@a.com");
		System.out.println(count);
	}

	/**
	 * 본인이 팀장인 스터디 그룹 중 팀원을 가진 스터디 그룹 수.
	 * @author 송용준
	 */
	// @Test
	public void findMyLeadGroupHasMemberByEmail() {
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
	public void createStudyGroup() {
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
	 * 해당 스터디 모집글의 스터디 그룹 번호를 조회
	 * @author 송용준
	 */
	// @Test
	public void findStudyGroupNo() {
		//조회할 스터디 그룹과 연결된 모집글 번호
		int recruitPostNo = 4;
		
		int studyGroupNo = groupDAO.findStudyGroupNoByRecruitPostNo(recruitPostNo);
		System.out.println(studyGroupNo);
	}

	/**
	 * 스터디 그룹에 맴버를 등록
	 * @author 송용준
	 */
	@Test
	public void registerStudyGroupMember() {
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
}
