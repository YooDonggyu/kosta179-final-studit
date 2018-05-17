package org.kosta.studit.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CompanyDAOImpl implements CompanyDAO {
	@Autowired
	   private SqlSessionTemplate template;
	   
	   /**
	    * 승인대기중인 예약이 있는가를 확인.
	    * 업체라면, 탈퇴하기 전에 승인대기중인 예약건수를 처리해야 한다.
	    * @author 송용준
	    * @param memberEmail 회원 이메일
	    * @return 승인대기중인 예약의 개수
	    */
	   @Override
	   public String findWaitReservationByEmail(String memberEmail) {
	      return template.selectOne("company.findWaitReservationByEmail", memberEmail);
	   }
}
