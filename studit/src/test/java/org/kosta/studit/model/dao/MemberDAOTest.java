package org.kosta.studit.model.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.studit.model.vo.MemberVO;
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
	   public void findMemberByEmailTest() {
	      //아이디가 있는지 검사
	      System.out.println(memberDAO.findMemberByEmail("a@a.com"));
	      
	      //아이디가 없을 경우
	      System.out.println(memberDAO.findMemberByEmail("bts@a.com"));
	   }
	   
	   /**
	    * 회원가입 시 사용자가 입력한 데이터를 DB에 insert하는 메서드
	    * @param BTS
	    */
	   //@Test
	   public void registerMember() {
	      MemberVO mvo = new MemberVO();
	      mvo.setMemberEmail("insertTest4@a.com");
	      mvo.setPassword("12345678");
	      mvo.setAddr("충청북도 청주시 서원구 개신동");
	      mvo.setPhone("01012341234");
	      mvo.setName("이름4");
	      mvo.setPasswordHint("비밀번호 힌트!");
	      mvo.setPasswordAnswer("비밀번호 힌트 답변");
	      mvo.setPicPath("c:사진/직박구리/프로필사진");
	      
	      System.out.println(mvo);
	      // DB에 회원 데이터 추가
	      memberDAO.registerMember(mvo);
	      
	      // 정상 작동 되었는지 확인
	      System.out.println(memberDAO.findMemberByEmail(mvo.getMemberEmail()));
	   }
	
	/**
	 *  회원정보 변경확인 TEST
	 * @author 이승수
	 */
	@Test
	public void updateMember() {
		System.out.println("수정전 : "+memberDAO.findMemberByEmail("a@a.com"));
		memberDAO.updateMember(new MemberVO("a@a.com", "11", "유스페이스", "1234", "1", "아이유유", "질문?", "답?", "path"));
		System.out.println("수정 후 : "+memberDAO.findMemberByEmail("a@a.com"));
	}
}
