package org.kosta.studit.model.service;

public interface GroupService {


	String findStudyGroupNameByStudyGroupNo(String sgNo);

	String findMemberPositionByMemberEmailAndStudyGroupNo(String sgNo, String memberEmail);


	int countMyLeadGroupHasMemberByEmailAndStudyGroupNo(String memberEmail, String sgNo);

	GroupMemberListVO findGroupMemberByGroupNo(String groupNo, String nowPage);

	void updateGroupMemberPosition(String groupMemberNo, String groupOwnerNo);

}
