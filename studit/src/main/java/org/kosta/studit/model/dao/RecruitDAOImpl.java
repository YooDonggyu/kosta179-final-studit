package org.kosta.studit.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RecruitDAOImpl implements RecruitDAO {
	@Autowired
	   private SqlSessionTemplate template;
	   
	   /**
	    * 신청한 스터디 중 승인대기중인 스터디가 있는가를 확인.
	    * 탈퇴하기 전에 신청한 스터디 중 승인대기중인 스터디를 처리해야 한다.
	    * @author 송용준
	    * @param memberEmail 회원 이메일
	    * @return 신청한 스터디 중 승인대기중인 스터디의 개수
	    */
	   @Override
	   public String findWaitStudyByEmail(String memberEmail) {
	      return template.selectOne("recruit.findWaitStudyByEmail", memberEmail);
	   }
}
