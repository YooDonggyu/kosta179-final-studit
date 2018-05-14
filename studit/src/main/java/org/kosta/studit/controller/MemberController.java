package org.kosta.studit.controller;

import javax.servlet.http.HttpServletRequest;

import org.kosta.studit.exception.EmailNotFoundException;
import org.kosta.studit.exception.PasswordIncorrectException;
import org.kosta.studit.model.service.MemberService;
import org.kosta.studit.model.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	/**
	 * 사용자 로그인을 위한 메서드.
	 * 가장 먼저 아이디 확인한 후 비밀번호 일치여부를 확인한다.
	 * @author 유동규
	 * @param memberVO 로그인할 정보가 담겨있는 객체
	 * @param request 세션을 담기위해 HttpServletRequest 사용
	 * @exception EmailNotFoundException 아이디가 없을 때 발생하는 예외
	 * @exception PasswordIncorrectException 비밀번호가 틀릴 때 발생하는 예외
	 * @return home.tiles 로그인 한 후 메인페이지로 이동
	 */
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(MemberVO memberVO, HttpServletRequest request) {
		MemberVO rMemberVO;
		try {
			rMemberVO = memberService.login(memberVO);
			if(rMemberVO == null) {
				//Null일 경우는 Error = 405
			}else {
				//세션할당
				request.getSession().setAttribute("memberVO", rMemberVO);
			}
		} catch (EmailNotFoundException  mailException) {
			return "member/login_not_found";
		}catch(PasswordIncorrectException passwordException) {
			return "member/login_password_incorrect";
		}
		return "redirect:/";
	}
	 
	/**
	 *  로그아웃을 위한 메서드.
	 *  HttpServletRequest를 통해 세션을 무효화 시켜 로그아웃 처리를 한다.
	 * @author 유동규
	 * @param request 세션을 호출하기 위한 요청
	 * @return home.tiles 로그아웃한 후 메인페이지로 이동
	 */
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:/";
	}
}
