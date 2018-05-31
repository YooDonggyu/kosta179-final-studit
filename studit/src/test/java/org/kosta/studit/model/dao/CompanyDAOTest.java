package org.kosta.studit.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.studit.model.vo.CompanyVO;
import org.kosta.studit.model.vo.MemberVO;
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
	   //@Test
	   public void findWaitReservationByEmailTest() {
	      System.out.println(companyDAO.findWaitReservationByEmail("d@d.com"));
	   }
	   
		/**
		 * select box에 제공할 모든 업체의 addr1 값을 불러온다
		 * @author 송용준
		 */
		//@Test
		public void readFirstAddrTest() {
			System.out.println(companyDAO.readFirstAddr());
		}
		
		/**
		 * 모든 업체 정보 불러오기
		 * @author 송용준
		 */
		//@Test
		public void readAllCompanyTest() {
			System.out.println(companyDAO.readAllCompany());
		}
	   
		/**
		 * 등록이 승인된 모든 업체의 해쉬태그 정보를 불러온다
		 * @author 송용준
		 */
		//@Test
		public void readAllHashTagTest() {
			System.out.println(companyDAO.readAllHashTag());
		}
		
		/**
		 * 스터디룸(업체) 검색 뷰에서 선택된 addr1에 대응되는 addr2를 조회.
		 * @author 송용준
		 */
		//@Test
		public void findSecondAddressListByFirstAddressNameTest() {
			System.out.println(companyDAO.findSecondAddressListByFirstAddressName("서울시"));
		}
		
		/**
		 * 스터디룸(업체) 검색 뷰에서 선택된 addr2에 대응되는 addr3를 조회.
		 * @author 송용준
		 */
		//@Test
		public void findThirdAddressListBySecondAddressName() {
			System.out.println(companyDAO.findThirdAddressListBySecondAddressName("강남구"));
		}
		
	   /**
	    * 회원 이메일로 업체 정보 조회 테스트
	    * @author 김유란
	    */
	   //@Test
	   public void findCompanyByMemberEmailTest() {
		   System.out.println(companyDAO.findCompanyByMemberEmail("d@d.com"));
	   }
	   
	   /**
	    * 업체 번호로 등록된 스터디룸 조회 테스트
	    * @author 김유란
	    */
	   //@Test
	   public void findStudyRoomByCompanyNo() {
		   System.out.println(companyDAO.findStudyRoomByCompanyNo(1));
	   }
	   
	   /**
	    * 스터디룸 번호로 예약현황 조회
	    * @author 김유란
	    */
	   //@Test
	   public void findStudyRoomConditionByStudyRoomNoAndMonthTest() {
		   Map<String,String> map=new HashMap<>();
		   map.put("companyNo", "1");
		   map.put("startDate", "2018-05-01");
		   map.put("endDate", "2018-05-31");
		   System.out.println(companyDAO.findStudyRoomConditionByCompanyNoAndMonth(map));
	   }
	   
	   /**
	    * 스터디룸 예약 현황 수정 테스트
	    * @author 김유란
	    */
	   //@Test
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
	   //@Test
	   public void findBusinessDayByCompanyNoTest() {
		   System.out.println(companyDAO.findBusinessDayByCompanyNo(1));
	   }
	   
	   //@Test
	   public void findCompanyListByAddressAndKeywordAndHashTag() {
		   Map<String, Object> map=new HashMap<>();		
			map.put("firstAddr", null);
			map.put("secondAddr", null);
			map.put("thirdAddr", null);
			map.put("keywordORhashtag", "고백");
			List<CompanyVO> list=companyDAO.findCompanyListByCondition(map);
			for(CompanyVO vo:list) {
				System.out.println(vo);
			}
	   }
			
	   /**
	    * 해시태그 등록
	    * 
	    * @author 변태섭
	    */
	   //@Test
	   public void registerHashtagTest() {
		   String tag = "조용하고아늑, 그냥그럼, 좋다, 네번쨰";
		   Map<String, Object> map = new HashMap<String, Object>();
		   map.put("companyNo",	2);
		   System.out.println(tag.trim());
		   String[] tagArray = tag.replaceAll(" ", "").split(",");
		   //System.out.println(tagArray);
		   for(String tt : tagArray) {
			   map.put("tag", tt);
			   System.out.println(map);
			   companyDAO.registerHashtag(map);
		   }
	   }
	   
	   /**
	    * 업체 영업 요일을 등록하는 테스트
	    * 
	    * @author 변태섭
	    */
	   //@Test
	   public void registerBusinessDayTest() {
		   Map<String, Object> map = new HashMap<String, Object>();
		   String days = "월 화 수 목 금";
		   String[] day = days.split(" ");
		   System.out.println("day: "+day);
		   map.put("companyNo", 3);
		   for(String d : day) {
			   map.put("day", d);
			   companyDAO.registerBusinessDay(map);
		   }
	   }
	   
	   /**
	    * 업체 등록하는 테스트
	    * 
	    * @author 변태섭
	    */
	  // @Test
	   public void registerCompanyTest() {
		   CompanyVO companyVO = new CompanyVO();
		   companyVO.setName("냥냥기업");
		   companyVO.setHoliday("정상 영업");
		   companyVO.setOpen("09");
		   companyVO.setClose("22");
		   companyVO.setAddr1("서울특별시");
		   companyVO.setAddr2("서초구");
		   companyVO.setAddr3("강남대로321");
		   companyVO.setAddr4("대우디오빌 416호");
		   companyVO.setIntro("업체 소개");
		   companyVO.setPrimaryAddr("판교");
		   companyVO.setDetailAddr("1호");
		   companyVO.setUrl("adasdad.com");
		   companyVO.setTel("021234567");
		   companyVO.setProfilePath("C:/임시");
		   companyVO.setMemberVO(new MemberVO());
		   companyVO.getMemberVO().setMemberEmail("test@a.com");
		   companyVO.setLicense("1234567891");
		   System.out.println("brfore: "+companyVO);
		   companyDAO.registerCompany(companyVO);
		   System.out.println("after: "+companyVO);
	   }
	   
	   /**
	    * 업체 사진 경로를 등록하는 테스트
	    * 
	    * @author 변태섭
	    */
	   //@Test
	   public void registerCompanyPicPathTest() {
		   Map<String, Object> map = new HashMap<String, Object>();
		   map.put("companyPicPath", "C:/업체사진");
		   map.put("companyNo", 2);
		   companyDAO.registerCompanyPicPath(map);
	   }
	   
	   /**
	    * 사업자등록번호 중복 유무를 체크하는 테스트
	    * 
	    * @author 변태섭
	    */
	  // @Test
	   public void findCountCompanyByLicenseTest() {
		   String license = "1234567891";
		  System.out.println(companyDAO.findCountCompanyByLicense(license));
	   }
	   
	   
	   /**
	    * 업체번호에 따른 업체 정보 반환
	    * @author 유동규
	    */
	   //@Test
	   public void findCompanyByCompanyNoTest() {
		   System.out.println(companyDAO.findCompanyByCompanyNo(1));
	   }
	   
	   /**
	    * 업체번호에 따른 업체 사진 정보 반환
	    * @author 유동규
	    */
	   //@Test
	   public void findComPicByCompanyNoTest() {
		   System.out.println(companyDAO.findComPicByCompanyNo(1));
	   }
	   
	   /**
	    * 업체번호에 따른 업체 해시태그 정보 반환
	    * @author 유동규
	    */
	   //@Test
	   public void findHashTagByCompanyNoTest() {
		   System.out.println(companyDAO.findHashTagByCompanyNo(1));
	   }
	   
	   /**
	    * 스터디룸 예약 월별 통계 조회 테스트
	    * @author 김유란
	    */
	   //@Test
	   public void findStudyRoomConditionCountByMonthTest() {
		   Map<String, String> map = new HashMap<>();
		   map.put("companyNo", "1");
		   map.put("state", "예약대기");
		   System.out.println(companyDAO.findStudyRoomConditionCountByMonth(map));
	   }
	   
	   /**
	    * 승인된 업체의 전체 수를 출력
	    * @author 송용준
	    */
	   //@Test
	   public void findTotalCountOfCompanyTest() {
		   //findTotalCountOfCompany() 메소드에서 매개변수는 검색 조건
		   //검색 조건에 부합하는 업체들의 총 수를 반환
		   System.out.println(companyDAO.findTotalCountOfCompany(null));
	   }
	   
	   /**
	    * 조회수가 가장 높은 업체 3곳 조회
	    * @author 유동규
	    */
	   //@Test
	   public void getTopThreeComapnyTest() {
		   System.out.println(companyDAO.getTopThreeComapny());
	   }
	   
	   /**
	    * 업체 스터디룸 일별 예약대기 건수 조회
	    * @author 김유란
	    */
	   @Test
	   public void findWaitStudyRoomConditionCountByCompanyNoTest() {
		   System.out.println(companyDAO.findWaitStudyRoomConditionCountByCompanyNo("1"));
	   }
	   
	   
}
