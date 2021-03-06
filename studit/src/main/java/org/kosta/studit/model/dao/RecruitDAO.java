package org.kosta.studit.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.BigCategoryVO;
import org.kosta.studit.model.vo.GroupMemberVO;
import org.kosta.studit.model.vo.MemberVO;
import org.kosta.studit.model.vo.RecruitPostCommentVO;
import org.kosta.studit.model.vo.RecruitPostVO;
import org.kosta.studit.model.vo.SmallCategoryVO;
import org.kosta.studit.model.vo.StudyConditionVO;

public interface RecruitDAO {

	public void registerRecruitStudy(HashMap<String, Object> map);

	GroupMemberVO findGroupMemberByRecruitPostNo(int recruitPostNo);

	void updateRecruitStudy(HashMap<String, Object> map);

	int findStudyConditionCountByEmailAndRecruitNo(HashMap<String, Object> map);

	String findWaitStudyByEmail(String memberEmail);

	List<StudyConditionVO> findStudyConditionByMemberEmail(Map<String, Object> map);

	int findCountStudyConditionByMemberEmail(String memberEmail);

	List<SmallCategoryVO> findSmallCategoryListByBigCategoryNo(String bigCategoryNo);

	List<BigCategoryVO> getBigCategoryList();

	RecruitPostVO findDetailRecruitPostAndCategoryByRecruitNo(int recruitNo);

	List<String> findDayByRecruitNo(int recruitNo);

	List<RecruitPostCommentVO> findRecruitCommentByRecruitNo(int recruitNo);

	void updateRecruitPostHitByRecruitNo(int recruitNo);

	String findRecruitWriterByRecruitNo(int recruitNo);

	String findStudyConditionStateByEmailAndRecruitNo(Map<String, Object> map);

	void updateSmallCategoryNoByRecruitNo(Map<String, Integer> map);

	void updateRecruitPostByRecruitNo(RecruitPostVO recruitPostVO);

	void deleteDayByRecruitNo(int recruitNo);

	void registerRecruitDay(Map<String, Object> map);


	void registerCommentByRecruitNo(Map<String, Object> map);

	void createRecruitPost(RecruitPostVO recruitPostVO);
	public void deleteCommentByCommentNo(int commentNo);

	public void updateCommentByCommentNo(Map<String, Object> map);

	int findRecruitPostCountByCategoryOrKeyword(Map<String, Object> map);

	List<RecruitPostVO> findRecruitPostByPagingBeanAndData(Map<String, Object> dataMap);

	public void updateDeleteRecruitPostByRecruitNo(int recruitNo);


	void updateDeleteStudyConditionByRecruitNo(int recruitNo);

	void deleteStudyConditionByStudyConditionNo(StudyConditionVO studyConditionVO);

	void registerKeyword(String keyword);

	void updateKeyword(String keyword);

	String findKeyword(String keyword);

	List<Map<String, Object>> getTopFiveKeyword();

	List<RecruitPostVO> getTopFiveRecruitPost();

	List<StudyConditionVO> findStudyConditionByGroupNo(Map<String, Object> map);

	int findStudyConditionCountByGroupNo(String groupNo);

	int updateStudyConditionState(Map<String, String> map);

	MemberVO findMemberByStudyConditionNo(String studyConditionNo);

	void updateRecruitConditionByRecruitPostNo(Map<String, String> map);

	void updateRecruitPostNo(Map<String, String> map);


}
