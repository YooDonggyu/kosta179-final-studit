package org.kosta.studit.model.dao;

import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.StudyConditionVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RecruitDAOImpl implements RecruitDAO {
	@Autowired
	SqlSessionTemplate template;
	
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
	
	/**
	 * 스터디 현황 조회 시 내역 list를 불러온다.
	 * 
	 * @author 변태섭
	 * @param String 회원 Email
	 * @return StudyConditionVO 스터디 현황 내역 list
	 */
	@Override
	public List<StudyConditionVO> findStudyConditionByMemberEmail(Map<String, Object> map){
			return template.selectList("recruit.findStudyConditionByMemberEmail", map);
	}
	
	/**
	 * 스터디 내역 개수를 가져온다.
	 * 
	 * @author 변태섭
	 * @param String 회원 Email
	 * @return int 스터디 내역 개수
	 */
	@Override
	public int findCountStudyConditionByMemberEmail(String memberEmail) {
		return template.selectOne("recruit.findCountStudyConditionByMemberEmail", memberEmail);
	}
}
