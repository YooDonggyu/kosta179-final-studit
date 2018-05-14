package org.kosta.studit.model.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring-model.xml"})
public class MemberDAOTest {
	
	@Autowired
	private MemberDAO memberDAO;
	
	/**
	 * 아이디 유무 확인 TEST.
	 * @author 유동규
	 */
	@Test
	public void findMemberByEmailTest() {
		//아이디가 있는지 검사
		System.out.println(memberDAO.findMemberByEmail("a@a.com"));
	}
}
