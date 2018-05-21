package org.kosta.studit.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.studit.exception.EmailNotFoundException;
import org.kosta.studit.exception.IsNotMemberException;
import org.kosta.studit.exception.PasswordIncorrectException;
import org.kosta.studit.model.dao.CompanyDAO;
import org.kosta.studit.model.dao.GroupDAO;
import org.kosta.studit.model.dao.MemberDAO;
import org.kosta.studit.model.dao.RecruitDAO;
import org.kosta.studit.model.dao.StudyRoomDAO;
import org.kosta.studit.model.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private CompanyDAO companyDAO;
	@Autowired
	private StudyRoomDAO studyRoomDAO;
	@Autowired
	private GroupDAO groupDAO;
	@Autowired
	private RecruitDAO recruitDAO;

	/**
	 * 회원의 로그인 로직을 처리하는 메서드.
	 * 
	 * @author 유동규
	 * @param MemberVO
	 *            로그인할 아이디와 비밀번호가 담겨있는 객체
	 * @exception EmailNotFoundException
	 *                이메일이 없는 예외처리
	 * @exception PasswordIncorrectException
	 *                비밀번호가 틀린 예외처리
	 * @exception IsNotMemberException
	 *                탈퇴된 회원 예외처리
	 * @return MemberVO 로그인할 멤버 객체 반환
	 */
	@Override
	public MemberVO login(MemberVO memberVO)
			throws EmailNotFoundException, PasswordIncorrectException, IsNotMemberException {
		// 1. 해당 Email 찾기
		MemberVO rMemberVO = memberDAO.findMemberByEmail(memberVO.getMemberEmail());
		// 2. Email 있으면 비밀번호 확인
		if (rMemberVO == null) {
			throw new EmailNotFoundException("해당 아이디가 없습니다.");
		}
		/*
		 * else if(!memberDAO.isMember(rMemberVO.getMemberEmail())){ //3. 탈퇴된 이메일인지 확인
		 * throw new IsNotMemberException("탈퇴된 아이디입니다."); }
		 */
		else if (!memberDAO.isMember(rMemberVO.getMemberEmail())) {
			// 3. 탈퇴된 이메일인지 확인
			throw new IsNotMemberException("탈퇴된 아이디입니다.");
		} else {
			// 4.비밀번호 확인
			if (rMemberVO.getPassword().equals(memberVO.getPassword())) {
				return rMemberVO;
			} else {
				throw new PasswordIncorrectException("비밀번호가 일치하지 않습니다.");
			}
		}
	}

	/**
	 * 
	 * 회원정보 수정 회원정보를 수정한 후 새로운 회원정보를 반환함
	 * 
	 * @author 김유란, 이승수
	 * @param MemberVO
	 *            수정된 회원정보를 담은 VO
	 * @return MemberVO DB에 반영된 새로운 회원 정보를 반환(세션 회원정보 업데이트 위해)
	 */
	@Override
	public MemberVO updateMember(MemberVO memberVO) {
		memberDAO.updateMember(memberVO);
		return memberDAO.findMemberByEmail(memberVO.getMemberEmail());
	}

	/**
	 * 회원가입 시 입력된 데이터를 DB에 insert하는 메서드 동시에 직책테이블에 '회원'상태로 insert한다.
	 * 
	 * @author 변태섭
	 * @param Map
	 *            회원 Email, 직책을 담아 전달
	 */
	@Override
	@Transactional
	public void registerMember(MemberVO memberVO) {
		memberDAO.registerMember(memberVO);
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberEmail", memberVO.getMemberEmail());
		map.put("memberPosition", "회원");
		memberDAO.registerMemberPosition(map);
	}

	/**
	 * 회원탈퇴를 위한 메서드. 탈퇴의 조건 : 1.신청중인 스터디가 있는가 2.팀장이면서 팀원을 가진 스터디가 있는가 3.신청중인 스터디룸이
	 * 있는가 4.업체일 경우, 승인대기중인 예약이 있는가
	 * 
	 * @author 송용준, 김유란
	 * @param memberEmail
	 *            탈퇴하고하는 회원의 이메일
	 * @return map 탈퇴 조건을 담은 HashMap 객체
	 */
	@Override
	public HashMap<String, Object> deleteMemberView(String memberEmail) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		// 팀장인 스터디 그룹 수
		// int studyGroupCount=groupDAO.findMyLeadStudyGroupCountByEmail(memberEmail);

		// 업체인지 확인. 업체면 true, 아니면 false
		Boolean isCompany = memberDAO.checkCompanyByEmail(memberEmail);
		// 신청중인 스터디의 수
		String waitStudyCount = recruitDAO.findWaitStudyByEmail(memberEmail);
		// 팀장이면서 팀원을 가진 스터디 그룹 번호, 스터디 그룹 이름
		List<Map<String, Object>> myLeadStudyGroupHasMemberList = groupDAO.findMyLeadGroupHasMemberByEmail(memberEmail);
		// 신청중인 스터디룸의 수
		String waitStudyRoomCount = studyRoomDAO.findWaitStudyRoomByEmail(memberEmail);
		// 업체일 경우, 승인대기중인 예약의 수
		String waitReservation = companyDAO.findWaitReservationByEmail(memberEmail);

		map.put("isCompany", isCompany);
		map.put("waitStudyRoomCount", waitStudyRoomCount);
		map.put("waitStudyCount", waitStudyCount);
		map.put("waitReservation", waitReservation);
		// 팀장이면서 팀원을 가진 스터디 그룹 갯수
		map.put("myLeadStudyGroupHasMemberCount", myLeadStudyGroupHasMemberList.size());
		// 팀장이면서 팀원을 가진 스터디 그룹 번호, 스터디 그룹 이름 리스트
		map.put("myLeadStudyGroupHasMemberList", myLeadStudyGroupHasMemberList);

		return map;
	}
	
	/**
	 * 탈퇴조건을 충족한 회원의 상태를 회원 -> 탈퇴로 변경 
	 * @author 송용준
	 * @param memberEmail
	 *            탈퇴하고하는 회원의 이메일
	 */
	@Override
	public void deleteMember(String memberEmail) {
		memberDAO.deleteMember(memberEmail);
	}

}
