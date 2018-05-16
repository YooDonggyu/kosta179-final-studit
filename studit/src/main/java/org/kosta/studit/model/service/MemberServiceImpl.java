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

	
}
