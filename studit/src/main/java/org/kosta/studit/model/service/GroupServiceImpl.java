package org.kosta.studit.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.studit.model.PagingBean;
import org.kosta.studit.model.dao.GroupDAO;
import org.kosta.studit.model.dao.RecruitDAO;
import org.kosta.studit.model.vo.GroupMemberListVO;
import org.kosta.studit.model.vo.GroupMemberVO;
import org.kosta.studit.model.vo.GroupVO;
import org.kosta.studit.model.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class GroupServiceImpl implements GroupService {
	@Autowired
	private GroupDAO groupDAO;
	@Autowired
	private RecruitDAO recruitDAO;
	
	
	/**
	 * 스터디 그룹 이름을 조회
	 * @author 송용준, 김유란 (groupName->groupInfo로 변경)
	 * @param sgNo 이름을 조회할 스터디 그룹 번호
	 * @return 스터디 그룹 이름
	 */
	@Override
	public GroupVO findStudyGroupInfoByStudyGroupNo(String sgNo) {
		return groupDAO.findStudyGroupInfoByStudyGroupNo(sgNo);
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


	@Override
	public int countMyLeadGroupHasMemberByEmailAndStudyGroupNo(String memberEmail, String sgNo) {
		Map<String, String> map=new HashMap<>();
		map.put("memberEmail", memberEmail);
		map.put("sgNo", sgNo);
		
		return groupDAO.countMyLeadGroupHasMemberByEmailAndStudyGroupNo(map);
	}

	
	@Override
	public GroupMemberListVO findGroupMemberByGroupNo(String groupNo, String nowPage) {
		PagingBean pagingBean = null;
		if(nowPage!=null) {
			pagingBean = new PagingBean(groupDAO.findGroupMemberCountByGroupNo(groupNo), Integer.parseInt(nowPage));
		}else {
			pagingBean = new PagingBean(groupDAO.findGroupMemberCountByGroupNo(groupNo));
		}
		Map<String, Object> map = new HashMap<>();
		map.put("groupNo", groupNo);
		map.put("pagingBean", pagingBean);
		return new GroupMemberListVO(pagingBean, groupDAO.findGroupMemberByGroupNo(map));
	}
	
	/**
	 * 스터디 그룹 멤버 직책 변경(팀장<->팀원) 
	 * @author 김유란
	 * @param groupMemberNo 팀장을 위임받을 멤버 번호
	 * @param groupOwnerNo 현재 팀장의 멤버 번호
	 */
	@Transactional
	@Override
	public void updateGroupMemberPosition(String groupMemberNo, String groupOwnerNo) {
		Map<String,String> map=new HashMap<>();
		map.put("position", "팀장");
		map.put("groupMemberNo", groupMemberNo);
		groupDAO.updateGroupMemberPosition(map);
		map.put("position", "팀원");
		map.put("groupMemberNo", groupOwnerNo);
		groupDAO.updateGroupMemberPosition(map);
	}
	
	/**
	 * 스터디 그룹 멤버의 즐겨찾기 상태 변경
	 *  회원이메일을 이용해 회원의 모든 가입 그룹 상태를 false로 변경한 뒤
	 *  checkBookmark에 값이 있으면 해당 그룹만 true로 변경 
	 * @author 김유란
	 * @param memberEmail 회원 이메일
	 * @param checkBookmark 선택된 그룹 번호값을 담은 배열
	 */
	@Override
	public void updateGroupMemberState(String memberEmail, String[] checkBookmark) {
		Map<String,String> map = new HashMap<>();
		map.put("state", "false");
		map.put("memberEmail", memberEmail);
		groupDAO.updateGroupMemberState(map);
		map.remove("memberEmail");
		if(checkBookmark!=null && checkBookmark.length!=0) {
			map.put("state", "true");
			for(int i=0; i<checkBookmark.length; i++) {
				map.put("groupMemberNo", checkBookmark[i]);
				groupDAO.updateGroupMemberState(map);
			}
		}
	}
	
	
	/**
	 * 스터디 신청 상태를 변경하고 '승인'일 경우 스터디 그룹 멤버를 등록하는  메서드
	 * @author 김유란
	 * @param state 스터디 신청 결과(승인 or 거절)
	 * @param nowPage studyConditionNo 스터디 신청 번호
	 * @param GroupMemberVO 멤버 정보(메일, 포지션, 그룹 번호)
	 */
	@Transactional
	@Override
	public void registerGroupMember(String state, String studyConditionNo, String groupNo) {
		Map<String, String> map = new HashMap<>();
		GroupMemberVO groupMemberVO = new GroupMemberVO();
		map.put("state", state);
		map.put("studyConditionNo", studyConditionNo);
		recruitDAO.updateStudyConditionState(map);
		if(state.equals("승인")) {
			groupMemberVO.setPosition("팀원");
			groupMemberVO.setMemberVO(new MemberVO(recruitDAO.findMemberByStudyConditionNo(studyConditionNo).getMemberEmail(), null));
			GroupVO groupVO = new GroupVO();
			groupVO.setGroupNo(Integer.parseInt(groupNo));
			groupMemberVO.setGroupVO(groupVO);
			groupDAO.registerStudyGroupMember(groupMemberVO);
		}
	}
	
	@Override
	public void updateRecruitCondition(String recruitPostNo) {
		recruitDAO.updateRecruitCondition(recruitPostNo);
		List<String> confirmedList = groupDAO.findConfirmedConditionNoByGroupNo(recruitPostNo);
		if(!confirmedList.isEmpty())
		for(String conditionNo: confirmedList) {
			Map<String,String> map = new HashMap<>();
			map.put("state", "진행중");
			map.put("studyConditionNo", conditionNo);
			recruitDAO.updateStudyConditionState(map);
		}
		
	}

}
