package org.kosta.studit.model.dao;

import org.kosta.studit.model.vo.MemberVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Autowired
	private SqlSessionTemplate template;
	
	@Override
	public MemberVO findMemberByEmail(String memberEmail) {
		return template.selectOne("member.findMemberByEmail", memberEmail);
	}

}
