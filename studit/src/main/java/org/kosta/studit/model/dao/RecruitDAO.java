package org.kosta.studit.model.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.kosta.studit.model.vo.StudyConditionVO;
import org.kosta.studit.model.PagingBean;
import org.kosta.studit.model.vo.BigCategoryVO;
import org.kosta.studit.model.vo.GroupMemberVO;
import org.kosta.studit.model.vo.RecruitPostVO;
import org.kosta.studit.model.vo.SmallCategoryVO;


public interface RecruitDAO {
	
	
	public void registerRecruitStudy(HashMap<String, Object> map);

	GroupMemberVO findGroupMemberByRecruitPostNo(int recruitPostNo);

	void updateRecruitStudy(HashMap<String, Object> map);

	int findStudyConditionCountByEmailAndRecruitNo(HashMap<String, Object> map);

	String findWaitStudyByEmail(String memberEmail);
	
	List<StudyConditionVO> findStudyConditionByMemberEmail(Map<String, Object> map);

	int findCountStudyConditionByMemberEmail(String memberEmail);

	List<RecruitPostVO> getRecruitPostList(PagingBean pagingBean);

	int getTotalRecruitPostCount();

	List<RecruitPostVO> findRecruitPostByCategoryAndKeyword(Map<String, Object> map);

	int findRecruitPostCountByCategoryAndKeyword(Map<String, Object> map);

	List<SmallCategoryVO> findSmallCategoryListByBigCategoryNo(String bigCategoryNo);

	List<BigCategoryVO> getBigCategoryList();

}
