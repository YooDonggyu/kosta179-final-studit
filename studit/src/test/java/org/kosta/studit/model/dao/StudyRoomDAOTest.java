package org.kosta.studit.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.studit.model.PagingBean;
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
	   //@Test
	   public void findWaitStudyRoomByEmail() {
	      System.out.println(studyroomDAO.findWaitStudyRoomByEmail("a@a.com"));
	   }
	   
	   /**
	    * 스터디룸 신천형황 정보 가져오기
	    * @author 유동규
	    */
	   //@Test
	   public void findStudyConditionByEmail() {
		   //1. 전체 현황 수로 pagingBean 생성
		   //2. pb와 email을 map으로 담아 전송
		   
		   PagingBean pb = new PagingBean(studyroomDAO.findTotalStudyRoomConditionByEmail("a@a.com"));
		   Map<String, Object> map = new HashMap<>();
		   map.put("pagingBean", pb);
		   map.put("memberEmail", "a@a.com");
		   System.out.println(studyroomDAO.findStudyConditionByEmail(map));
	   }
}