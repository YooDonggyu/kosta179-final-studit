package org.kosta.studit.controller;

import org.kosta.studit.model.dao.MemberDAO;
import org.kosta.studit.model.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
@RequestMapping("/ajax")
@Controller
public class AjaxViewController {
	@Autowired
	   private MemberDAO memberDAO;
	   
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
}
