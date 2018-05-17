package org.kosta.studit.model.service;

import org.kosta.studit.exception.EmailNotFoundException;
import org.kosta.studit.exception.IsNotMemberException;
import org.kosta.studit.exception.PasswordIncorrectException;
import org.kosta.studit.model.vo.MemberVO;

public interface MemberService {

	MemberVO login(MemberVO memberVO) throws EmailNotFoundException, PasswordIncorrectException, IsNotMemberException;

	MemberVO updateMember(MemberVO memberVO);

	void registerMember(MemberVO memberVO);
	
}
