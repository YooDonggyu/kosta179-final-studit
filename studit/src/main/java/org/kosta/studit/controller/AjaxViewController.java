package org.kosta.studit.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.kosta.studit.exception.EmailNotFoundException;
import org.kosta.studit.exception.IsNotMemberException;
import org.kosta.studit.exception.PasswordIncorrectException;
import org.kosta.studit.model.PagingBean;
import org.kosta.studit.model.dao.MemberDAO;
import org.kosta.studit.model.dao.RecruitDAO;
import org.kosta.studit.model.dao.StudyRoomDAO;
import org.kosta.studit.model.service.MemberService;
import org.kosta.studit.model.vo.MemberVO;
import org.kosta.studit.model.vo.SmallCategoryVO;
import org.kosta.studit.model.vo.StudyRoomConditionListVO;
import org.kosta.studit.model.vo.StudyRoomConditionVO;
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
	@Autowired
		private RecruitDAO recruitDAO;
	@Autowired
	private StudyRoomDAO studyroomDAO;
	
	   
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
	    * 사용자가 입력한 현재 비밀번호를 DB에 저장된 정보와 비교하여 검증하여 결과값을 반환
	    * 
	    * @author 김유란
	    * @param HttpServletRequest 파라미터를 받아오기 위해 호출
	    * @exception EmailNotFoundException 아이디가 없을 때 발생하는 예외
	    * @exception PasswordIncorrectException 비밀번호가 틀릴 때 발생하는 예외
	    * @return boolean 파라미터로 받아온 비밀번호 입력값의 DB 일치 여부에 따라 true/false 반환
	 */
	@RequestMapping(method=RequestMethod.POST, value="/checkPassword")
	@ResponseBody
	public boolean checkPassword(HttpServletRequest request) {
		String memberEmail = request.getParameter("memberEmail");
		String password = request.getParameter("nowPassword");
		try {
			memberService.login(new MemberVO(memberEmail, password));
		} catch (EmailNotFoundException | PasswordIncorrectException | IsNotMemberException e) {
			return false;
		}
		return true;
	}
	
	/**
	 * 
	    * 소분류 목록을 불러오는 메서드
	    * 사용자가 선택한 대분류 번호를 전달받아 소분류 목록을 즉시 로드하기 위해  
	    * @author 김유란
	    * @param bigCategoryNo 사용자가 선택한 대분류 번호
	    * @return List<SmallCategoryVO> 소분류 번호와 이름 정보를 담은 VO 리스트 
	 */
	@RequestMapping(method=RequestMethod.POST, value="/getSmallCategoryList")
	@ResponseBody
	public List<SmallCategoryVO> getSmallCategoryList(String bigCategoryNo){
		return recruitDAO.findSmallCategoryListByBigCategoryNo(bigCategoryNo);
	}
	
	/**
	 * 모집게시글에 따른 댓글 등록
	 * @author 유동규
	 * @param recruitNo 댓글을 가지고 있는 모집 게시글 번호
	 * @param comment 입력할 댓글
	 * @return true 정상 작동하면 true
	 */
	@RequestMapping(value="/registerComment", method=RequestMethod.POST)
	@ResponseBody
	public String registerComment(int recruitNo, String comment, HttpServletRequest request) {
		String userName = ((MemberVO)request.getSession().getAttribute("memberVO")).getName();
		Map<String, Object> commentMap = new HashMap<>();
		commentMap.put("comment", comment);
		commentMap.put("name", userName);
		commentMap.put("recruitNo", recruitNo);
		recruitDAO.registerCommentByRecruitNo(commentMap);
		return "true";
	}
	
	/**
	 * 스터디 룸 현황 조회를 위한 페이징.
	 * 해당 사용자에 따른 전체 수를 구한 뒤 페이징처리를 한다.
	 * @author 유동규
	 * @param nowPage 현재 페이지
	 * @return StudyRoomConditionListVO 페이징한 결과(list)와 페이징 객체가 담겨있는 객체
	 */
	@RequestMapping("/findStudyRoomConditionByNowPage")
	@ResponseBody
	public StudyRoomConditionListVO findStudyRoomConditionByNowPage(int nowPage, HttpServletRequest request){
		//1. 총 게시물로 pagingbean 만들기
		int myTotalPage = studyroomDAO.findTotalStudyRoomConditionByEmail(((MemberVO)request.getSession().getAttribute("memberVO")).getMemberEmail());
		PagingBean pb= new PagingBean(myTotalPage, nowPage);
		/*pb.setMyTotalPostCount(myTotalPage);*/
		//2. 조건문을 위해 이메일과 pb로 Map을 만들어 전달
		Map<String, Object> map = new HashMap<>();
		map.put("pagingBean", pb);
		map.put("memberEmail", ((MemberVO)request.getSession().getAttribute("memberVO")).getMemberEmail());
		//3. Map으로 paging처리된 결과 List로 받아오기
		List<StudyRoomConditionVO>list =  studyroomDAO.findStudyConditionByEmail(map);
		//4. paging된 list와 pb객체를 StudyRoomConditionListVO에 담아 전달
		StudyRoomConditionListVO srcListVO = new StudyRoomConditionListVO();
		srcListVO.setList(list);
		srcListVO.setPagingBean(pb);
		return srcListVO;
	}

}
