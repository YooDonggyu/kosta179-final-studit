package org.kosta.studit.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.studit.model.vo.RecruitPostVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring-model.xml" })
public class RecruitServiceTest {
	@Autowired
	private RecruitService recruitService;

	/**
	 * 스터디를 신청 테스트
	 * @author 이승수
	 */
	//@Test
	public void registerRecruitStudyTest() {
		recruitService.registerRecruitStudy(2, "j@k.com", "자기소개냐??");
	}
	
	/**
	 * 스터디신청시 이미 거절상태일때 다시 미승인 상태로 바꿔주는 메서드 테스트
	 * @author 이승수
	 */
	//@Test
	public void updateRecruitStudyTest() {
		recruitService.updateRecruitStudy(2, "b@b.com", "다시 신청합니다");
	}


	/**
	 * 검색된 모집글 목록 가져오기 확인 TEST.
	 * @author 김유란
	 */
	//@Test
/*	public void findRecruitPostByCategoryAndKeywordTest() {
		String category[] = { "1", "2", "3" };
		List<RecruitPostVO> list = recruitService.findRecruitPostByCategoryAndKeyword(null, "강남", "1")
				.getRecruitPostList();
		for (RecruitPostVO vo : list) {
			System.out.println(vo);
		}
	}*/
	
	/**
	 * 모집 게시글 번호에 따른 정보 가져오기 TEST
	 * @author 유동규
	 */
	//@Test
	public void findRecruitPostDetailByRecruitNoTest() {
		System.out.println(recruitService.findRecruitPostDetailByRecruitNo("",1).get("comment"));
		System.out.println(recruitService.findRecruitPostDetailByRecruitNo("",1).get("day"));
		System.out.println(((RecruitPostVO)recruitService.findRecruitPostDetailByRecruitNo("",1).get("detail")));
		System.out.println(recruitService.findRecruitPostDetailByRecruitNo("d@d.com",1).get("studyState"));
	}
	
	
	//@Test
	public void findRecruitPostByCategoryAndKeywordTest() {
		Map<String, Object> map = new HashMap<>();
		List<Integer> list = new ArrayList<>();
/*		list.add(1);
		list.add(2);
		list.add(3);*/
		//map.put("bigCategoryNo", 1);
		map.put("smallCategoryNo", list);
		/*String keyword = "";
		map.put("keyword", keyword);
		*//*
		int totalCnt = recruitDAO.findRecruitPostCountByCategoryOrKeyword(map);
		System.out.println("totalCnt=="+totalCnt);
		PagingBean pb = new PagingBean(totalCnt, 1);
		Map<String, Object> dataMap = new HashMap<>();
		dataMap.put("pb", pb);
		dataMap.put("dataMap", map);
		List<RecruitPostVO> rrList =recruitDAO.findRecruitPostByPagingBean(dataMap);
		for(int i =0; i<rrList.size(); i++) {
			System.out.println(rrList.get(i));
		}*/
		
		System.out.println((recruitService.findRecruitPostByCategoryOrKeyword("","","", 1)).getRecruitPostList().size());
	}
	
	/**
	 * 스터디 신청 삭제 TEST
	 * @author 김유란
	 */
	//@Test
	public void deleteStudyConditionByStudyConditionNoTest() {
		recruitService.deleteStudyConditionByStudyConditionNo("b@b.com", "6");
	}
	
	/**
	 * 스터디 그룹번호로 신청현황 조회 TEST
	 * @author 김유란
	 */
	//@Test
	public void findStudyConditionByGroupNoTest() {
		System.out.println(recruitService.findStudyConditionByGroupNo("1", "1"));
	}
	
	/**
	 * 스터디 신청자 상태 변경(승인/거절)  TEST
	 * @author 김유란
	 */
	//@Test
	public void updateStudyConditionStateTest() {
		recruitService.updateStudyConditionState("승인",	 "1");
	}
}





