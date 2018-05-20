package org.kosta.studit.model.service;

import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.RecruitPostListVO;
import org.kosta.studit.model.vo.RecruitPostVO;
import org.kosta.studit.model.vo.StudyConditionListVO;

public interface RecruitService {
	
	public void registerRecruitStudy(int recruitPostNo,String memberEmail, String context);

	void updateRecruitStudy(int recruitPostNo, String memberEmail, String context);

	StudyConditionListVO findStudyConditionByMemberEmail(String memberEmail, String pageNo);

	RecruitPostListVO findRecruitPostByCategoryAndKeyword(String[] category, String keyword, String pageNo);

	RecruitPostListVO getRecruitPostList(String pageNo);

	Map<String, Object> findRecruitPostDetailByRecruitNo(String memberEmail, int recruitNo);

	void updateRecruitPostInfoByRecruitNo(RecruitPostVO recruitPostVO, List<String> days);
	
}
