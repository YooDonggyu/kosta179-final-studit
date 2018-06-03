package org.kosta.studit.model.service;

import java.util.List;
import java.util.Map;

import org.kosta.studit.model.PagingBean;
import org.kosta.studit.model.vo.GroupMemberListVO;
import org.kosta.studit.model.vo.GroupPostListVO;
import org.kosta.studit.model.vo.GroupPostVO;
import org.kosta.studit.model.vo.GroupVO;
import org.kosta.studit.model.vo.RecruitPostVO;

public interface GroupService {

	String findMemberPositionByMemberEmailAndStudyGroupNo(String sgNo, String memberEmail);

	void deleteStudyMember(String memberEmail, String sgNo);

	GroupMemberListVO findGroupMemberByGroupNo(String groupNo, String nowPage);

	void updateGroupMemberPosition(String groupMemberNo, String groupOwnerNo);

	void updateGroupMemberState(String memberEmail, String[] checkBookmark);

	void registerGroupMember(String state, String studyConditionNo, String groupNo);

	GroupVO findStudyGroupInfoByStudyGroupNo(String sgNo);

	void updateRecruitCondition(String recruitPostNo);

	void createAdditionalRecruit(RecruitPostVO recruitPostVO, String[] day);

	void updateGroupName(String groupNo, String name);

	GroupPostListVO findGroupBoard(Map<String, Object> map);

	List<GroupPostVO> findGroupPostList(Map<String, Object> map);

	GroupPostVO findGroupBoardDetail(String groupPostNo);

	void updateGroupPost(GroupPostVO gvo);

	int getGroupMemberNo(String sgNo, String memberEmail);

	String findStudyGroupNameByStudyGroupNo(String sgNo);

	List<Map<String, Object>> findTopThreeMemberByStudyGroup(String sgNo);

	int getGroupMemberCount(String sgNo);

}
