package org.kosta.studit.model.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
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
	   public void findWaitReservationByEmail() {
	      System.out.println(companyDAO.findWaitReservationByEmail("d@d.com"));
	   }
}
