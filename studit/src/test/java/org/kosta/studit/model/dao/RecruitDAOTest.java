package org.kosta.studit.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.studit.model.PagingBean;
import org.kosta.studit.model.vo.RecruitPostVO;
import org.kosta.studit.model.vo.SmallCategoryVO;
import org.kosta.studit.model.vo.StudyConditionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring-model.xml" })
public class RecruitDAOTest {
	@Autowired
	RecruitDAO recruitDAO;

/**
	 * 신청한 스터디 중 승인대기중인 스터디 수를 확인.
	 * 
	 * @author 송용준
	 */
	@Test
	public void findWaitStudyByEmail() {
		System.out.println(recruitDAO.findWaitStudyByEmail("c@c.com"));
	}

	/**
	 * 회원의 스터디 신청 현황을 받아오는 메서드
	 * 
	 * @author 변태섭
	 */ 
	@Test
	public void findStudyConditionByMemberEmail() {
		String memberEmail = "test@a.com";
		PagingBean pb = new PagingBean(recruitDAO.findCountStudyConditionByMemberEmail(memberEmail));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberEmail", memberEmail);
		map.put("pb", pb);

		List<StudyConditionVO> list = recruitDAO.findStudyConditionByMemberEmail(map);
		for (StudyConditionVO scVO : list) {
			System.out.println(scVO);
		}
		System.out.println("**********************************************************************");
		for (StudyConditionVO scVO : list) {
			System.out.println("No: " + scVO.getStudyConditionNo() + ", Category: "
					+ scVO.getRecruitPostVO().getSmallCategoryVO().getName() + ", Location: "
					+ scVO.getRecruitPostVO().getLocation() + ", Title: " + scVO.getRecruitPostVO().getTitle()
					+ ", Writer: " + scVO.getMemberVO().getName() + ", regDate: " + scVO.getRegdate() + ", Status: "
					+ scVO.getState());
		}
	}

	/**
	 * 스터디 신청 내역을 가져오는 메서드
	 * 
	 * @author 변태섭
	 */
	@Test
	public void findCountStudyConditionByMemberEmail() {
		System.out.println("스터디 내역 개수: " + recruitDAO.findCountStudyConditionByMemberEmail("test@a.com"));
	}

	/**
	 * 스터디 신청이 되는지 확인하는 test
	 * 
	 * @author 이승수
	 */
	@Test
	public void registerRecruitStudy() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("recruitPostNo", 2);
		map.put("memberEmail", "j@k.com");
		map.put("context", "자기소개");
		recruitDAO.registerRecruitStudy(map);
	}

	/**
	 * 스터디 모집글 번호로 스터디 그룹에 멤버를 찾는 메소드 테스트
	 * 
	 * @author 이승수
	 */
	@Test
	public void findGroupMemberByRecruitPostNo() {
		System.out.println(recruitDAO.findGroupMemberByRecruitPostNo(2));
	}

	@Test
	public void updateRecruitStudy() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("recruitPostNo", 1);
		map.put("memberEmail", "a@a.com");
		map.put("context", "자기소개");
		recruitDAO.updateRecruitStudy(map);
	}

	@Test
	public void findStudyConditionStateByEmailAndRecruitNo() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("recruitNo", 1);
		map.put("memberEmail", "b@b.com");
		System.out.println(recruitDAO.findStudyConditionCountByEmailAndRecruitNo(map));
	}

	/**
	 * 대분류 불러오기 TEST.
	 * 
	 * @author 김유란
	 */
	@Test
	public void getBigCategoryList() {
		System.out.println(recruitDAO.getBigCategoryList());
	}

	/**
	 * 소분류 불러오기 TEST.
	 * 
	 * @author 김유란
	 */
	@Test
	public void findSmallCategoryList() {
		List<SmallCategoryVO> list = recruitDAO.findSmallCategoryListByBigCategoryNo("1");
		for (SmallCategoryVO vo : list) {
			System.out.println(vo);
		}
	}

	/**
	 * 전체 모집글 수 불러오기 TEST.
	 * 
	 * @author 김유란
	 */
	@Test
	public void getTotalRecruitPostCount() {
		System.out.println(recruitDAO.getTotalRecruitPostCount());
	}

	/**
	 * 전체 모집글 목록 불러오기 TEST.
	 * 
	 * @author 김유란
	 */
	@Test
	public void getRecruitPostList() {
		PagingBean pagingBean = new PagingBean(23);
		List<RecruitPostVO> list = recruitDAO.getRecruitPostList(pagingBean);
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i));
		}
	}

	/**
	 * 모집글 검색 결과 수 불러오기 TEST.
	 * 
	 * @author 김유란
	 */
	@Test
	public void findRecruitPostContByCategoryAndKeyword() {
		List<String> categorylist = new ArrayList<>();
		categorylist.add("1");
		categorylist.add("2");
		categorylist.add("3");
		Map<String, Object> map = new HashMap<>();
		map.put("keyword", "강남");
		map.put("category", null);
		System.out.println(recruitDAO.findRecruitPostCountByCategoryAndKeyword(map));
	}

	/**
	    * 모집글 검색 결과 목록 불러오기 TEST.
	    * @author 김유란
	    */
	@Test
	public void findRecruitPostByCategoryAndKeyword(){
		List<String> categorylist = new ArrayList<>();
		categorylist.add("1");
		categorylist.add("2");
		categorylist.add("3");
		Map<String, Object> map = new HashMap<>();
		map.put("keyword", "강남");
		map.put("category", null);
		map.put("pagingBean", new PagingBean(30, 1));
		//pagingBean
		List<RecruitPostVO> postList = recruitDAO.findRecruitPostByCategoryAndKeyword(map);
		for(int i=0; i<postList.size(); i++) {
			System.out.println(postList.get(i));
		}
	}

	

}
