package org.kosta.studit.model.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring-model.xml"})
public class CompanyServiceTest {

	
	@Autowired
	private CompanyService companyService;
	
	@Test
	public void findStudyRoomByMemberEmailTest() {
		System.out.println(companyService.findStudyRoomByMemberEmail("d@d.com"));
		
	}
	
	@Test
	public void findStudyRoomConditionByMemberEmailTest() {
		System.out.println(companyService.findStudyRoomConditionByMemberEmail("d@d.com"));
		
	}
	
	@Test
	public void findBusinessDayByCompanyNoTest() {
		System.out.println(companyService.findBusinessDayByMemberEmail("d@d.com"));
	}
}
