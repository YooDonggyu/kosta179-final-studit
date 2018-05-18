package org.kosta.studit.model.service;

import org.kosta.studit.model.vo.StudyConditionListVO;

public interface RecruitService {
	
	public void registerRecruitStudy(int recruitPostNo,String memberEmail, String context);

	void updateRecruitStudy(int recruitPostNo, String memberEmail, String context);

	StudyConditionListVO findStudyConditionByMemberEmail(String memberEmail, String pageNo);
	
}
