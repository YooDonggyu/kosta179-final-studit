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
	 * @author 송용준
	 */
	//@Test
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
	 * @author 변태섭
	 */
	//@Test
	public void findCountStudyConditionByMemberEmail() {
		System.out.println("스터디 내역 개수: " + recruitDAO.findCountStudyConditionByMemberEmail("test@a.com"));
	}

	/**
	 * 스터디 신청이 되는지 확인하는 test
	 * @author 이승수
	 */
	//@Test
	public void registerRecruitStudy() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("recruitPostNo", 2);
		map.put("memberEmail", "j@k.com");
		map.put("context", "자기소개");
		recruitDAO.registerRecruitStudy(map);
	}

	/**
	 * 스터디 모집글 번호로 스터디 그룹에 멤버를 찾는 메소드 테스트
	 * @author 이승수
	 */
	//@Test
	public void findGroupMemberByRecruitPostNo() {
		System.out.println(recruitDAO.findGroupMemberByRecruitPostNo(2));
	}

	//@Test
	public void updateRecruitStudy() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("recruitPostNo", 1);
		map.put("memberEmail", "a@a.com");
		map.put("context", "자기소개");
		recruitDAO.updateRecruitStudy(map);
	}

	/**
	 * 대분류 불러오기 TEST.
	 * 
	 * @author 김유란
	 */
	//@Test
	public void getBigCategoryList() {
		System.out.println(recruitDAO.getBigCategoryList());
	}

	/**
	 * 소분류 불러오기 TEST.
	 * 
	 * @author 김유란
	 */
	//@Test
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
	//@Test
	public void getTotalRecruitPostCount() {
		System.out.println(recruitDAO.getTotalRecruitPostCount());
	}

	/**
	 * 전체 모집글 목록 불러오기 TEST.
	 * 
	 * @author 김유란
	 */
	//@Test
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
	//@Test
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
	//@Test
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
	

	   /**
	    * 모집 게시글 번호를 이용하여 게시글 내용과 카테고리 내용 검색 TEST
	    * @author 유동규
	    */
	   //@Test
	   public void findDetailRecruitPostAndCategoryByRecruitNoTest() {
		   System.out.println(recruitDAO.findDetailRecruitPostAndCategoryByRecruitNo(4));
	   }
	   
	   /**
	    * 모집 게시글 번호에 따른 희망 요일 검색 TEST
	    * @author 유동규
	    */
	   //@Test
	   public void findDayByRecruitNoTest() {
			   System.out.println(recruitDAO.findDayByRecruitNo(1));
	   }
	   
	   
	   /**
	    * 모집 게시글 번호에 따른 댓글 검색 TEST
	    * @author 유동규
	    */
	   //@Test
	   public void findRecruitCommentByRecruitNoTest() {
		   System.out.println(recruitDAO.findRecruitCommentByRecruitNo(1));
	   }
	   /**
	    * 모집 게시글에 대한 조회수 증가 TEST
	    * @author 유동규
	    */
	   //@Test
	   public void updateRecruitPostHitByRecruitNoTest() {
		   recruitDAO.updateRecruitPostHitByRecruitNo(1);
		   System.out.println(recruitDAO.findDetailRecruitPostAndCategoryByRecruitNo(1));
	   }
	   
	   
	   /**
	    * 조회수 증가를 위해 게시글 작성자 PK 검색 TEST
	    * @author 유동규
	    */
	   //@Test
	   public void findRecruitWriterByRecruitNoTest() {
		   System.out.println(recruitDAO.findRecruitWriterByRecruitNo(1));
	   }
	   
	   /**
	    * 이메일과 모집 게시글 번호를 이용해 study_condition에 등록된 상태 가져오기
	    * @author 유동규
	    */
	   //@Test
	   public void findStudyConditionStateByEmailAndRecruitNo() {
		   Map<String, Object> map = new HashMap<>();
		   map.put("memberEmail", "d@d.com");
		   map.put("recruitNo", 1);
		   System.out.println(recruitDAO.findStudyConditionStateByEmailAndRecruitNo(map));
	   }
	   
	   /**
	    * 모집 게시글번호에 따른 소분류 변경 TEST
	    * @author 유동규
	    */
	   //@Test
	   public void updateSmallCategoryNoByRecruitNoTest() {
		   //update
		   Map<String, Integer> map = new HashMap<>();
		   map.put("smallCategoryNo", 2);
		   map.put("recruitNo", 1);
		   recruitDAO.updateSmallCategoryNoByRecruitNo(map);
		   
		   //select
		  System.out.println(recruitDAO.findDetailRecruitPostAndCategoryByRecruitNo(1));
	   }
	
	   /**
	    * 모집 게시글 번호에 따른 내용 변경 TEST
	    * @author 유동규
	    */
	   //@Test
	   public void updateRecruitPostByRecruitNoTest() {
		   //변경내용
		   RecruitPostVO recruitPostVO = new RecruitPostVO(1, "제목변경", "내용 변경", 3, "지역변경");
		   recruitDAO.updateRecruitPostByRecruitNo(recruitPostVO);
		   
		   //조회
		   System.out.println(recruitDAO.findDetailRecruitPostAndCategoryByRecruitNo(1));
		   
	   }
	   /**
	    * 변경할 요일을 삭제한 후 다시 등록하는 TEST
	    * @author 유동규
	    */
	  //@Test
	   public void deleteAndinsertDayTest() {
		   //삭제
		   recruitDAO.deleteDayByRecruitNo(1);
		   
		   //등록
		   Map<String, Object> map = new HashMap<>();
		   map.put("recruitPostNo", 1);
		   map.put("recruitDay", "월요일");
		   recruitDAO.registerRecruitDay(map);
		   
		   //조회
		   System.out.println(recruitDAO.findDayByRecruitNo(1));
	   }
	   
	   /**
	    * 모집중 -> 삭제로 변경
	    * @author 유동규
	    */
	   //@Test
	   public void updateDeleteStudyConditionByRecruitNoTest() {
		   recruitDAO.updateDeleteStudyConditionByRecruitNo(1);
	   }
	   
	

}
