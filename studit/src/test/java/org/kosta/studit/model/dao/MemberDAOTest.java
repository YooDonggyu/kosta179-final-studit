package org.kosta.studit.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosta.studit.model.PagingBean;
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
	   //@Test
	   public void findMemberByEmailTest() {
	      //아이디가 있는지 검사
	      System.out.println(memberDAO.findMemberByEmail("a@a.com"));
	      //아이디가 없을 경우
	      System.out.println(memberDAO.findMemberByEmail("bts@a.com"));
	   }
	   
	   /**
	    * 회원가입 시 사용자가 입력한 데이터를 DB에 insert하는 메서드
	    * @param 변태섭
	    */
	   //@Test
	   public void registerMemberTest() {
	      MemberVO mvo = new MemberVO();
	      mvo.setMemberEmail("insertTest4@a.com");
	      mvo.setPassword("12345678");
	      mvo.setPrimaryAddr("충청북도 청주시 서원구 개신동");
	      mvo.setDetailAddr("1층");
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
	//@Test
	public void updateMemberTest() {
		System.out.println("수정전 : "+memberDAO.findMemberByEmail("a@a.com"));
		memberDAO.updateMember(new MemberVO("a@a.com", "11", "유스페이스", "8층", "1234", "1", "아이유유", "질문?", "답?", "path"));
		System.out.println("수정 후 : "+memberDAO.findMemberByEmail("a@a.com"));
	}
	
	/**
	 * 비밀번호 변경 TEST
	 * @author 김유란
	 */
	//@Test
	public void updatePasswordTest() {
		System.out.println("수정 전: " + memberDAO.findMemberByEmail("a@a.com"));
		memberDAO.updatePassword(new MemberVO("a@a.com", "1234"));
		System.out.println("수정 후: " + memberDAO.findMemberByEmail("a@a.com"));
	}
	
	/**
	 * 회원이 탈퇴상태인지 확인
	 * @author 유동규
	 */
	//@Test
	public void isMemberTest() {
		System.out.println(memberDAO.isMember("a@a.com"));
	}
	
	/**
	 * 회원 직책을 추가할 때 사용 하는 메서드
	 * @author 변태섭
	 * @param Map 회원 Email, 직책 담아서 전달
	 */
	//@Test
	public void registerMemberPositionTest() {
		//HashMap<String, String> map = new HashMap<String,String>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberEmail", "a@a.com");
		map.put("memberPosition",	"회원");
		System.out.println(map);
		memberDAO.registerMemberPosition(map);
		//System.out.println(memberDAO.findMemberByEmail("a@a.com"));
	}
	
	@Test
	public void test() {
		
		String memberSrch = null;
		int totalCnt = memberDAO.getTotalMemberForAdmin(memberSrch);
		PagingBean pb = new PagingBean(totalCnt, 1);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberSrch", memberSrch);
		map.put("pagingBean", pb);
		System.out.println(memberDAO.getMemberListForAdmin(map));
	}
	
}
