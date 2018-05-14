package org.kosta.studit.model.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.studit.exception.EmailNotFoundException;
import org.kosta.studit.exception.PasswordIncorrectException;
import org.kosta.studit.model.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring-model.xml"})
public class MemberServiceTest {
	@Autowired
	private MemberService memberService;
	
	/**
	 * 로그인 TEST.
	 * 아이디 유무(EmailNotFoundException), 비밀번호 확인(PasswordIncorrectException) 후 MemberVO 리턴까지 TEST
	 * @author 유동규
	 */
	@Test
	public void loginTest() {
		MemberVO memberVO = new MemberVO();
		memberVO.setMemberEmail("a@a.com");
		memberVO.setPassword("1");
		try {
			System.out.println(memberService.login(memberVO));
		} catch (EmailNotFoundException | PasswordIncorrectException e) {
			System.out.println(e.getMessage());
		}
	}
	
}
