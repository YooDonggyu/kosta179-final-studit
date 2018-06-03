package org.kosta.studit.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.GroupMemberVO;
import org.kosta.studit.model.vo.GroupPostCommentVO;
import org.kosta.studit.model.vo.GroupPostVO;
import org.kosta.studit.model.vo.GroupVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GroupDAOImpl implements GroupDAO {
	@Autowired
	private SqlSessionTemplate template;

	/**
	 * 본인이 팀장인 스터디 그룹의 개수 조회
	 * @author 송용준
	 * @param memberEmail 회원 이메일
	 * @return int 본인이 팀장인 스터디 그룹의 개수
	 */
	@Override
	public int findMyLeadStudyGroupCountByEmail(String memberEmail) {
		return template.selectOne("group.findMyLeadStudyGroupCountByEmail", memberEmail);

	}

	/**
	 * 본인이 팀장인 스터디 그룹 중 팀원이 있는 그룹 조회
	 * @author 송용준
	 * @param memberEmail 회원 이메일
	 * @return Map<String, Object> 스터디 그룹 정보. Key : 스터디 그룹 넘버, 그룹 이름
	 */
	@Override
	public List<Map<String, Object>> findMyLeadGroupHasMemberByEmail(String memberEmail) {
		return template.selectList("group.findMyLeadGroupHasMemberByEmail", memberEmail);
	}

	/**
	 * 스터디 그룹을 등록하는 메서드
	 * @author 송용준
	 * @param createStudyGroupInfo 등록할 스터디 그룹의 정보를 담은 객체
	 */
	@Override
	public void createStudyGroup(HashMap<String, Object> createStudyGroupInfo) {
		template.insert("group.createStudyGroup", createStudyGroupInfo);
	}

	/**
	 * 스터디 그룹의 맴버를 등록하는 메서드
	 * @author 송용준, 김유란
	 * @param registerStudyGroupMemberInfo 등록할 맴버의 정보를 담은 객체-> GroupMemberVO로 변경
	 */
	@Override
	public void registerStudyGroupMember(GroupMemberVO groupMemberVO) {
		template.insert("group.registerStudyGroupMember", groupMemberVO);
	}

	/**
	 * 해당 모집글과 연결된 스터디 그룹의 번호를 조회
	 * @author 송용준
	 * @param recruitPostNo 스터디 그룹을 조회할 때 사용할 모집글 번호
	 * @return int 스터디 그룹 번호
	 */
	@Override
	public int findStudyGroupNoByRecruitPostNo(int recruitPostNo) {
		return template.selectOne("group.findStudyGroupNoByRecruitPostNo", recruitPostNo);
	}
	
	
	/**
	 * 회원이 속한 스터디 그룹 전체 정보 및 본인의 직책 조회
	 * @author 김유란
	 * @param memberEmail 회원 이메일
	 * @return List<GroupMemberVO> 스터디그룹 정보를 담은 VO 리스트
	 */
	@Override
	public List<GroupMemberVO> findStudyGroupByMemberEmail(String memberEmail) {
		return template.selectList("group.findStudyGroupByMemberEmail", memberEmail);
	}
	

	/**
	 * 스터디 그룹 이름을 조회
	 * @author 송용준
	 * @param sgNo 이름을 조회할 스터디 그룹 번호
	 * @return 스터디 그룹 이름
	 */
	@Override
	public GroupVO findStudyGroupInfoByStudyGroupNo(String sgNo) {
		return template.selectOne("group.findStudyGroupInfoByStudyGroupNo", sgNo);
	}
	
	/**
	 * 회원이 가지고 있는 스터디 그룹 내의 직책을 조회 
	 * @author 송용준
	 * @param sgNo 조회할 스터디 그룹 번호
	 * @param memberEmail 직책을 확인할 회원의 이메일
	 * @return 회원의 직책
	 */
	@Override
	public String findMemberPositionByMemberEmailAndStudyGroupNo(Map<String, String> map) {
		return template.selectOne("group.findMemberPositionByMemberEmailAndStudyGroupNo", map);
	}

	@Override
	public void deleteStudyMember(Map<String, String> map) {
		template.update("group.deleteStudyMember", map);
	}

	/**
	 * 스터디 그룹 멤버 수를 조회 
	 * @author 김유란
	 * @param groupNo 조회할 스터디 그룹 번호
	 * @return 그룹 멤버 수
	 */
	public int findGroupMemberCountByGroupNo(String groupNo) {
		return template.selectOne("group.findGroupMemberCountByGroupNo", groupNo);
	}
	
	/**
	 * 스터디 그룹에 속한 멤버 정보 조회
	 * @author 김유란
	 * @param groupNo 그룹 번호
	 * @return List<GroupMemberVO> 그룹 멤버 정보를 담은 VO 리스트
	 */
	@Override
	public List<GroupMemberVO> findGroupMemberByGroupNo(Map<String,Object> map){
		return template.selectList("group.findGroupMemberByGroupNo", map);
	}
	

	/**
	 * 스터디 그룹 멤버의 직책 변경(팀장<->팀원)
	 * @author 김유란
	 * @param map 변경할 직책명과 변경 대상의 그룹 멤버 번호를 담은 map
	 */
	@Override
	public void updateGroupMemberPosition(Map<String, String> map) {
		template.update("group.updateGroupMemberPosition", map);
	}
	
	/**
	 * 스터디 그룹 게시판의 총 게시글 갯수를 반환
	 * @author 송용준
	 * @param map 스터디 그룹 정보를 담은 객체
	 */
	@Override
	public int findTotalCountOfGroupPost(Map<String, Object> map) {
		return template.selectOne("group.findTotalCountOfGroupPost", map);
	}
	
	/**
	 * 조건에 맞는 스터디 그룹 게시판의 게시글 리스트 반환
	 * @author 송용준
	 * @param map 검색 조건을 담은 객체
	 * @return List<GroupPostVO> 검색 조건에 부합하는 게시글 리스트
	 */
	@Override
	public List<GroupPostVO> findGroupPostList(Map<String, Object> map) {
		return template.selectList("group.findGroupPostList", map);
	}
	
	/**
	 * 스터디 그룹 내 게시글의 상세보기를 하고자 할 때 호출
	 * @author 송용준
	 * @param groupPostNo 상세보기를 할 게시글 번호
	 * @return GroupPostVO 상세보기할 게시글의 정보를 담은 객체
	 */
	@Override
	public GroupPostVO findGroupBoardDetail(String groupPostNo) {
		return template.selectOne("group.findGroupBoardDetail", groupPostNo);
	}
	
	/**
	 * 스터디 그룹 내 게시글의 수정 하고자 할 때 호출
	 * @author 송용준
	 * @param GroupPostVO 수정 할 게시글 정보를 담은 객체
	 */
	@Override
	public void updateGroupPost(GroupPostVO gvo) {
		template.update("group.updateGroupPost", gvo);
	}
	
	/**
	 * 스터디 그룹원의 번호를 조회
	 * @author 송용준
	 * @param sgNo 스터디 그룹 번호
	 * @param memberEmail 조회할 그룹원의 이메일
	 * @return int 조회한 스터디 그룹원의 번호
	 */
	@Override
	public int getGroupMemberNo(Map<String, String> map) {
		return template.selectOne("group.getGroupMemberNo", map);
	}
	
	/**
	 * 스터디 그룹 내 게시글을 등록
	 * @author 송용준
	 * @param title, content 작성한 게시글 정보
	 * @return 상세보기 화면으로 이동
	 */
	@Override
	public void createGroupPost(GroupPostVO gvo) {
		template.insert("group.createGroupPost", gvo);
	}
	
	/**
	 * 스터디 그룹 내 게시글 삭제
	 * @author 송용준
	 * @param gpNo 삭제할 게시글의 번호
	 * @return 삭제 완료 후, 게시판 첫 페이지로 이동
	 */
	@Override
	public void deleteGroupPost(String gpNo) {
		template.delete("group.deleteGroupPost", gpNo);
	}
	
	/**
	 * 스터디 그룹 게시판 내 게시글의 작성자 이메일을 반환
	 * @author 송용준
	 * @param gpNo 작성자를 찾을 게시글의 번호
	 * @return 해당 게시글의 작성자 이메일
	 */
	@Override
	public String findGroupPostWriterByGroupPostNo(String gpNo) {
		return template.selectOne("group.findGroupPostWriterByGroupPostNo", gpNo);
	}
	
	/**
	 * 스터디 그룹 게시판 내 게시글의 조회수를 증가
	 * @author 송용준
	 * @param gpNo 조회수를 증가할 게시글의 번호
	 */
	@Override
	public void updateGroupPostHitByGroupPostNo(String gpNo) {
		template.update("group.updateGroupPostHitByGroupPostNo", gpNo);
	}

	/**
	 * 스터디 그룹 멤버의 그룹 즐겨찾기 상태 변경(true or false)
	 * @author 김유란
	 * @param map 변경할 상태명과 그룹멤버 번호 또는 회원 이메일 정보를 담은 map
	 */
	@Override
	public void updateGroupMemberState(Map<String,String> map) {
		template.update("group.updateGroupMemberState", map);
	}
	
	/**
	 * 스터디 신청 승인된 회원의 신청 번호를 조회
	 * 스터디 모집완료시 신청상태를 '진행중'으로 변경하기 위해 호출
	 * @author 김유란
	 * @param recruitPostNo 신청한 스터디 모집글 번호
	 * @return List<String> 신청번호를 담은 list
	 */
	@Override
	public List<String> findConfirmedConditionNoByRecruitPostNo(String recruitPostNo){
		return template.selectList("group.findConfirmedConditionNoByRecruitPostNo", recruitPostNo);
	}
	
	@Override
	public void updateGroupName(Map<String,String> map) {
		template.update("group.updateGroupName", map);
	}

	@Override
	public List<GroupPostCommentVO> findGroupPostCommentByGroupPostNo(String gpNo) {
		return template.selectList("group.findGroupPostCommentByGroupPostNo", gpNo);
	}

	@Override
	public void registerGroupPostComment(Map<String, Object> map) {
		template.insert("group.registerGroupPostComment", map);
	}

	@Override
	public void deleteGroupPostCommentByCommentNo(String commentNo) {
		template.delete("group.deleteGroupPostCommentByCommentNo", commentNo);
	}

	@Override
	public void updateGroupPostCommentByCommentNo(Map<String, String> map) {
		template.update("group.updateGroupPostCommentByCommentNo", map);
	}

	@Override
	public String findStudyGroupNameByStudyGroupNo(String sgNo) {
		return template.selectOne("group.findStudyGroupNameByStudyGroupNo", sgNo);
	}

	@Override
	public List<Map<String, Object>> findPostCountOfMemberByStudyGroup(String sgNo) {
		List<Map<String, Object>> list=template.selectList("group.findPostCountOfMemberByStudyGroup", sgNo);
		return list;
	}

}
