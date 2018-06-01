package org.kosta.studit.model.service;

import org.kosta.studit.model.vo.GroupMemberListVO;
import org.kosta.studit.model.vo.GroupVO;

public interface GroupService {

	String findMemberPositionByMemberEmailAndStudyGroupNo(String sgNo, String memberEmail);

	int countMyLeadGroupHasMemberByEmailAndStudyGroupNo(String memberEmail, String sgNo);

	GroupMemberListVO findGroupMemberByGroupNo(String groupNo, String nowPage);

	void updateGroupMemberPosition(String groupMemberNo, String groupOwnerNo);

	void updateGroupMemberState(String memberEmail, String[] checkBookmark);

	void registerGroupMember(String state, String studyConditionNo, String groupNo);

	GroupVO findStudyGroupInfoByStudyGroupNo(String sgNo);

	void updateRecruitCondition(String recruitPostNo);

}
