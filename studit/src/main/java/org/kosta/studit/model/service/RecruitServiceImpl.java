package org.kosta.studit.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.kosta.studit.model.PagingBean;
import org.kosta.studit.model.dao.RecruitDAO;
import org.kosta.studit.model.vo.StudyConditionListVO;
import org.kosta.studit.model.vo.StudyConditionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RecruitServiceImpl implements RecruitService {
	@Autowired
	private RecruitDAO recruitDAO;
	
	/**
	 * 스터디 현황 조회 시 내역 list를 불러온다.
	 * 
	 * @author 변태섭
	 * @param String 회원 Email
	 * @return StudyConditionVO 스터디 현황 내역 list
	 */
	@Override
	public StudyConditionListVO findStudyConditionByMemberEmail(String memberEmail, String pageNo) {
		PagingBean pb=null;
		if(pageNo==null) {
			pb = new PagingBean(recruitDAO.findCountStudyConditionByMemberEmail(memberEmail));
		}else {
			pb = new PagingBean(recruitDAO.findCountStudyConditionByMemberEmail(memberEmail), Integer.parseInt(pageNo));
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberEmail", memberEmail);
		map.put("pb", pb);
		
		List<StudyConditionVO> list = recruitDAO.findStudyConditionByMemberEmail(map);
		
		StudyConditionListVO studyConditionListVO = new StudyConditionListVO(list, pb);
		
		return studyConditionListVO;
	}

	/**
	 * 스터디를 신청할떄 사용하는 메서드.
	 * 
	 * 스터디게시글번호,회원이메일,자기소개내용을 받아 Map에 저장해서 DAO에 전달
	 * 
	 * @author 이승수
     * @param 스터디게시글번호,회원이메일,자기소개내용
	 */
	@Override
	public void registerRecruitStudy(int recruitPostNo, String memberEmail, String context) {
			HashMap<String,Object> map = new HashMap<String,Object>();
			map.put("recruitPostNo", recruitPostNo);
			map.put("memberEmail", memberEmail);
			map.put("context", context);
			recruitDAO.registerRecruitStudy(map);
	}
	
	/**
	 * 스터디를 신청할떄 사용하는 메서드.
	 * 
	 * 스터디신청시 이미 거절상태일때 다시 미승인 상태로 바꿔주는 메서드.
	 * 
	 * @author 이승수
     * @param 스터디게시글번호,회원이메일,자기소개내용
	 */
	@Override
	public void updateRecruitStudy(int recruitPostNo, String memberEmail, String context) {
			HashMap<String,Object> map = new HashMap<String,Object>();
			map.put("recruitPostNo", recruitPostNo);
			map.put("memberEmail", memberEmail);
			map.put("context", context);
			recruitDAO.updateRecruitStudy(map);
	}

}
