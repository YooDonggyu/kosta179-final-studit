package org.kosta.studit.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.kosta.studit.model.dao.GroupDAO;
import org.kosta.studit.model.dao.RecruitDAO;
import org.kosta.studit.model.service.GroupService;
import org.kosta.studit.model.service.RecruitService;
import org.kosta.studit.model.vo.GroupMemberVO;
import org.kosta.studit.model.vo.GroupPostCommentVO;
import org.kosta.studit.model.vo.GroupPostListVO;
import org.kosta.studit.model.vo.GroupPostVO;
import org.kosta.studit.model.vo.GroupVO;
import org.kosta.studit.model.vo.MemberVO;
import org.kosta.studit.model.vo.RecruitPostVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/group")
public class GroupController {
	@Autowired
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
	
	/**
	 * 스터디 그룹의 게시판으로 이동
	 * @author 송용준
	 * @param sgNo 해당 게시판이 속한 스터디 그룹의 번호
	 * @param nowPage 현재 페이지
	 * @return 스터디 그룹의 게시판
	 */
	@RequestMapping("findGroupBoard")
	public String findGroupBoard(HttpServletRequest request, String nowPage) {
		Map<String, Object> map=new HashMap<>();
		HttpSession session=request.getSession(false);
		GroupMemberVO gvo=(GroupMemberVO)session.getAttribute("groupMemberVO");
		map.put("nowPage", nowPage);
		map.put("sgNo", gvo.getGroupVO().getGroupNo());
		GroupPostListVO glist=groupService.findGroupBoard(map);
		request.setAttribute("nowPage", glist.getPb().getNowPage());
		request.setAttribute("glist", glist);
		
		return "group/list_group_post.sgtiles";
	}
	
	/**
	 * 스터디 그룹을 탈퇴하고자 할 때 호출 : 직책을 탈퇴로 변경
	 * @author 송용준
	 * @param sgNo 탈퇴할 스터디 그룹의 번호
	 * @return 마이 페이지로 이동
	 */
	@RequestMapping("leaveStudyGroup")
	public String leaveStudyGroup(HttpServletRequest request) {
		
		HttpSession session=request.getSession(false);
		MemberVO mv=(MemberVO)session.getAttribute("memberVO");
		GroupMemberVO gvo=(GroupMemberVO)session.getAttribute("groupMemberVO");
		String memberEmail=mv.getMemberEmail();
		
		//1. 해당 스터디 그룹의 본인 직책을 탈퇴로 변경
		groupService.deleteStudyMember(memberEmail,Integer.toString(gvo.getGroupVO().getGroupNo()));
		
		return "redirect:/member/getMyPage";
	}
	

	/**
	 * 스터디 그룹 팀원관리 메뉴로 이동하는 메서드
	 * @author 김유란
	 * @param groupNo 그룹 식별 번호
	 * @param model 해당 그룹에 속한 멤버와 신청자 정보를 전송하기 위해 호출
	 * @return group/find_group_member.tiles 스터디 그룹 팀원관리 페이지
	 */
	@RequestMapping("/findGroupMemberView")	
	public String findGroupMemberView(HttpServletRequest request) {
		GroupMemberVO gvo= (GroupMemberVO) request.getSession(false).getAttribute("groupMemberVO");
		String groupNo = Integer.toString(gvo.getGroupVO().getGroupNo());
		request.setAttribute("recruitInfo", 
				recruitService.findRecruitPostDetailByRecruitNo(null, gvo.getGroupVO().getRecruitPostVO().getRecruitPostNo()));
		request.setAttribute("groupMemberList", groupService.findGroupMemberByGroupNo(groupNo, null));
		request.setAttribute("conditionList", recruitService.findStudyConditionByGroupNo(groupNo, null));
		return "group/find_group_member.sgtiles";
	}
	
	/*@RequestMapping("findGroupMemberView")
	public String findGroupMemberView(String groupNo, Model model) {
		model.addAttribute("groupMemberList", groupService.findGroupMemberByGroupNo(groupNo, null));
		model.addAttribute("conditionList", recruitService.findStudyConditionByGroupNo(groupNo, null));
		return "group/find_group_member.tiles";
	}*/

	
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
	
