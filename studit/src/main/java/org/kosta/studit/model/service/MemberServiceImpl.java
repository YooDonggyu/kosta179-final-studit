package org.kosta.studit.model.service;

import org.kosta.studit.exception.EmailNotFoundException;
import org.kosta.studit.exception.PasswordIncorrectException;
import org.kosta.studit.model.dao.MemberDAO;
import org.kosta.studit.model.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {
	

	   @Autowired
	   private MemberDAO memberDAO;
	   
	   
	   /**
	    * 
	    */
	   @Override
	   public MemberVO login(MemberVO memberVO) throws EmailNotFoundException, PasswordIncorrectException {
	      //1. 해당 Email 찾기
	      MemberVO rMemberVO = memberDAO.findMemberByEmail(memberVO.getMemberEmail());
	      //2. Email 있으면 비밀번호 확인
	      //   없으면 exception발생
	      if(rMemberVO == null) {
	         //EmailNotFoundException발생
	         throw new EmailNotFoundException("해당 아이디가 없습니다.");
	      }else {
	         //비밀번호 확인
	         //3. 비밀번호 일치하면 리턴
	         //    비밀번호 일치하지 않으면 exception 발생
	         if(rMemberVO.getPassword().equals(memberVO.getPassword())) {
	            return rMemberVO;
	         }else {
	            //PasswordIncorrectException 발생
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
	
}
