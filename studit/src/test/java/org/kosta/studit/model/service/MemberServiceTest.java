package org.kosta.studit.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.studit.exception.EmailNotFoundException;
import org.kosta.studit.exception.IsNotMemberException;
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
	    * 아이디 유무(EmailNotFoundException), 비밀번호 확인(PasswordIncorrectException), 탈퇴여부(IsNotMemberException) 후 MemberVO 리턴까지 TEST
	    * @author 유동규
	    */
		//@Test
	   public void loginTest() {
	      MemberVO memberVO = new MemberVO();
	      memberVO.setMemberEmail("a@a.com");
	      memberVO.setPassword("1");
	      try {
	         System.out.println(memberService.login(memberVO));
	      } catch (EmailNotFoundException | PasswordIncorrectException | IsNotMemberException e) {
	         System.out.println(e.getMessage());
	      }
	   }
	   
	
	/**
	 *	회원정보수정을 테스트
	 * @author 김유란,이승수
	 */
	//@Test
	public void updateMemberTest() {
		try {
			System.out.println(memberService.login(new MemberVO("a@a.com", "1")));
		} catch (EmailNotFoundException | PasswordIncorrectException | IsNotMemberException e) {
			e.printStackTrace();
		}
		System.out.println(memberService.updateMember(new MemberVO("a@a.com", "11", "유스페이스", "8층","1234", "1", "설현", "질문?", "답?", "path")));
	}
	
	
	/**
	 * 회원 가입 및 직책 추가 테스트
	 * @author 변태섭
	 */
	//@Test
	public void registerMemberTest() {
		MemberVO memberVO = new MemberVO();
		memberVO.setPrimaryAddr("기본주소");
		memberVO.setDetailAddr("상세주소");
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
	
		/**
	    * 회원탈퇴 시 필요한 조건 확인
	    * @author 송용준
	    */
	   @Test
	   public void deleteMemberViewTest() {
	      HashMap<String,Object> map=memberService.deleteMemberView("a@a.com");
	      System.out.println("##회원털퇴를 위한 조건##");
	      System.out.println("신청중인 스터디룸의 수 : "+map.get("waitStudyRoomCount"));
	      System.out.println("신청중인 스터디의 수 : "+map.get("waitStudyCount"));
	      System.out.println("업체일 경우, 승인대기중인 예약의 수 : "+map.get("waitReservation"));
	      System.out.println("팀장이면서 팀원을 가진 스터디 그룹 갯수 : "+map.get("myLeadStudyGroupHasMemberCount"));

	      List<Map<String, Object>> list=(List<Map<String, Object>>)map.get("myLeadStudyGroupHasMemberList");
	      System.out.println("##팀장이면서 팀원을 가진 스터디 그룹 이름##");
	      for(int i=0; i<list.size(); i++) {
	         System.out.println(list.get(i).get("NAME"));
	      }
	   }
	
}
