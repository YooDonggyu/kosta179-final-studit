package org.kosta.studit.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface GroupDAO {

	int findMyLeadStudyGroupCountByEmail(String memberEmail);

	List<Map<String, Object>> findMyLeadGroupHasMemberByEmail(String memberEmail);

	void createStudyGroup(HashMap<String, Object> createStudyGroupInfo);

	void registerStudyGroupMember(HashMap<String, Object> registerStudyGroupMemberInfo);

	int findStudyGroupNoByRecruitPostNo(int recruitPostNo);

}
