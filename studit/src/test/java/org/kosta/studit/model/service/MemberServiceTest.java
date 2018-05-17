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
	   //@Test
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
	   
	
	/**
	 *	회원정보수정을 테스트
	 *
	 * @author 김유란,이승수
	 */
	//@Test
	public void updateMember() {
		try {
			System.out.println(memberService.login(new MemberVO("a@a.com", "1")));
		} catch (EmailNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (PasswordIncorrectException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(memberService.updateMember(new MemberVO("a@a.com", "11", "유스페이스", "1234", "1", "설현", "질문?", "답?", "path")));
	}
	
	//@Test
	public void updatePasswordTest() {
		
	}
	
	/**
	 * 회원 가입 및 직책 추가 테스트
	 * @author 변태섭
	 */
	//@Test
	public void registerMemberPosition() {
		MemberVO memberVO = new MemberVO();
		memberVO.setAddr("주소");
		memberVO.setMemberEmail("email@c.com");
		memberVO.setName("이름");
		memberVO.setPassword("1234");
		memberVO.setPasswordAnswer("답");
		memberVO.setPasswordHint("질문");
		memberVO.setPhone("123");
		memberVO.setPicPath("C:갑자");
		System.out.println(memberVO);
		memberService.registerMember(memberVO);
	}
	
}
