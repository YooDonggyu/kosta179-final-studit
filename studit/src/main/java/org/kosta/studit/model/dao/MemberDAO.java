package org.kosta.studit.model.dao;

import org.kosta.studit.model.vo.MemberVO;
import org.springframework.stereotype.Repository;

public interface MemberDAO {


	MemberVO findMemberByEmail(String memberEmail);

}
