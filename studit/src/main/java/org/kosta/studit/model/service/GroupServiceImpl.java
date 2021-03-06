package org.kosta.studit.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.studit.model.PagingBean;
import org.kosta.studit.model.dao.GroupDAO;
import org.kosta.studit.model.dao.RecruitDAO;
import org.kosta.studit.model.vo.GroupMemberListVO;
import org.kosta.studit.model.vo.GroupMemberVO;
import org.kosta.studit.model.vo.GroupPostListVO;
import org.kosta.studit.model.vo.GroupPostVO;
import org.kosta.studit.model.vo.GroupVO;
import org.kosta.studit.model.vo.MemberVO;
import org.kosta.studit.model.vo.RecruitPostVO;
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
	
	/**
	 * 스터디 그룹을 탈퇴하고자 할 때 호출 : 직책을 탈퇴로 변경
	 * @author 송용준
	 * @param sgNo 탈퇴할 스터디 그룹의 번호
	 * @param memberEmail 탈퇴할 회원 이메일
	 */
	@Override
	public void deleteStudyMember(String memberEmail, String sgNo) {
		Map<String, String> map=new HashMap<>();
		map.put("memberEmail", memberEmail);
		map.put("sgNo", sgNo);
		groupDAO.deleteStudyMember(map);
	}

	/**
	 * 스터디 그룹 멤버 목록 조회(페이징 처리)
	 * @author 김유란
	 * @param groupNo 그룹 번호
	 * @param nowPage 멤버 목록 페이지번호
	 */
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
	
	/**
	 * 스터디 개설에 대한 작업 처리
	 * 스터디 모집글 상태를 '모집완료'로, 스터디 신청 승인된 회원의 신청 상태를 '진행중'으로 변경한다.
	 * @author 김유란
	 * @param recruitPostNo 모집글 번호
	 */
	@Transactional
	@Override
	public void updateRecruitCondition(String recruitPostNo) {
		Map<String,String> map1 = new HashMap<>();
		map1.put("recruitPostNo", recruitPostNo);
		map1.put("condition", "모집완료");
		recruitDAO.updateRecruitConditionByRecruitPostNo(map1);
		List<String> confirmedList = groupDAO.findConfirmedConditionNoByRecruitPostNo(recruitPostNo);
		if(!confirmedList.isEmpty())
		for(String conditionNo: confirmedList) {
			Map<String,String> map2 = new HashMap<>();
			map2.put("state", "진행중");
			map2.put("studyConditionNo", conditionNo);
			recruitDAO.updateStudyConditionState(map2);
		}
		
	}
	
	@Override
	public void createAdditionalRecruit(RecruitPostVO recruitPostVO, String[] day) {
		//기존 글번호 저장
		String nowNo = Integer.toString(recruitPostVO.getRecruitPostNo());
		System.out.println("now:"+nowNo);
		//새 글 등록
		recruitDAO.createRecruitPost(recruitPostVO);
		//새 글번호
		String newNo = Integer.toString(recruitPostVO.getRecruitPostNo());
		System.out.println("now:"+newNo);
		//글 상태 변경(모집중->추가모집)
		Map<String,String> conditionMap = new HashMap<>();
		conditionMap.put("recruitPostNo", newNo);
		conditionMap.put("condition", "추가모집");
		recruitDAO.updateRecruitConditionByRecruitPostNo(conditionMap);
		//기존에 등록된 요일 삭제
		recruitDAO.deleteDayByRecruitNo(recruitPostVO.getRecruitPostNo());
		//요일 새로 새로 등록
		Map<String, Object> dayMap;
		for(int i =0; i<day.length; i++) {
			dayMap = new HashMap<>();
			dayMap.put("recruitPostNo", recruitPostVO.getRecruitPostNo());
			dayMap.put("recruitDay", day[i]);
			recruitDAO.registerRecruitDay(dayMap);
		}
		//코멘트, 스터디 그룹, 신청현황 글번호 변경
		Map<String,String> map = new HashMap<>();
		map.put("nowNo", nowNo);
		map.put("newNo", newNo);
		map.put("table", "recruit_post_comment");
		recruitDAO.updateRecruitPostNo(map);
		map.put("table", "study_group");
		recruitDAO.updateRecruitPostNo(map);
		map.put("table", "study_condition");
		recruitDAO.updateRecruitPostNo(map);
		
	}
	
	@Override
	public void updateGroupName(String groupNo, String name) {
		Map<String,String> map=new HashMap<>();
		map.put("name", name);
		map.put("groupNo", groupNo);
		groupDAO.updateGroupName(map);
	}
	
	/**
	 * 스터디 그룹 내 게시글을 페이징 처리하여 반환
	 * @author 송용준
	 * @param map 페이징 처리하기 위한 객체
	 * @return List<GroupPostVO> 페이징 처리된 게시글
	 */
	@Override
	public List<GroupPostVO> findGroupPostList(Map<String, Object> map){
		return groupDAO.findGroupPostList(map);
	}
	
	/**
	 * 스터디 그룹 내 게시글을 조건에 맞춰 페이징 처리하여 반환
	 * @author 송용준
	 * @param map 페이징 처리하기 위한 객체
	 * @return GroupPostListVO 페이징 처리된 게시글
	 */
	@Override
	public GroupPostListVO findGroupBoard(Map<String, Object> map) {
		List<GroupPostVO> list=null;
		PagingBean pb=null;

		if(map.get("keyword")==null || map.get("keyword")=="") {
			map.put("keyword", null);
		}
		if(map.get("name")==null || map.get("name")==""){
			map.put("name", null);
		}
		
		
		int nowPage=0;
		if(map.get("nowPage")!=null && map.get("nowPage")!="") {
			nowPage=Integer.parseInt((String)map.get("nowPage"));
		}
		
		if(nowPage==0) {
			pb=new PagingBean(groupDAO.findTotalCountOfGroupPost(map));
		}else {
			pb=new PagingBean(groupDAO.findTotalCountOfGroupPost(map), nowPage);
		}
		
		map.put("pagingBean", pb);
		list=findGroupPostList(map);
		
		GroupPostListVO pagingList=new GroupPostListVO(list, pb);
		
		return pagingList;
	}
	
	
	/**
	 * 스터디 그룹 내 게시글의 상세보기를 하고자 할 때 호출
	 * @author 송용준
	 * @param groupPostNo 상세보기를 할 게시글 번호
	 * @return GroupPostVO 상세보기할 게시글의 정보를 담은 객체
	 */
	@Override
	public GroupPostVO findGroupBoardDetail(String groupPostNo) {
		
		return groupDAO.findGroupBoardDetail(groupPostNo);
	}
	
	/**
	 * 스터디 그룹 내 게시글의 수정 하고자 할 때 호출
	 * @author 송용준
	 * @param GroupPostVO 수정 할 게시글 정보를 담은 객체
	 */
	@Override
	public void updateGroupPost(GroupPostVO gvo) {
		groupDAO.updateGroupPost(gvo);
	}
	
	/**
	 * 스터디 그룹원의 번호를 조회
	 * @author 송용준
	 * @param sgNo 스터디 그룹 번호
	 * @param memberEmail 조회할 그룹원의 이메일
	 * @return int 조회한 스터디 그룹원의 번호
	 */
	@Override
	public int getGroupMemberNo(String sgNo, String memberEmail) {
		Map<String, String> map=new HashMap<>();
		map.put("sgNo", sgNo);
		map.put("email", memberEmail);
		return groupDAO.getGroupMemberNo(map);
	}

	@Override
	public String findStudyGroupNameByStudyGroupNo(String sgNo) {
		return groupDAO.findStudyGroupNameByStudyGroupNo(sgNo);
	}

	@Override
	public List<Map<String, Object>> findTopThreeMemberByStudyGroup(String sgNo) {
		List<Map<String, Object>> list=groupDAO.findPostCountOfMemberByStudyGroup(sgNo);
		List<Map<String, Object>> flist=new ArrayList<Map<String, Object>>();
		
		for(int i=0; i<list.size(); i++) {
			if(!list.get(i).get("POSITION").equals("탈퇴")) {
				flist.add(list.get(i));
			}
			if(flist.size()>=3) {
				break;
			}
		}
		return flist;
	}

	@Override
	public int getGroupMemberCount(String sgNo) {
		List<GroupMemberVO> mvo=groupDAO.getGroupMemberCount(sgNo);
		int count=0;
		
		for(int i=0; i<mvo.size(); i++) {
			if(!mvo.get(i).getPosition().equals("탈퇴")) {
				count++;
			}
		}
		return count;
	}

}
