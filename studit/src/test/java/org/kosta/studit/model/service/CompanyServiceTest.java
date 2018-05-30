package org.kosta.studit.model.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.studit.model.vo.CompanyListVO;
import org.kosta.studit.model.vo.CompanyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring-model.xml"})
public class CompanyServiceTest {

	
	@Autowired
	private CompanyService companyService;
	
	/**
	 * 업체 회원이 보유한 스터디룸 정보 조회 테스트
	 * @author 김유란
	 */
	//@Test
	public void findStudyRoomByMemberEmailTest() {
		System.out.println(companyService.findStudyRoomByCompanyNo(1));
		
	}
	
	/**
	 * 업체 회원이 보유한 스터디룸 예약 현황 정보 조회 테스트
	 * @author 김유란
	 */
	//@Test
	public void findStudyRoomConditionByCompanyNoAndMonthTest() {
		System.out.println(companyService.findStudyRoomConditionByCompanyNoAndMonth("1", "2018-05-01", "2018-05-31"));
	}
	
	/**
	 * 업체 번호로 영업일 정보 조회 테스트
	 * @author 김유란
	 */
	//@Test
	public void findBusinessDayByCompanyNoTest() {
		System.out.println(companyService.findBusinessDayByCompanyNo(1));
	}
	
	//@Test
	public void findDetailCompanyInfoByCompanyNoTest() {
		System.out.println(companyService.findDetailCompanyInfoByCompanyNo(1));
	}
	
	/**
	 * 검색조건에 부합하는 업체 리스트 출력
	 * @author 송용준
	 */
	//@Test
	public void findCompanyListByCondition() {
		CompanyListVO clist=companyService.findCompanyListByCondition(null);
		
		for(CompanyVO list:clist.getList()) {
			System.out.println(list.getName());
		}
		
	}
	
	//@Test
	public void findStudyRoomListByCompanyNoTest() {
		int companyNo = 2;
		System.out.println(companyService.findStudyRoomListByCompanyNo(companyNo));
	}
}
