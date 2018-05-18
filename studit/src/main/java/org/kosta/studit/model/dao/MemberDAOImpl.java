package org.kosta.studit.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.MemberVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Autowired
	   private SqlSessionTemplate template;
	
	
	   /**
	    * 이메일에 따른 멤머 객체를 찾는 메서드.
	    * @author 유동규
	    * @param memberEmail 검색할 이메일
	    * @return MemberVO 이메일에 해당하는 멤버 객체 반환
	    */
	   @Override
	   public MemberVO findMemberByEmail(String memberEmail) {
	      return template.selectOne("member.findMemberByEmail", memberEmail);
	   }
	   
	   /**
	    * 회원가입을 통해 member DB에 insert하는 메서드
	    * @author 변태섭
	    * @param MemberVO 회원가입 시 사용자가 입력한 데이터
	    */
	   @Override
	   public void registerMember(MemberVO memberVO) {
	      template.insert("member.registerMember", memberVO);
	   }

	/**
	 * 
	    * 회원정보 수정 뷰 이동 메서드
	    * 회원정보 수정 화면으로 넘어간다.(기존 회원정보는 session에 저장된 값을 이용하므로 attribute 없음)
	    * 로그인 후 헤더의 사용자 이름 버튼을 누르면 실행(임시)
	    * 
	    * @author 김유란
	    * @return member/update_member tiles 적용하여 페이지 이동
	 */
	@RequestMapping("/updateMemberView")
	public String updateMemberView() {
		return "member/update_member"+".tiles";
	}
	
		@Override
		public  void updateMember(MemberVO memberVO) {
			template.update("member.updateMember",memberVO);
		}
	
	/**
	 * 회원인지 아닌지 판단하는 메서드.
	 * @author 유동규
	 * @param memberEmail 회원인지 확인할 이메일
	 * @return boolean 회원이면 true 아니면 false
	 */
	@Override
	public void updatePassword(MemberVO memberVO) {
		template.update("member.updatePassword", memberVO);
	}
	

	/**
	 * 회원인지 아닌지 판단하는 메서드.
	 * @author 유동규
	 * @param memberEmail 회원인지 확인할 이메일
	 * @return boolean 회원이면 true 아니면 false
	 */
	@Override
	public boolean isMember(String memberEmail) {
		if((Integer)template.selectOne("member.isMember", memberEmail) != 0) {
			return false;
		}else {
			return true;
		}
	}
	
	/**
	    * 회원이 업체인지 아닌지 확인
	    * @author 송용준
	    * @param memberEmail 회원 이메일
	    * @return Boolean 업체일 경우 true, 아닌 경우 false
	    */
	   @Override
	   public Boolean checkCompanyByEmail(String memberEmail) {
	      int isCompany=template.selectOne("member.checkCompanyByEmail", memberEmail);
	      if(isCompany!=0) {
	         return true;
	      }else {
	         return false;
	      }
	   }

	   /**
	    * 회원 가입 시 직책테이블에 직책을 추가하는 메서드
	    * @author 변태섭
	    * @param Map 회원 Email, 직책
	    */
	   @Override
	   public void registerMemberPosition(Map<String, String> map) {
	      template.insert("member.registerMemberPosition",map);
	   }
}
