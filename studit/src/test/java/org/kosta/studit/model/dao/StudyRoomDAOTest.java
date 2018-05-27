package org.kosta.studit.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.studit.model.PagingBean;
import org.kosta.studit.model.vo.CompanyVO;
import org.kosta.studit.model.vo.MemberVO;
import org.kosta.studit.model.vo.StudyRoomConditionVO;
import org.kosta.studit.model.vo.StudyRoomVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring-model.xml"})
public class StudyRoomDAOTest {
	@Autowired
	   private StudyRoomDAO studyroomDAO;
	   
	   /**
	    * 신청한 스터디룸 중 승인대기중인 스터디룸 수를 확인.
	    * @author 송용준
	    */
	   @Test
	   public void findWaitStudyRoomByEmailTest() {
	      System.out.println(studyroomDAO.findWaitStudyRoomByEmail("a@a.com"));
	   }
	   
	   /**
	    * 스터디룸 신청현황 정보 가져오기
	    * @author 유동규
	    */
	   //@Test
	   public void findStudyRoomConditionByEmailTest() {
		   //1. 전체 현황 수로 pagingBean 생성
		   //2. pb와 email을 map으로 담아 전송
		   PagingBean pb = new PagingBean(studyroomDAO.findTotalStudyRoomConditionByEmail("a@a.com"));
		   Map<String, Object> map = new HashMap<>();
		   map.put("pagingBean", pb);
		   map.put("memberEmail", "a@a.com");
		   System.out.println(studyroomDAO.findStudyConditionByEmail(map));
	   }
	   
	   /**
	    * 스터디룸 정보 조회 테스트
	    * 
	    * @author 김유란
	    */
	   @Test
	   public void findStudyRoomInfoByStudyRoomNoTest() {
		   System.out.println(studyroomDAO.findStudyRoomInfoByStudyRoomNo("1"));
	   }

		/**
	    * 스터디룸을 등록하는 테스트
	    * 
	    * @author 변태섭
	    */
	   @Test
	   public void registerStudyRoomTest() {
		   StudyRoomVO studyRoomVO = new StudyRoomVO();
		   studyRoomVO.setName("MOIM");
		   studyRoomVO.setContent("스터디룸 내용");
		   studyRoomVO.setPrice("1300");
		   studyRoomVO.setCapacity("4");
		   studyRoomVO.setCompanyVO(new CompanyVO());
		   studyRoomVO.getCompanyVO().setCompanyNo(3);
		   System.out.println("before: "+studyRoomVO);
		   studyroomDAO.registerStudyRoom(studyRoomVO);
		   System.out.println("after: "+studyRoomVO);
	   }
	   
	   /**
	    * 스터디룸 사진 경로를 등록하는 테스트
	    * 
	    * @author 변태섭
	    */
	   @Test
	   public void registerStudyRoomPicPathTest() {
		   Map<String, Object> map = new HashMap<String, Object>();
		   map.put("studyRoomPicPath", "C:/직박구리/");
		   map.put("studyRoomNo", 1);
		   studyroomDAO.registerStudyRoomPicPath(map);
	   }
	   
	   /**
	    * 스터디룸 기능을 등록하는 테스트
	    * 
	    * @author 변태섭
	    */
	   public void registerStudyRoomFunctionTest() {
		   //@Test
		   Map<String, Object> map = new HashMap<String, Object>();
		   map.put("studyRoomFunction", "프린트");
		   map.put("studyRoomNo", 2);
		   studyroomDAO.registerStudyRoomFunction(map);
	   }
	   
	   /**
	    * 스터디룸 예약정보 불러오기 테스트
	    * 
	    * @author 김유란
	    */
	   //@Test
	   public void findStudyRoomConditionByStudyRoomNoAndDate() {
		   StudyRoomConditionVO studyRoomConditionVO = new StudyRoomConditionVO();
		   StudyRoomVO studyRoomVO = new StudyRoomVO();
		   studyRoomVO.setStudyRoomNo(1);
		   studyRoomConditionVO.setStudyRoomVO(studyRoomVO);
		   studyRoomConditionVO.setUseDate("2018-05-30");
		   System.out.println(studyroomDAO.findStudyRoomConditionByStudyRoomNoAndDate(studyRoomConditionVO));
	   }
	   
	   /**
	    * 스터디룸 예약 테스트
	    * @author 김유란
	    */
	   @Test
	   public void createStudyRoomConditionTest() {
		   StudyRoomConditionVO studyRoomConditionVO = new StudyRoomConditionVO();
		   StudyRoomVO studyRoomVO = new StudyRoomVO();
		   studyRoomVO.setStudyRoomNo(1);
		   studyRoomConditionVO.setStudyRoomVO(studyRoomVO);
		   studyRoomConditionVO.setUseDate("2018-05-30");
		   studyRoomConditionVO.setStartTime("17");
		   studyRoomConditionVO.setEndTime("20");
		   studyRoomConditionVO.setMemberVO(new MemberVO("a@a.com",null));
		   System.out.println(studyroomDAO.findStudyRoomConditionByStudyRoomNoAndDate(studyRoomConditionVO));
		   studyroomDAO.createStudyRoomCondition(studyRoomConditionVO);
		   System.out.println(studyroomDAO.findStudyRoomConditionByStudyRoomNoAndDate(studyRoomConditionVO));
	   }
	   
	   
	   /**
	    * 업체 번호에 따른 스터디 룸들의 정보 반환
	    * @author 유동규
	    */
	   //@Test
	   public void findStudyRoomInfoByCompanyNoTest() {
		   System.out.println(studyroomDAO.findStudyRoomInfoByCompanyNo(1));
	   }
	   
	   /**
	    * 업체 번호에 따른 스터디 룸들의 사진 정보 반환
	    * @author 유동규
	    */
	   //@Test
	   public void findStudyRoomPicByCompanyNoTest() {
		   System.out.println(studyroomDAO.findStudyRoomPicByCompanyNo(1));
	   }
	   
	   /**
	    * 업체 번호에 따른 스터디 룸들의 기능 정보 반환
	    * @author 유동규
	    */
	   //@Test
	   public void findstudyroomFunctionByCompanyNoTest() {
		   System.out.println(studyroomDAO.findstudyroomFunctionByCompanyNo(1));
	   }
	   
	   
}