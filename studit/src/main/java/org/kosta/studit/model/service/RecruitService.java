package org.kosta.studit.model.service;

import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.BigCategoryVO;
import org.kosta.studit.model.vo.RecruitPostListVO;
import org.kosta.studit.model.vo.RecruitPostVO;
import org.kosta.studit.model.vo.SmallCategoryVO;
import org.kosta.studit.model.vo.StudyConditionListVO;

public interface RecruitService {
	public void registerRecruitStudy(int recruitPostNo,String memberEmail, String context);

	void updateRecruitStudy(int recruitPostNo, String memberEmail, String context);


	Map<String, Object> findRecruitPostDetailByRecruitNo(String memberEmail, int recruitNo);

	void updateRecruitPostInfoByRecruitNo(RecruitPostVO recruitPostVO, List<String> days);


	StudyConditionListVO findStudyConditionByMemberEmail(String memberEmail, int nowPage);
	
	public void createRecruitPost(RecruitPostVO recruitPostVO, String[] recruitDay);

	public List<BigCategoryVO> getBigCategoryList();

	public List<SmallCategoryVO> findSmallCategoryListByBigCategoryNo(String bigCategoryNo);


	public RecruitPostListVO findRecruitPostByCategoryOrKeyword(String bigCategoryNo, String smallCategoryNo,
			String keyword, int nowPage);

	void deleteStudyConditionByStudyConditionNo(String memberEmail, String studyConditionNo);
}
