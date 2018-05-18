
package org.kosta.studit.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.GroupMemberVO;
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

	
	/**
	 * 스터디 신청 메소드
	 * 
	 * map에 들어있는정보는 게시판번호,멤버 이메일,자기소개
	 * 
	 * @author 이승수
	 */
	@Override
	public void registerRecruitStudy(HashMap<String, Object> map) {
		template.insert("recruit.registerRecruitStudy",map);
	}
	
	/**
	 * 게시판번호로 스터디그룹멤버를 찾는 메소드
	 * 
	 * 스터디그룹에 멤버를 찾아서 스터디신청시 예외사항판단에 사용한다.
	 * 
	 * @author 이승수
	 */
	@Override
	public GroupMemberVO findGroupMemberByRecruitPostNo(int recruitPostNo) {
		GroupMemberVO gmVO = template.selectOne("recruit.findGroupMemberByRecruitPostNo", recruitPostNo);
		return gmVO;
	}
	
	@Override
    public int findStudyConditionCountByEmailAndRecruitNo(HashMap<String, Object> map) {
       return template.selectOne("recruit.findStudyConditionCountByEmailAndRecruitNo", map);
    }
	
	
	/**
	 *  스터디 신청시 사용하는 메서드.
	 *  
	 *  스터디 신청시 거절당했던 회원이 다시신청했을때 상태를 미승인 상태로 업데이트해주는 메서드
	 *  @author 이승수
	 */
	@Override
	public void updateRecruitStudy(HashMap<String, Object> map) {
		template.update("recruit.updateRecruitStudy",map);
	}

}