	/**
	 * 스터디 그룹 팀원 직책 변경 후 결과 알림 보여주기
	 * @author 김유란
	 * @param /group/update_position_ok 결과 알림 뷰
	 */
	@RequestMapping("/updateGroupMemberPositionOKView")
	public String updateGroupMemberPositionOKView() {
		return "/group/update_position_ok";
	}
	
	@RequestMapping("/updateRecruitPostInfoToAddByRecruitNoView")
	public String updateRecruitPostInfoToAddByRecruitNoView(String recruitPostNo, Model model) {
		Map<String, Object> map = recruitService.findRecruitPostDetailByRecruitNo(null, Integer.parseInt(recruitPostNo));
		model.addAttribute("recruitInfo", map);
		System.out.println(recruitDAO.getBigCategoryList());
		model.addAttribute("bigCategoryList", recruitDAO.getBigCategoryList());
		RecruitPostVO recruitPostVO = (RecruitPostVO)map.get("detail");
		int bigCategoryNo = recruitPostVO.getSmallCategoryVO().getBigCategoryVO().getBigCategoryNo();
		model.addAttribute("smallCategoryList", recruitDAO.findSmallCategoryListByBigCategoryNo(Integer.toString(bigCategoryNo)));
		return "group/create_additional_recruit.sgtiles";
	}
	/**
	 * 스터디 그룹 커뮤니티에서 나가고자 할 때 호출
	 * @author 송용준
	 * @return 마이 페이지로 이동
	 */
	@RequestMapping("exitStudyGroup")
	public String exitStudyGroup(HttpServletRequest request) {
		HttpSession session=request.getSession();
		session.removeAttribute("groupMemberVO");
		
		return "redirect:/member/getMyPage";
	}
	
	/**
	 * 특정 스터디 그룹 게시판의 글을 상세보기 할 때 호출
	 * @author 송용준
	 * @param gpNo 그룹 포스트 번호
	 * @param 목록으로 돌아갈 때 필요한 현재 페이지
	 * @return 상세보기 화면으로 이동
	 */
	@RequestMapping("findDetailGroupPostByPostNo")
	public String findDetailGroupPostByPostNo(HttpServletRequest request, String gpNo, String nowPage) {
		// 1.세션 이메일과 게시글 작성자를 비교해서 작성자이면 조회수 증가 방지
		// 2.hitList에 포함된 게시글은 조회수 증가 방지
		String sessionEmail = ((MemberVO) request.getSession().getAttribute("memberVO")).getMemberEmail();
		String postEmail = groupDAO.findGroupPostWriterByGroupPostNo(gpNo);
		ArrayList<Integer> gHitList = (ArrayList<Integer>) request.getSession().getAttribute("gHitList");
		if (!gHitList.contains(Integer.parseInt(gpNo)) && !sessionEmail.equals(postEmail)) {
			groupDAO.updateGroupPostHitByGroupPostNo(gpNo);
			gHitList.add(Integer.parseInt(gpNo));
		}
		
		//1.게시글의 상세내용을 GroupPostVO에 담는다.
		GroupPostVO glist=groupService.findGroupBoardDetail(gpNo);
		
		//2.게시글의 댓글들을 GroupPostCommentVO에 담는다.
		List<GroupPostCommentVO> commentVO=groupDAO.findGroupPostCommentByGroupPostNo(gpNo);
		
		request.setAttribute("glist", glist);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("gpNo", gpNo);
		request.setAttribute("comment", commentVO);
		
		return "group/detail_group_post.sgtiles";
	}
	
