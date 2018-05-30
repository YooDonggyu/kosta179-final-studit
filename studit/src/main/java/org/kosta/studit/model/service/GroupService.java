package org.kosta.studit.model.service;

public interface GroupService {

	String findStudyGroupNameByStudyGroupNo(String sgNo);

	String findMemberPositionByMemberEmailAndStudyGroupNo(String sgNo, String memberEmail);

}
