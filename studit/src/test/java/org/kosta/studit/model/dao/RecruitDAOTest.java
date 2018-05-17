package org.kosta.studit.model.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring-model.xml"})
public class RecruitDAOTest {
	@Autowired
	   private RecruitDAO recruitDAO;
	   
	   /**
	    * 신청한 스터디 중 승인대기중인 스터디 수를 확인.
	    * @author 송용준
	    */
	   @Test
	   public void findWaitStudyByEmail() {
	      System.out.println(recruitDAO.findWaitStudyByEmail("c@c.com"));
	   }
}
