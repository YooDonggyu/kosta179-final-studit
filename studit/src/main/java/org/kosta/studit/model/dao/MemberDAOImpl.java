package org.kosta.studit.model.dao;

import java.util.Map;

import org.kosta.studit.model.vo.MemberVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSessionTemplate template;

	/**
	 * 이메일에 따른 멤머 객체를 찾는 메서드.
	 * 
	 * @author 유동규
	 * @param memberEmail
	 *            검색할 이메일
	 * @return MemberVO 이메일에 해당하는 멤버 객체 반환
	 */
	@Override
	public MemberVO findMemberByEmail(String memberEmail) {
		return template.selectOne("member.findMemberByEmail", memberEmail);
	}

	/**
	 * 회원가입을 통해 member DB에 insert하는 메서드
	 * 
	 * @author 변태섭
	 * @param MemberVO
	 *            회원가입 시 사용자가 입력한 데이터
	 */
	@Override
	public void registerMember(MemberVO memberVO) {
		template.insert("member.registerMember", memberVO);
	}

	/**
	 * 
	 * 회원정보 수정 회원정보를 수정한 후 새로운 회원정보를 반환함
	 * 
	 * @author 김유란, 이승수
	 * @param MemberVO
	 *            수정된 회원정보를 담은 VO
	 * @return MemberVO DB에 반영된 새로운 회원 정보를 반환(세션 회원정보 업데이트 위해)
	 */
	@Override
	public void updateMember(MemberVO memberVO) {
		template.update("member.updateMember", memberVO);
	}

	/**
	 * 
	 * 비밀번호 변경 회원이 입력한 새로운 비밀번호를 DB에 반영
	 * 
	 * @author 김유란
	 * @param MemberVO
	 *            식별을 위한 회원 이메일과 수정된 비밀번호를 담은 VO
	 */
	@Override
	public void updatePassword(MemberVO memberVO) {
		template.update("member.updatePassword", memberVO);
	}

	/**
	 * 회원인지 아닌지 판단하는 메서드.
	 * 
	 * @author 유동규
	 * @param memberEmail
	 *            회원인지 확인할 이메일
	 * @return boolean 회원이면 true 아니면 false
	 */
	@Override
	public boolean isMember(String memberEmail) {
		if ((Integer) template.selectOne("member.isMember", memberEmail) != 0) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 회원이 업체인지 아닌지 확인
	 * 
	 * @author 송용준
	 * @param memberEmail
	 *            회원 이메일
	 * @return Boolean 업체일 경우 true, 아닌 경우 false
	 */
	@Override
	public Boolean checkCompanyByEmail(String memberEmail) {
		int isCompany = template.selectOne("member.checkCompanyByEmail", memberEmail);
		if (isCompany != 0) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 회원 탈퇴 시 회원의 직책 상태를 회원에서 탈퇴로 변경하는 메서드
	 * 
	 * @author 송용준
	 * @param memberEmail 탈퇴하고자 하는 회원의 이메일
	 */
	@Override
	public void deleteMember(String memberEmail) {
		template.update("member.deleteMember", memberEmail);
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
	   
	   /**
	    * 회원의 직책의 유무를 체크하는 쿼리
	    * 
	    * @author 변태섭
	    * @param map 찾고자 하는 회원의 이메일과 직책을 담은 객체
	    * @return 있으면 1, 없으면 0
	    */
	   @Override
	   public int findCountMemberPositionByMemberPositionAndMemberEmail(Map<String, String> map) {
		   return template.selectOne("member.findCountMemberPositionByMemberPositionAndMemberEmail", map);
	   }
}
