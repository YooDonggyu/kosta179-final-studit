package org.kosta.studit.model.service;

import java.util.HashMap;
import java.util.Map;

import org.kosta.studit.exception.EmailNotFoundException;
import org.kosta.studit.exception.IsNotMemberException;
import org.kosta.studit.exception.PasswordIncorrectException;
import org.kosta.studit.model.dao.MemberDAO;
import org.kosta.studit.model.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MemberServiceImpl implements MemberService {
	

	   @Autowired
	   private MemberDAO memberDAO;
	   
	   /**
	    * 회원의 로그인 로직을 처리하는 메서드.
	    * @author 유동규
	    * @param MemberVO 로그인할 아이디와 비밀번호가 담겨있는 객체
	    * @exception EmailNotFoundException 이메일이 없는 예외처리 
	    * @exception PasswordIncorrectException 비밀번호가 틀린 예외처리
	    * @exception IsNotMemberException  탈퇴된 회원 예외처리
	    * @return MemberVO 로그인할 멤버 객체 반환
	    */
	   @Override
	   public MemberVO login(MemberVO memberVO) throws EmailNotFoundException, PasswordIncorrectException, IsNotMemberException {
	      //1. 해당 Email 찾기
	      MemberVO rMemberVO = memberDAO.findMemberByEmail(memberVO.getMemberEmail());
	      //2. Email 있으면 비밀번호 확인
	      if(rMemberVO == null) {
	         throw new EmailNotFoundException("해당 아이디가 없습니다.");
	      }else if(!memberDAO.isMember(rMemberVO.getMemberEmail())){
	    	  //3. 탈퇴된 이메일인지 확인
	    	  throw new IsNotMemberException("탈퇴된 아이디입니다.");
	      }else {
	         //4.비밀번호 확인
	         if(rMemberVO.getPassword().equals(memberVO.getPassword())) {
	            return rMemberVO;
	         }else {
	            throw new PasswordIncorrectException("비밀번호가 일치하지 않습니다.");
	         }
	      }
	   }

	
	/**
	   * 
       * 회원정보 수정
       * 회원정보를 수정한 후 새로운 회원정보를 반환함
       * 
       * @author 김유란, 이승수
       * @param MemberVO 수정된 회원정보를 담은 VO
       * @return MemberVO DB에 반영된 새로운 회원 정보를 반환(세션 회원정보 업데이트 위해)
	    */
	   @Override
	   public MemberVO updateMember(MemberVO memberVO) {
	      memberDAO.updateMember(memberVO);
	      return memberDAO.findMemberByEmail(memberVO.getMemberEmail());
	   }


	  /**
	   * 회원가입 시 입력된 데이터를 DB에 insert하는 메서드
	   * 동시에 직책테이블에 '회원'상태로 insert한다.
	   * @author 변태섭
	   * @param Map 회원 Email, 직책을 담아 전달
	   */
	@Override
	@Transactional
	public void registerMember(MemberVO memberVO) {
		memberDAO.registerMember(memberVO);
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberEmail", memberVO.getMemberEmail());
		map.put("memberPosition", "회원");
		memberDAO.registerMemberPosition(map);
	}
	
}
