package org.kosta.studit.model.dao;

import java.util.List;
import java.util.Map;

public interface GroupDAO {

	int findMyLeadStudyGroupCountByEmail(String memberEmail);

	List<Map<String, Object>> findMyLeadGroupHasMemberByEmail(String memberEmail);

}
