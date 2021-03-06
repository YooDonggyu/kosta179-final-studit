package org.kosta.studit.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.studit.model.PagingBean;
import org.kosta.studit.model.vo.GroupMemberVO;
import org.kosta.studit.model.vo.GroupVO;
import org.kosta.studit.model.vo.MemberVO;
import org.kosta.studit.model.vo.MemoVO;
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
		int groupNo = 1;
		
		GroupMemberVO groupMemberVO = new GroupMemberVO();
		groupMemberVO.setMemberVO(new MemberVO(memberEmail, null));
		groupMemberVO.setPosition("팀장");
		GroupVO groupVO = new GroupVO();
		groupVO.setGroupNo(groupNo);
		groupMemberVO.setGroupVO(groupVO);
		groupDAO.registerStudyGroupMember(groupMemberVO);
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
	//@Test
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
	//@Test
	public void updateGroupMemberPositionTest() {
		Map<String,String> map = new HashMap<>();
		map.put("position", "팀장");
		map.put("groupMemberNo", "1");
		groupDAO.updateGroupMemberPosition(map);
	}
	
	/**
	 * 스터디 그룹 즐겨찾기 상태 변경 테스트
	 * @author 김유란
	 */
	//@Test
	public void updateGroupMemberStateTest() {
		Map<String,String> map=new HashMap<>();
		map.put("state", "true");
		map.put("groupMemberNo", "1");
		groupDAO.updateGroupMemberState(map);
	}
	
	/**
	 * 그룹 번호로 스터디 그룹 정보 조회 테스트
	 * @author 김유란
	 */
	//@Test
	public void findStudyGroupInfoByStudyGroupNoTest() {
		System.out.println(groupDAO.findStudyGroupInfoByStudyGroupNo("1"));
	}
	
	/**
	 * 승인된 신청자 번호 조회 테스트
	 * @author 김유란
	 */
	//@Test
	public void findConfirmedConditionNoByGroupNoTest() {
		System.out.println(groupDAO.findConfirmedConditionNoByRecruitPostNo("1"));
	}
	
	//@Test
	public void updateGroupNameTest() {
		Map<String,String> map=new HashMap<>();
		map.put("name", "바꾼 이름");
		map.put("groupNo", "15");
		groupDAO.updateGroupName(map);
	}
	
	//@Test
	public void findTotalCountOfGroupPost() {
		Map<String, Object> map=new HashMap<>();
		map.put("keyword", "스터디");
		map.put("name", null);
		map.put("sgNo", 3);
		System.out.println(groupDAO.findTotalCountOfGroupPost(map));
	}
	
	//@Test
	public void findPostCountOfMemberByStudyGroup() {
		List<Map<String, Object>> list=groupDAO.findPostCountOfMemberByStudyGroup("3");
		if(list!=null) {
			System.out.println(list.get(0));
		}else {
			System.out.println("NULL");
		}
	}
	
   /**
	 * 스터디 그룹 칸반 메모 받아오는 테스트
	 * @author 변태섭
	 */
	//@Test
	public void findStudyGroupMemoByStudyGroupNoTest() {
		int groupNo =1;
		System.out.println(groupDAO.findStudyGroupMemoByStudyGroupNo(groupNo));
	}
	
	//@Test
	public void registerStudyGroupMemoTest() {
		MemoVO memoVO = new MemoVO();
		memoVO.setColor("warning");
		memoVO.setPosition("todo");
		memoVO.setSgNo(1);
		memoVO.setContent("이 테스트 하고 잘꺼야 ㅠ");
		groupDAO.registerStudyGroupMemo(memoVO);
		System.out.println(groupDAO.findStudyGroupMemoByStudyGroupNo(1));
	}
	
	@Test
	public void findStudyGroupMemoCountByGroupNoTest() {
		System.out.println(groupDAO.findStudyGroupMemoCountByGroupNo("12"));
	}
}
