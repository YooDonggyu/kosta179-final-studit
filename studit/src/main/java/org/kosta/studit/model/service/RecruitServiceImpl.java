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
}
