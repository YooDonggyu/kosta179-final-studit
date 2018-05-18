package org.kosta.studit.model.dao;

import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.StudyConditionVO;

public interface RecruitDAO {

	String findWaitStudyByEmail(String memberEmail);
	
	List<StudyConditionVO> findStudyConditionByMemberEmail(Map<String, Object> map);

	int findCountStudyConditionByMemberEmail(String memberEmail);

}
