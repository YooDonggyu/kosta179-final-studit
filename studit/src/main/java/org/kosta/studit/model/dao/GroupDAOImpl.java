package org.kosta.studit.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.GroupMemberVO;
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
	 * @author 송용준
	 * @param registerStudyGroupMemberInfo 등록할 맴버의 정보를 담은 객체
	 */
	@Override
	public void registerStudyGroupMember(HashMap<String, Object> registerStudyGroupMemberInfo) {
		template.insert("group.registerStudyGroupMember", registerStudyGroupMemberInfo);
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
	 * 회원이 속한 스터디 그룹 전체 조회
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
	public String findStudyGroupNameByStudyGroupNo(String sgNo) {
		return template.selectOne("group.findStudyGroupNameByStudyGroupNo", sgNo);
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
}
