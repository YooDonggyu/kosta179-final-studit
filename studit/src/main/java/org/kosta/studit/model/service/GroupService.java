package org.kosta.studit.model.service;

import org.kosta.studit.model.vo.GroupMemberListVO;

public interface GroupService {


	String findStudyGroupNameByStudyGroupNo(String sgNo);

	String findMemberPositionByMemberEmailAndStudyGroupNo(String sgNo, String memberEmail);


	int countMyLeadGroupHasMemberByEmailAndStudyGroupNo(String memberEmail, String sgNo);

	GroupMemberListVO findGroupMemberByGroupNo(String groupNo, String nowPage);

	void updateGroupMemberPosition(String groupMemberNo, String groupOwnerNo);

	void updateGroupMemberState(String memberEmail, String[] checkBookmark);

}
