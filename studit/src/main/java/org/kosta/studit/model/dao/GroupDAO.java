package org.kosta.studit.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.GroupMemberVO;
import org.kosta.studit.model.vo.GroupPostCommentVO;
import org.kosta.studit.model.vo.GroupPostVO;
import org.kosta.studit.model.vo.GroupVO;
import org.kosta.studit.model.vo.MemberVO;
import org.kosta.studit.model.vo.MemoVO;

public interface GroupDAO {

	int findMyLeadStudyGroupCountByEmail(String memberEmail);

	List<Map<String, Object>> findMyLeadGroupHasMemberByEmail(String memberEmail);

	void createStudyGroup(HashMap<String, Object> createStudyGroupInfo);

	int findStudyGroupNoByRecruitPostNo(int recruitPostNo);

	List<GroupMemberVO> findStudyGroupByMemberEmail(String memberEmail);
	
	String findMemberPositionByMemberEmailAndStudyGroupNo(Map<String, String> map);

	void deleteStudyMember(Map<String, String> map);

	void updateGroupMemberPosition(Map<String, String> map);

	int findGroupMemberCountByGroupNo(String groupNo);

	List<GroupMemberVO> findGroupMemberByGroupNo(Map<String, Object> map);

	void updateGroupMemberState(Map<String, String> map);

	void registerStudyGroupMember(GroupMemberVO groupMemberVO);

	GroupVO findStudyGroupInfoByStudyGroupNo(String sgNo);

	List<String> findConfirmedConditionNoByRecruitPostNo(String recruitPostNo);

	void updateGroupName(Map<String, String> map);

	int findTotalCountOfGroupPost(Map<String, Object> map);

	List<GroupPostVO> findGroupPostList(Map<String, Object> map);

	GroupPostVO findGroupBoardDetail(String groupPostNo);

	void updateGroupPost(GroupPostVO gvo);

	void createGroupPost(GroupPostVO gvo);

	int getGroupMemberNo(Map<String, String> map);

	void deleteGroupPost(String gpNo);

	String findGroupPostWriterByGroupPostNo(String gpNo);

	void updateGroupPostHitByGroupPostNo(String gpNo);

	List<GroupPostCommentVO> findGroupPostCommentByGroupPostNo(String gpNo);

	void registerGroupPostComment(Map<String, Object> map);

	void deleteGroupPostCommentByCommentNo(String commentNo);

	void updateGroupPostCommentByCommentNo(Map<String, String> map);

	String findStudyGroupNameByStudyGroupNo(String sgNo);

	List<Map<String, Object>> findPostCountOfMemberByStudyGroup(String sgNo);

	int getTotalStudyGroupCount();

	MemberVO findStudyGroupLeaderByStudyNo(String sgNo);

	List<GroupMemberVO> getGroupMemberCount(String sgNo);

	List<MemoVO> findStudyGroupMemoByStudyGroupNo(int groupNo);

	void registerStudyGroupMemo(MemoVO memoVO);

	void updateStudyGroupMemoPosition(Map<String, Object> map);

	void deleteStudyGroupMemo(int memoNo);
}
