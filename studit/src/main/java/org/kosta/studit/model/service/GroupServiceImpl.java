package org.kosta.studit.model.service;

import java.util.HashMap;
import java.util.Map;

import org.kosta.studit.model.dao.GroupDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GroupServiceImpl implements GroupService {
	@Autowired
	private GroupDAO groupDAO;
	
	/**
	 * 스터디 그룹 이름을 조회
	 * @author 송용준
	 * @param sgNo 이름을 조회할 스터디 그룹 번호
	 * @return 스터디 그룹 이름
	 */
	@Override
	public String findStudyGroupNameByStudyGroupNo(String sgNo) {
		return groupDAO.findStudyGroupNameByStudyGroupNo(sgNo);
	}
	
	/**
	 * 회원이 가지고 있는 스터디 그룹 내의 직책을 조회 
	 * @author 송용준
	 * @param sgNo 조회할 스터디 그룹 번호
	 * @param memberEmail 직책을 확인할 회원의 이메일
	 * @return 회원의 직책
	 */
	@Override
	public String findMemberPositionByMemberEmailAndStudyGroupNo(String sgNo, String memberEmail) {
		Map<String, String> map=new HashMap<>();
		map.put("sgNo", sgNo);
		map.put("memberEmail", memberEmail);
		return groupDAO.findMemberPositionByMemberEmailAndStudyGroupNo(map);
	}

}
