package org.kosta.studit.model.dao;

import java.util.Map;

import org.kosta.studit.model.vo.MemberVO;

public interface MemberDAO {


	MemberVO findMemberByEmail(String memberEmail);

	void registerMember(MemberVO memberVO);
	
	void updateMember(MemberVO memberVO);

	void updatePassword(MemberVO memberVO);

	void registerMemberPosition(Map<String, String> map);

	boolean isMember(String memberEmail);

	Boolean checkCompanyByEmail(String memberEmail);

	void deleteMember(String memberEmail);

	int findCountMemberPositionByMemberPositionAndMemberEmail(Map<String, String> map);

	void updatePasswordForFindPassword(Map<String, String> map);

	String findPasswordHint(String memberEmail);

	String findPasswordAnswer(String memberEmail);

}
