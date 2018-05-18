package org.kosta.studit.model.service;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring-model.xml"})
public class RecruitServiceTest {
	@Autowired
	private RecruitService recruitService;
	
	@Test
	public void registerRecruiteTest() {
		recruitService.registerRecruitStudy(2, "j@k.com", "자기소개냐??");
	}
}
