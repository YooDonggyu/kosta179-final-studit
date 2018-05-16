package org.kosta.studit.model.dao;

import org.kosta.studit.model.vo.MemberVO;

public interface MemberDAO {


	MemberVO findMemberByEmail(String memberEmail);

	void registerMember(MemberVO memberVO);

}
