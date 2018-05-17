package org.kosta.studit.model.dao;

import java.util.List;
import java.util.Map;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring-model.xml"})
public class GroupDAOTest {
	@Autowired
	   private GroupDAO groupDAO;
	   
	   /**
	    * 본인이 팀장인 스터디 그룹의 수.
	    * @author 송용준
	    */
	   //@Test
	   public void findMyLeadStudyGroupCountByEmail() {
	      int count=groupDAO.findMyLeadStudyGroupCountByEmail("a@a.com");
	      System.out.println(count);
	   }
	   
	   /**
	    * 본인이 팀장인 스터디 그룹 중 팀원을 가지고 있는 스터디 그룹 수.
	    * @author 송용준
	    */
	   //@Test
	   public void findMyLeadGroupHasMemberByEmail() {
	      List<Map<String, Object>> countList=groupDAO.findMyLeadGroupHasMemberByEmail("a@a.com");
	      for(Map<String, Object> member:countList) {
	         System.out.println(member.get("SG_NO"));
	         System.out.println(member.get("MEMBERCOUNT"));
	         System.out.println(member.get("CONDITION"));
	      }
	   }
}
