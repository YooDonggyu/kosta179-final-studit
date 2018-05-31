package org.kosta.studit.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.kosta.studit.model.dao.GroupDAO;
import org.kosta.studit.model.dao.RecruitDAO;
import org.kosta.studit.model.service.GroupService;
import org.kosta.studit.model.service.RecruitService;
import org.kosta.studit.model.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
	 * @author 송용준
	 * @param sgNo 이동할 스터디 그룹의 번호
	 * @param request 세션정보 획득을 위한 매개변수
	 * @return 스터디 그룹의 메인 뷰
	 */
	@RequestMapping("groupHome")
	public String home(String sgNo, HttpServletRequest request) {
		//1. 스터디 그룹 이름
		String groupName=groupService.findStudyGroupNameByStudyGroupNo(sgNo);
		
		//2. 회원 이름 : Session
		HttpSession session=request.getSession(false);
		MemberVO mv=(MemberVO)session.getAttribute("memberVO");
		String memberName=mv.getName();
		
		//3. 회원 이메일 : Session
		String memberEmail=mv.getMemberEmail();
		
		//4. 회원 직책
		String position=groupService.findMemberPositionByMemberEmailAndStudyGroupNo(sgNo,memberEmail);
		
		request.setAttribute("sgNo", sgNo);
		request.setAttribute("groupName", groupName);
		request.setAttribute("memberName", memberName);
		request.setAttribute("memberEmail", memberEmail);
		request.setAttribute("position", position);
		
		return"groupHome.tiles";
	}
	
	@RequestMapping("leaveStudyGroup")
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
	

	@RequestMapping("/findGroupMemberView")
	public String findGroupMemberView(String groupNo, Model model) {
		model.addAttribute("groupMemberList", groupService.findGroupMemberByGroupNo(groupNo, null));
		model.addAttribute("conditionList", recruitService.findStudyConditionByGroupNo(groupNo, null));
		return "group/find_group_member.tiles";
	}


}
