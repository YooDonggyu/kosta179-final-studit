package org.kosta.studit.controller;


import org.kosta.studit.model.dao.MemberDAO;
import javax.servlet.http.HttpServletRequest;

import org.kosta.studit.exception.EmailNotFoundException;
import org.kosta.studit.exception.PasswordIncorrectException;
import org.kosta.studit.model.service.MemberService;

import org.kosta.studit.model.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/ajax")
public class AjaxViewController {

	@Autowired
	   private MemberDAO memberDAO;
	@Autowired
		private MemberService memberService;
	   
	   /**
	    *  아아디 중복확인을 위한 메서드.
	    *  사용자가 입력한 Email을 실시간으로 중복확인 한다.
	    * @author 송용준,변태섭
	    * @param 사용자가 입력한 Email
	    * @return 중복인 경우 false, 중복이 아닌 경우 true
	    */
	   @RequestMapping("/findCheckByEmail")
	   @ResponseBody
	   public boolean findCheckByEmail(String memberEmail) {
	      if(memberDAO.findMemberByEmail(memberEmail)==null) {
	    	  return true;
	      }else{
	    	  return false;
	      }
	   }


	/**
	 * 
	    * 비밀번호 검증 메서드
	    * 사용자가 입력한 현재 비밀번호를 
	    * 
	    * @author 김유란
	    * @param HttpServletRequest 파라미터를 받아오기 위해 호출
	    * @exception EmailNotFoundException 아이디가 없을 때 발생하는 예외
	    * @exception PasswordIncorrectException 비밀번호가 틀릴 때 발생하는 예외
	    * @return boolean 파라미터로 받아온 비밀번호 입력값의 DB 일치 여부에 따라 true/false 반환
	 */
	@RequestMapping(method=RequestMethod.POST, value="/checkPasswordAjax")
	@ResponseBody
	public boolean checkPassword(HttpServletRequest request) {
		String memberEmail = request.getParameter("memberEmail");
		String password = request.getParameter("nowPassword");
		try {
			memberService.login(new MemberVO(memberEmail, password));
		} catch (EmailNotFoundException | PasswordIncorrectException e) {
			return false;
		}
		return true;
	}

}