	/**
	 * 스터디 그룹 게시판에 내가 쓴 글을 수정하고자 할 때 호출
	 * @author 송용준
	 * @param gpNo 그룹 포스트 번호
	 * @param nowPage 목록으로 돌아갈 때 필요한 현재 페이지
	 * @return 스터디 그룹 게시글 수정 페이지로 이동
	 */
	@RequestMapping("updateGroupPostView")
	public String updateGroupPostView(HttpServletRequest request, String gpNo, String nowPage) {
		GroupPostVO glist=groupService.findGroupBoardDetail(gpNo);
		
		request.setAttribute("glist", glist);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("gpNo", gpNo);
		
		return "group/update_group_post.sgtiles";
	}
	
	/**
	 * 스터디 그룹 내 게시글을 수정
	 * @author 송용준
	 * @param GroupPostVO 수정할 게시글의 정보와 수정된 내용을 담은 객체
	 * @param nowPage 목록으로 돌아갈 때 필요한 현재 페이지
	 * @return 상세보기 화면으로 이동
	 */
	@RequestMapping("updateGroupPost")
	public String updateGroupPost(GroupPostVO gvo, String nowPage) {
		groupService.updateGroupPost(gvo);
		
		return "redirect:/group/findDetailGroupPostByPostNo?gpNo="+gvo.getGroupPostNo()+"&nowPage="+nowPage;
	}
	
	/**
	 * 스터디 그룹 내 게시글 작성 뷰로 이동
	 * @author 송용준
	 * @param nowPage 목록으로 돌아갈 때 필요한 현재 페이지
	 * @return 게시글 작성 화면으로 이동
	 */
	@RequestMapping("createGroupPostView")
	public String createGroupPostView(HttpServletRequest request, String nowPage) {
		request.setAttribute("nowPage", nowPage);
		return "group/create_group_post.sgtiles";
	}
	
	@RequestMapping("/createAdditionalRecruit")
	public String createAdditionalRecruit(RecruitPostVO recruitPostVO, String[] day, HttpServletRequest request){
		HttpSession session=request.getSession();
		recruitPostVO.setMemberVO((MemberVO)session.getAttribute("memberVO"));
		groupService.createAdditionalRecruit(recruitPostVO, day);
		if(session.getAttribute("groupMemberVO")!=null) {
			GroupMemberVO gvo = (GroupMemberVO)session.getAttribute("groupMemberVO");
			GroupVO groupVO = groupService.findStudyGroupInfoByStudyGroupNo(Integer.toString(gvo.getGroupVO().getGroupNo()));
			gvo.setGroupVO(groupVO);
			session.setAttribute("groupMemberVO", gvo);
		}
		return "redirect:/group/findGroupMemberView";
	}
	
	/**
	 * 스터디 그룹 내 게시글을 등록
	 * @author 송용준
	 * @param title, content 작성한 게시글 정보
	 * @return 상세보기 화면으로 이동
	 */
	@RequestMapping("createGroupPost")
	public String createGroupPost(HttpServletRequest request, String title, String content) {
		HttpSession session=request.getSession(false);
		MemberVO mvo=(MemberVO)session.getAttribute("memberVO");
		GroupMemberVO gvo=(GroupMemberVO)session.getAttribute("groupMemberVO");
		//작성자의 스터디 그룹맴버 번호
		int groupMemberNo=groupService.getGroupMemberNo(Integer.toString(gvo.getGroupVO().getGroupNo()), mvo.getMemberEmail());
		GroupMemberVO groupMemberVO=new GroupMemberVO(groupMemberNo);
		GroupPostVO cgvo=new GroupPostVO(title, content, groupMemberVO, gvo.getGroupVO());
		
		groupDAO.createGroupPost(cgvo);
		
		return "redirect:/group/findDetailGroupPostByPostNo?gpNo="+cgvo.getGroupPostNo()+"&nowPage=1";
	}
	
	/**
	 * 스터디 그룹 내 게시글 삭제
	 * @author 송용준
	 * @param gpNo 삭제할 게시글의 번호
	 * @return 삭제 완료 후, 게시판 첫 페이지로 이동
	 */
	@RequestMapping("deleteGroupPost")
	public String deleteGroupPost(String gpNo) {
		groupDAO.deleteGroupPost(gpNo);
		
		return "group/delete_post_ok.sgtiles";
	}
}



















