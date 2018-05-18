package org.kosta.studit.model.service;

import org.kosta.studit.model.vo.StudyConditionListVO;

public interface RecruitService {

	StudyConditionListVO findStudyConditionByMemberEmail(String memberEmail, String pageNo);
	
}
