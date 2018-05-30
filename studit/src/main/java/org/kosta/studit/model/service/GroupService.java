package org.kosta.studit.model.service;

import java.util.Map;

public interface GroupService {

	String findStudyGroupNameByStudyGroupNo(String sgNo);

	Map<String, String> findScheduleByStudyGroupNo(String sgNo);

	String findMemberPositionByMemberEmailAndStudyGroupNo(String sgNo, String memberEmail);

}
