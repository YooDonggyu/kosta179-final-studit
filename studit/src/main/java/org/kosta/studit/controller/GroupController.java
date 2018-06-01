package org.kosta.studit.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.kosta.studit.model.dao.GroupDAO;
import org.kosta.studit.model.dao.RecruitDAO;
import org.kosta.studit.model.service.GroupService;
import org.kosta.studit.model.service.RecruitService;
import org.kosta.studit.model.vo.GroupMemberVO;
import org.kosta.studit.model.vo.GroupVO;
import org.kosta.studit.model.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/group")
public class GroupController {
	
	private RecruitDAO recruitDAO;
	@Autowired
	private RecruitService recruitService;
	@Autowired
	private GroupDAO groupDAO;
	@Autowired
	private GroupService groupService;
	
	/**
	 * 마이 페이지에서 스터디 그룹 클릭 시, 해당 스터디 그룹 메인화면으로 이동
	 * @author 송용준, 김유란(session에 그룹멤버 정보 담기 추가)
	 * @param sgNo 이동할 스터디 그룹의 번호
	 * @param request 세션정보 획득을 위한 매개변수
	 * @return 스터디 그룹의 메인 뷰
	 */
	@RequestMapping("/groupHome")
	public String home(String sgNo, HttpServletRequest request) {
		//1. 스터디 그룹 정보(이름, 모집글 번호, 모집글 상태)
		GroupVO groupVO=groupService.findStudyGroupInfoByStudyGroupNo(sgNo);
		System.out.println(groupVO);
		//2. 회원 이름 : Session
		HttpSession session=request.getSession(false);
		MemberVO mv=(MemberVO)session.getAttribute("memberVO");
		String memberName=mv.getName();
		//3. 회원 이메일 : Session
		String memberEmail=mv.getMemberEmail();
		//4. 회원 직책
		String position=groupService.findMemberPositionByMemberEmailAndStudyGroupNo(sgNo,memberEmail);
		
		MemberVO memberVO = new MemberVO();
		memberVO.setMemberEmail(memberEmail);
		memberVO.setName(memberName);
	
		GroupMemberVO groupMemberVO = new GroupMemberVO();
		groupMemberVO.setGroupVO(groupVO);
		groupMemberVO.setMemberVO(memberVO);
		groupMemberVO.setPosition(position);
		session.setAttribute("groupMemberVO", groupMemberVO);
		return"groupHome.tiles";
	}
	
	@RequestMapping("/leaveStudyGroup")
	public String leaveStudyGroup(HttpServletRequest request, String sgNo) {
		
		HttpSession session=request.getSession(false);
		MemberVO mv=(MemberVO)session.getAttribute("memberVO");
		String memberEmail=mv.getMemberEmail();
		
		//1. 해당 스터디 그룹의 팀장이고 팀원이 있다면 팀장 위임
		if(groupService.countMyLeadGroupHasMemberByEmailAndStudyGroupNo(memberEmail, sgNo)==1) {
			// 팀원이 있다면 위임해야 함
			
			return "";
		}
		
		//2. 해당 스터디 그룹의 본인 직책을 탈퇴로 변경
		//groupService.deleteStudyMember(memberEmail,sgNo);
		
		return "redirect:/member/getMyPage?nowPage";
	}
	

	/**
	 * 스터디 그룹 팀원관리 메뉴로 이동하는 메서드
	 * @author 김유란
	 * @param groupNo 그룹 식별 번호
	 * @param model 해당 그룹에 속한 멤버와 신청자 정보를 전송하기 위해 호출
	 * @return group/find_group_member.tiles 스터디 그룹 팀원관리 페이지
	 */
	@RequestMapping("/findGroupMemberView")
	public String findGroupMemberView(String groupNo, Model model) {
		model.addAttribute("groupMemberList", groupService.findGroupMemberByGroupNo(groupNo, null));
		model.addAttribute("conditionList", recruitService.findStudyConditionByGroupNo(groupNo, null));
		return "group/find_group_member.sgtiles";
	}
	
	/**
	 * 마이페이지->스터디 그룹 즐겨찾기 편집
	 * @author 김유란
	 * @param memberEmail 회원 이메일
	 * @param checkBookmark 회원이 즐겨찾기 선택한 그룹의 멤버 번호를 담은 String배열
	 * @return redirect:/member/getMyPage?nowPage 상태 업데이트 후 마이페이지로 되돌아가기 
	 */
	@RequestMapping("/updateGroupMemberState")
	public String updateGroupMemberState(String memberEmail, String[] checkBookmark) {
		groupService.updateGroupMemberState(memberEmail, checkBookmark);
		return "redirect:/member/getMyPage?nowPage";
	}
	
	/**
	 * 스터디 그룹 팀원 직책 변경(팀장<->팀원)
	 * @author 김유란
	 * @param groupMemberNo 팀장직을 위임받을 멤버의 번호
	 * @param groupOwnerNo 현재 팀장의 그룹 멤버 번호
	 */
	@RequestMapping(value="/updateGroupMemberPosition", method=RequestMethod.POST)
	public String updateGroupMemberPosition(String groupMemberNo, String groupOwnerNo) {
		groupService.updateGroupMemberPosition(groupMemberNo, groupOwnerNo);
		return "redirect:/group/updateGroupMemberPositionOKView";
	}
	
	@RequestMapping("/updateGroupMemberPositionOKView")
	public String updateGroupMemberPositionOKView() {
		return "/group/update_position_ok";
	}
	

}
