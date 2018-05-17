package org.kosta.studit.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class StudyRoomDAOImpl implements StudyRoomDAO {
	@Autowired
	   private SqlSessionTemplate template;
	   
	   /**
	    * 신청한 스터디룸 중 승인대기중인 스터디룸이 있는가를 확인.
	    * 탈퇴하기 전에 신청한 스터디룸 중 승인대기중인 스터디룸을 처리해야 한다.
	    * @author 송용준
	    * @param memberEmail 회원 이메일
	    * @return 신청한 스터디룸 중 승인대기중인 스터디룸의 개수
	    */
	   @Override
	   public String findWaitStudyRoomByEmail(String memberEmail) {
	      String list=template.selectOne("studyroom.findWaitStudyRoomByEmail", memberEmail);
	      return list;
	   }
}
