package org.kosta.studit.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.studit.model.vo.CompanyVO;
import org.kosta.studit.model.vo.StudyRoomConditionVO;
import org.kosta.studit.model.vo.StudyRoomVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring-model.xml"})
public class CompanyDAOTest {
	@Autowired
	   private CompanyDAO companyDAO;
	   
	   /**
	    * 승인대기중인 예약건수를 확인.
	    * @author 송용준
	    */
	   @Test
	   public void findWaitReservationByEmail() {
	      System.out.println(companyDAO.findWaitReservationByEmail("d@d.com"));
	   }
	   
	   /**
	    * 회원 이메일로 업체 정보 조회 테스트
	    * @author 김유란
	    */
	   @Test
	   public void findCompanyByMemberEmailTest() {
		   System.out.println(companyDAO.findCompanyByMemberEmail("d@d.com"));
	   }
	   
	   /**
	    * 업체 번호로 등록된 스터디룸 조회 테스트
	    * @author 김유란
	    */
	   @Test
	   public void findStudyRoomByCompanyNo() {
		   System.out.println(companyDAO.findStudyRoomByCompanyNo(3));
	   }
	   
	   /**
	    * 스터디룸 번호로 예약현황 조회
	    * @author 김유란
	    */
	   @Test
	   public void findStudyRoomConditionByStudyRoomNo() {
		   System.out.println(companyDAO.findStudyRoomConditionByStudyRoomNo(4));
	   }
	   
	   /**
	    * 스터디룸 예약 현황 수정 테스트
	    * @author 김유란
	    */
	   @Test
		public void updatStudyRoomConditionTest() {
		   StudyRoomConditionVO vo= new StudyRoomConditionVO();
		   vo.setState("승인");
		   vo.setEndTime("20:00");
		   vo.setStartTime("17:00");
		   vo.setUseDate("2018-05-24");
		   vo.setStudyRoomConditionNo(1);
		   StudyRoomVO srVO = new StudyRoomVO();
		   srVO.setStudyRoomNo(1);
		   vo.setStudyRoomVO(srVO);
		   companyDAO.updatStudyRoomCondition(vo);
	   }
	   
	   /**
	    * 업체 영업일 조회 테스트
	    * @author 김유란
	    */
	   @Test
	   public void findBusinessDayByCompanyNoTest() {
		   System.out.println(companyDAO.findBusinessDayByCompanyNo(1));
	   }
	   
	   @Test
	   public void findCompanyListByAddressAndKeywordAndHashTag() {
		   Map<String, String> map=new HashMap<>();		
			map.put("firstAddr", null);
			map.put("secondAddr", null);
			map.put("thirdAddr", null);
			map.put("keywordORhashtag", "고백");
			List<CompanyVO> list=companyDAO.findCompanyListByAddress(map);
			for(CompanyVO vo:list) {
				System.out.println(vo);
			}
	   }
}
