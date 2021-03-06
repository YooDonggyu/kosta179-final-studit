package org.kosta.studit.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.studit.exception.EmailNotFoundException;
import org.kosta.studit.exception.IsNotMemberException;
import org.kosta.studit.exception.PasswordIncorrectException;
import org.kosta.studit.model.dao.GroupDAO;
import org.kosta.studit.model.dao.MemberDAO;
import org.kosta.studit.model.service.CompanyService;
import org.kosta.studit.model.service.MemberService;
import org.kosta.studit.model.service.RecruitService;
import org.kosta.studit.model.service.StudyRoomService;
import org.kosta.studit.model.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private MemberService memberService;
	@Autowired
	private RecruitService recruitService;
	@Autowired
	private StudyRoomService studyroomService;
	@Autowired
	private GroupDAO groupDAO;
	@Autowired
	private CompanyService companyService;

	/**
	 * 사용자 로그인을 위한 메서드. 가장 먼저 아이디 확인한 후 비밀번호 일치여부를 확인한다.
	 * 
	 * @author 유동규
	 * @param loginEmail  로그인할 이메일
	 * @param loginPassword  로그인할 비밀번호
	 * @param request 세션을 담기위해 HttpServletRequest 사용
	 * @exception EmailNotFoundException 아이디가 없을 때 발생하는 예외
	 * @exception PasswordIncorrectException 비밀번호가 틀릴 때 발생하는 예외
	 * @exception IsNotMemberException  회원 탈퇴상태일 때 발생하는 예외
	 * @return redirect:/ 로그인 한 후 메인페이지로 이동
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(String loginEmail, String loginPassword, String rememberEmail, HttpServletRequest request, HttpServletResponse response, Model model) {
		MemberVO rMemberVO = null;
		try {
			rMemberVO = memberService.login(new MemberVO(loginEmail, loginPassword));
			if (rMemberVO == null) {
				// Null일 경우는 Error = 404? 405? 500?
			} else {
				int isAdmin = memberDAO.isAdmin(rMemberVO.getMemberEmail());
				if(isAdmin >0) {
					rMemberVO.setAdmin(true);
				}else {
					rMemberVO.setAdmin(false);
				}
				// 세션할당
				request.getSession().setAttribute("memberVO", rMemberVO); 
				// 모집 조회수 증가 판단을 위한 session
				request.getSession().setAttribute("rHitList", new ArrayList<>());
				// 업체 조회수 증가 판단을 위한 session
				request.getSession().setAttribute("cHitList", new ArrayList<>());
				// 그룹 조회수 증가 판단을 위한 session
				request.getSession().setAttribute("gHitList", new ArrayList<>());
				// 아이디 저장 확인(cookie)
				if(rememberEmail != null) {
					Cookie cookie = new Cookie("remember", loginEmail);
					cookie.setMaxAge(7*24*60*60);
					cookie.setPath("/");
					response.addCookie(cookie);
				}else {
					Cookie[] cookies = request.getCookies();
					for(int i =0; i<cookies.length; i++) {
						if(cookies[i].getName().equals("remember")) {
							cookies[i].setMaxAge(0);
							cookies[i].setPath("/");
							response.addCookie(cookies[i]);
						}
					}
				}
			}
		} catch (EmailNotFoundException | PasswordIncorrectException | IsNotMemberException e) {
			model.addAttribute("msg", e.getMessage());
			return "member/login_fail";
		}
		return "redirect:/";
	}

	/**
	 * 로그아웃을 위한 메서드. HttpServletRequest를 통해 세션을 무효화 시켜 로그아웃 처리를 한다.
	 * @author 유동규
	 * @param request 세션을 호출하기 위한 요청
	 * @return redirect:/ 로그아웃한 후 메인페이지로 이동
	 */
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:/";
	}

	/**
	 * 회원 가입 시 입력된 데이터를 DB에 insert하는 메서드
	 * 
	 * @author 변태섭
	 * @param memberVO 회원가입 사용자가 입력한 Data
	 * @param picFile  프로필 사진 경로
	 */
	@RequestMapping(value = "/registerMember", method = RequestMethod.POST)
	public String registerMember(MemberVO memberVO, MultipartFile picFile) {
		if (picFile != null && !picFile.isEmpty()) {
			String fileName = memberVO.getMemberEmail() + "_" + picFile.getOriginalFilename();
			// request.getSession(false).getServletContext().getRealPath("upload"); 개발 완료 후 적용

			String path ="C:/resources/upload/";
			try {
				picFile.transferTo(new File(path, fileName));// 지정 경로에 실제 파일 저장
				memberVO.setPicPath(fileName);
			} catch (IllegalStateException | IOException e) {
				return "member/update_pic_fail";
			}
		} else {// 파일을 첨부하지 않았을 때
			memberVO.setPicPath("default.png");
		}
		
		memberService.registerMember(memberVO);
		return "redirect:/register_member_ok";
	}

	/**
	 * 비밀번호 재확인을 위한 메서드 회원정보를 수정하기전 사용자 재인증을 위한 비밀번호 확인.
	 * 
	 * @author 김유란,이승수
	 * @param loginPassword 재입력한 비밀번호
	 * @param request  세션을 호출
	 * @return String
	 */
	@RequestMapping(value = "/checkMember", method = RequestMethod.POST)
	public String checkMember(String checkPassword, HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession(false).getAttribute("memberVO");
		memberVO.setPassword(checkPassword);
		try {
			memberService.login(memberVO);
		} catch (EmailNotFoundException | PasswordIncorrectException | IsNotMemberException e) {
			request.setAttribute("msg", e.getMessage());
			return "member/login_fail";
		}
		return "redirect:/member/updateMemberView";
	}

	/**
	 * update_member.jsp로 가기위한 메소드 update_member.jsp로 가기전에 request.set으로 정보를 저장하고
	 * 이동.
	 * 
	 * @author 김유란,이승수
	 * @return String
	 * @param request 세션을 호출
	 */
	@RequestMapping("/updateMemberView")
	public String updateMemberView(HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession(false).getAttribute("memberVO");
		MemberVO rMemberVO = memberDAO.findMemberByEmail(memberVO.getMemberEmail());
		request.setAttribute("rMemberVO", rMemberVO);
		return "member/update_member.tiles";
	}

	/**
	 * 
	 * 회원정보 수정 메서드 사용자가 수정한 정보를 전달받아 DB에 update한다.
	 * 
	 * @author 김유란, 이승수
	 * @param memberVO 수정된 회원정보를 담은 VO
	 * @param multipartFile 사용자가 업로드한 파일 정보를 담은 객체타입
	 * @param HttpServletRequest  세션 및 프로젝트 절대경로를 얻기 위해 호출
	 * @return 회원정보 수정 결과 페이지로 이동
	 * @exception IllegalStateException
	 * @exception IOException
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/updateMember")
	public String updateMember(MemberVO memberVO, MultipartFile picFile, HttpServletRequest request) {
		MemberVO pMemberVO = (MemberVO) request.getSession(false).getAttribute("memberVO");
		System.out.println(memberVO.getPicPath());
		if (picFile != null && !picFile.isEmpty()) {
			String fileName = memberVO.getMemberEmail() + "_" + picFile.getOriginalFilename();
			// String path =
			// request.getSession(false).getServletContext().getRealPath("upload"); 개발 완료 후 적용
			String path ="C:/resources/upload/";
			try {
				picFile.transferTo(new File(path, fileName));// 지정 경로에 실제 파일 저장
				memberVO.setPicPath(fileName);
			} catch (IllegalStateException | IOException e) {
				return "member/update_pic_fail.tiles";
			}
		} else if (picFile.isEmpty() && pMemberVO.getPicPath() != null) {
			if(memberVO.getPicPath().equals("default.png")) {
				
			}else {
				memberVO.setPicPath(pMemberVO.getPicPath());
			}
		} else {// 파일을 첨부하지 않았을 때
			memberVO.setPicPath("default.png");
		}
		MemberVO rMemberVO = memberService.updateMember(memberVO);
		request.getSession(false).setAttribute("memberVO", rMemberVO);
		return "member/update_member_ok.tiles";
	}

	/**
	 * 비밀번호 변경 화면으로 이동하는 메서드
	 * @author 김유란
	 * @return member/update_password.tiles
	 */
	@RequestMapping("/updatePasswordView")
	public String updatePasswordView() {
		return "member/update_password.tiles";
	}

	/**
	 * 
	 * 비밀번호 변경 브라우저에서 입력받은 비밀번호를 DB에 반영하기 위한 메서드
	 * 
	 * @author 김유란
	 * @param newPassword 사용자가 입력한 새로운 비밀번호
	 * @param checkEmail 접속중인 사용자의 식별 정보
	 * @return member/update_password_ok 변경 결과를 보여주는 페이지
	 * 
	 */
	@RequestMapping("/updatePassword")
	public String updatePassword(String newPassword, String checkEmail) {
		memberDAO.updatePassword(new MemberVO(checkEmail, newPassword));
		return "member/update_password_ok";
	}

	/**
	 * 스터디 현황 조회, 스터디 룸 현황 조회를 위한 페이징+진행중인 스터디 정보 
	 * 해당 사용자에 따른 전체 수를 구한 뒤 페이징처리를 한다.
	 * @author 변태섭, 유동규, 김유란
	 * @param HttpServletRequest Session에 있는 memberEmail을 사용한다.
	 * @param Model 받아온 list 객체를 담아 전달한다.
	 * @param String 페이지 번호
	 * @return mypage
	 */
	@RequestMapping("/getMyPage")
	public String getMyPage(HttpServletRequest request, Model model) {
		HttpSession session=request.getSession(false);
		MemberVO mvo=(MemberVO) session.getAttribute("memberVO");
		int nowPage =0;
		if(request.getParameter("nowPage") != null && request.getParameter("nowPage") != "") {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		//스터디 현황조회
		model.addAttribute("studyConditionList", recruitService.findStudyConditionByMemberEmail(mvo.getMemberEmail(), nowPage));
		//스터디 룸 현황조회
		model.addAttribute("srcListVO", studyroomService.findStudyRoomConditionListVOByEmail(mvo.getMemberEmail(), nowPage));
		//진행중인 스터디 조회
		model.addAttribute("groupList", groupDAO.findStudyGroupByMemberEmail(mvo.getMemberEmail()));
		return "member/mypage.tiles";
	}

	/**
	 * 
	 * 접속중인 회원의 회원탈퇴 가능 여부를 확인하고 그 결과값을 표시하는 페이지로 이동
	 * 
	 * @author 송용준
	 * @param request 접속중인 회원의 이메일을 확인하기 위한 매개변수
	 * @return 회원탈퇴 조건을 확인하는 페이지
	 */
	@RequestMapping("/deleteMemberView")
	public String deleteMemberView(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
		HashMap<String, Object> map = memberService.deleteMemberView(memberVO.getMemberEmail());
		request.setAttribute("deleteMemberInfo", map);
		return "member/delete_member.tiles";
	}

	/**
	 * 
	 * 회원탈퇴를 위한 메서드 : 회원의 직책을 회원에서 탈퇴로 변경
	 * @author 송용준
	 * @param memberEmail 탈퇴하고자하는 회원의 이메일
	 * @return 탈퇴가 완료되면 홈으로 보낸다
	 */
	@RequestMapping("/deleteMember")
	public String deleteMember(String memberEmail) {
		memberService.deleteMember(memberEmail);

		return "redirect:/member/logout";
	}
	
	/**
	 * 
	 * 비밀번호 확인을 위해 이메일을 입력받는 뷰
	 * @author 송용준
	 * @return 이메일을 입력을 위한 뷰
	 */
	@RequestMapping("/findPasswordView")
	public String findPasswordView() {

		return "member/find_password_view.tiles";
	}
	
	/**
	 * 
	 * 비밀번호 힌트와 답변을 확인
	 * @author 송용준
	 * @return 비밀번호 힌트와 답변을 비교하는 뷰
	 */
	@RequestMapping("/checkPasswordHintAndAnswer")
	public String checkPasswordHintAndAnswer(String memberEmail, Model model) {
		if(memberDAO.isMember(memberEmail)) {
			Map<String, String> map=memberService.checkPasswordHintAndAnswer(memberEmail);
			model.addAttribute("checkInfo", map);
			
			return "member/check_passwordhint_answer.tiles";
		}else {
			return "member/find_password_fail.tiles";
		}
	}
	
	
	/**
	 * 
	 * 비밀번호 확인을 위해 이메일을 입력받는 뷰
	 * @author 송용준
	 * @return 이메일을 입력을 위한 뷰
	 */
	@RequestMapping("/findPassword")
	public String findPassword(String memberEmail, HttpServletRequest request) {
		Map<String, String> map=new HashMap<>();
		String newPassword = "";
		for (int i = 0; i < 8; i++) {
			char lowerStr = (char) (Math.random() * 26 + 97);
			if (i % 2 == 0) {
				newPassword += (int) (Math.random() * 10);
			} else {
				newPassword += lowerStr;
			}
		}
		map.put("memberEmail", memberEmail);
		map.put("newPassword", newPassword);
		memberDAO.updatePasswordForFindPassword(map);
		request.setAttribute("memberInfo", map);
		return "member/create_newpassword.tiles";
	}
	
	

	/**
	 * 관리자용 - 업체, 회원 목록
	 * @author 유동규
	 */
	@RequestMapping("/getCompanyAndMemberInfo")
	public String getCompanyListForAdmin(HttpServletRequest request, Model model) {
		int nowPage = 1;
		if(request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		model.addAttribute("comListVO", companyService.getCompanyListForAdmin(nowPage, null));
		model.addAttribute("memberListVO", memberService.getMemberListForAdmin(nowPage, null));
		return "member/admin.tiles";
	}
	
	
	@RequestMapping(value="/updateMemberState", method = RequestMethod.POST)
	public String updateMemberState(String memberEmail) {
		memberDAO.updateMemberState(memberEmail);
		return "redirect:updateMemberStateView";
	}
	@RequestMapping(value="/deleteMemberState", method = RequestMethod.POST)
	public String deleteMemberState(String memberEmail) {
		memberDAO.deleteMemberState(memberEmail);
		return "redirect:updateMemberStateView";
	}
	
	@RequestMapping(value="/updateMemberStateView")
	public String updateMemberStateView() {
		return "member/update_memberstate_result";
	}
	
	
	
	
	
	
}
