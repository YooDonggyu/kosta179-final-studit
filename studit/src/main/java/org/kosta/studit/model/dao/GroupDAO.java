package org.kosta.studit.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.GroupMemberVO;

public interface GroupDAO {

	int findMyLeadStudyGroupCountByEmail(String memberEmail);

	List<Map<String, Object>> findMyLeadGroupHasMemberByEmail(String memberEmail);

	void createStudyGroup(HashMap<String, Object> createStudyGroupInfo);

	void registerStudyGroupMember(HashMap<String, Object> registerStudyGroupMemberInfo);

	int findStudyGroupNoByRecruitPostNo(int recruitPostNo);

	List<GroupMemberVO> findStudyGroupByMemberEmail(String memberEmail);


	String findStudyGroupNameByStudyGroupNo(String sgNo);

	String findMemberPositionByMemberEmailAndStudyGroupNo(Map<String, String> map);


	int countMyLeadGroupHasMemberByEmailAndStudyGroupNo(Map<String, String> map);

	void updateGroupMemberPosition(Map<String, String> map);

	int findGroupMemberCountByGroupNo(String groupNo);

	List<GroupMemberVO> findGroupMemberByGroupNo(Map<String, Object> map);

	void updateGroupMemberState(Map<String, String> map);


}
