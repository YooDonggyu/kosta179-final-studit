package org.kosta.studit.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.kosta.studit.model.service.GroupService;
import org.kosta.studit.model.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/group")
public class GroupController {
	
	@Autowired
	private GroupService groupService;
	
	@RequestMapping("groupHome")
	public String home(String sgNo, HttpServletRequest request) {
		//1. 스터디그룹 이름
		String groupName=groupService.findStudyGroupNameByStudyGroupNo(sgNo);
		//2. 회원 이름 : Session
		HttpSession session=request.getSession(false);
		MemberVO mv=(MemberVO)session.getAttribute("memberVO");
		String memberName=mv.getName();
		//3. 회원 이메일 : Session
		String memberEmail=mv.getMemberEmail();
		//3. 오늘 할 일
		Map<String, String> map=groupService.findScheduleByStudyGroupNo(sgNo);
		//4. 회원 직책
		String position=groupService.findMemberPositionByMemberEmailAndStudyGroupNo(sgNo,memberEmail);
		
		return"groupHome.tiles";
	}
	
	@RequestMapping("findSideBarView")
	public String findSideBarView() {
		return "group/sidebar";
	}
}
