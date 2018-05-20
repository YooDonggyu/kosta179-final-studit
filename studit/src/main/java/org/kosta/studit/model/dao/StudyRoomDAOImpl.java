package org.kosta.studit.model.dao;

import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.StudyRoomConditionVO;
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
	   /**
	    * paging처리를 위한 전체 스터디 룸 신청현황 수를 반환
	    * @author 유동규
	    * @return 전체 스터디룸 신청현황 수
	    */
	   @Override
	   public int getTotalStudyRoomCondition() {
		   return template.selectOne("studyroom.getTotalStudyRoomCondition");
	   }
	   /**
	    * 사용자에 따른 스터디 룸 신청현황을 반환
	    * @author 유동규
	    * @param memberEmail 현황을 조회할 사용자 Email
	    * @return List<StudyRoomConditionVO> 스터디 룸 신청현황이 담긴 객체
	    */
	   @Override
	   public List<StudyRoomConditionVO> findStudyConditionByEmail(Map<String, Object> map){
		   return template.selectList("studyroom.findStudyConditionByEmail", map);
	   }
}
