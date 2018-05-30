package org.kosta.studit.model.service;

import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public class GroupServiceImpl implements GroupService {

	@Override
	public String findStudyGroupNameByStudyGroupNo(String sgNo) {
		return "";
	}

	@Override
	public Map<String, String> findScheduleByStudyGroupNo(String sgNo) {
		return null;
	}

	@Override
	public String findMemberPositionByMemberEmailAndStudyGroupNo(String sgNo, String memberEmail) {
		return null;
	}

}
