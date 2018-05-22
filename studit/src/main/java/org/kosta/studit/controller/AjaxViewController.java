package org.kosta.studit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.kosta.studit.exception.EmailNotFoundException;
import org.kosta.studit.exception.IsNotMemberException;
import org.kosta.studit.exception.PasswordIncorrectException;
import org.kosta.studit.model.dao.CompanyDAO;
import org.kosta.studit.model.dao.MemberDAO;
import org.kosta.studit.model.dao.RecruitDAO;
import org.kosta.studit.model.dao.StudyRoomDAO;
import org.kosta.studit.model.service.MemberService;
import org.kosta.studit.model.service.RecruitService;
import org.kosta.studit.model.service.StudyRoomService;
import org.kosta.studit.model.vo.MemberVO;
import org.kosta.studit.model.vo.SmallCategoryVO;
import org.kosta.studit.model.vo.StudyConditionListVO;
import org.kosta.studit.model.vo.StudyRoomConditionListVO;
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
	@Autowired
	private CompanyDAO companyDAO;
	@Autowired
	private RecruitService recruitService;
	@Autowired
	private StudyRoomService studyroomService;
	
	   

	/**
	 * 아아디 중복확인을 위한 메서드. 사용자가 입력한 Email을 실시간으로 중복확인 한다.
	 * 
	 * @author 송용준,변태섭
	 * @param 사용자가
	 *            입력한 Email
	 * @return 중복인 경우 false, 중복이 아닌 경우 true
	 */
	@RequestMapping("/findCheckByEmail")
	@ResponseBody
	public boolean findCheckByEmail(String memberEmail) {
		if (memberDAO.findMemberByEmail(memberEmail) == null) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 
	 * 비밀번호 검증 메서드 사용자가 입력한 현재 비밀번호를 DB에 저장된 정보와 비교하여 검증하여 결과값을 반환
	 * 
	 * @author 김유란
	 * @param HttpServletRequest
	 *            파라미터를 받아오기 위해 호출
	 * @exception EmailNotFoundException
	 *                아이디가 없을 때 발생하는 예외
	 * @exception PasswordIncorrectException
	 *                비밀번호가 틀릴 때 발생하는 예외
	 * @return boolean 파라미터로 받아온 비밀번호 입력값의 DB 일치 여부에 따라 true/false 반환
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/checkPassword")
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
	 * 소분류 목록을 불러오는 메서드 사용자가 선택한 대분류 번호를 전달받아 소분류 목록을 즉시 로드하기 위해
	 * 
	 * @author 김유란
	 * @param bigCategoryNo
	 *            사용자가 선택한 대분류 번호
	 * @return List<SmallCategoryVO> 소분류 번호와 이름 정보를 담은 VO 리스트
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/getSmallCategoryList")
	@ResponseBody
	public List<SmallCategoryVO> getSmallCategoryList(String bigCategoryNo) {
		return recruitDAO.findSmallCategoryListByBigCategoryNo(bigCategoryNo);
	}

	/**
	 * 모집게시글에 따른 댓글 등록
	 * @author 유동규
	 * @param recruitNo 댓글을 가지고 있는 모집 게시글 번호
	 * @param comment 입력할 댓글
	 * @return true 정상 작동하면 true
	 * 
	 * @param recruitNo
	 * @param comment
	 * @return
	 */
	@RequestMapping(value = "/registerComment", method = RequestMethod.POST)
	@ResponseBody
	public String registerComment(int recruitNo, String comment, HttpServletRequest request) {
		String userEmail = ((MemberVO)request.getSession().getAttribute("memberVO")).getMemberEmail();
		Map<String, Object> commentMap = new HashMap<>();
		commentMap.put("comment", comment);
		commentMap.put("userEmail", userEmail);
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
		return studyroomService.findStudyRoomConditionListVOByEmail(((MemberVO)request.getSession().getAttribute("memberVO")).getMemberEmail(), nowPage);
	}
	
	/**
	 * 뷰에서 선택된 대분류에 대응되는 소분류를 조회.
	 * @author 송용준
	 * @param bigCategoryNo 뷰에서 선택된 대분류
	 * @return List<SmallCategoryVO> 조회한 소분류 리스트를 담은 객체
	 */
	@RequestMapping("/getSmallCategoryByBigCategoryAjax")
	@ResponseBody
	public List<SmallCategoryVO> getSmallCategoryByBigCategory(String bigCategoryNo) {
		List<SmallCategoryVO> list = recruitService.findSmallCategoryListByBigCategoryNo(bigCategoryNo);
		System.out.println(list);
		return list;
	}
	
	/**
	 * 스터디룸(업체) 검색 뷰에서 선택된 addr1에 대응되는 addr2를 조회.
	 * @author 송용준
	 * @param addr1 뷰에서 선택된 첫번째 주소값
	 * @return List<String> 조회한 addr2 리스트를 담은 객체
	 */
	@RequestMapping("/findSecondAddressListByFirstAddressName")
	@ResponseBody
	public List<String> findSecondAddressListByFirstAddressName(String addr1){
		List<String> list=companyDAO.findSecondAddressListByFirstAddressName(addr1);
		return list;
	}
	
	/**
	 * 스터디룸(업체) 검색 뷰에서 선택된 addr2에 대응되는 addr3를 조회.
	 * @author 송용준
	 * @param addr2 뷰에서 선택된 두번째 주소값
	 * @return List<String> 조회한 addr3 리스트를 담은 객체
	 */
	@RequestMapping("/findThirdAddressListBySecondAddressName")
	@ResponseBody
	public List<String> findThirdAddressListBySecondAddressName(String addr2){
		List<String> list=companyDAO.findThirdAddressListBySecondAddressName(addr2);
		return list;
	}
	/**
	 * 스터디 현황 조회를 위한 페이징.
	 * 해당 사용자에 따른 전체 수를 구한 뒤 페이징처리를 한다.
	 * @author 유동규, 변태섭
	 * @param nowPage 현재 페이지
	 * @return StudyConditionListVO 페이징한 결과(list)와 페이징 객체가 담겨있는 객체
	 */
	@RequestMapping("/findStudyConditionByNowPage")
	@ResponseBody
	public StudyConditionListVO findStudyConditionByNowPage(int nowPage, HttpServletRequest request) {
		return  recruitService.findStudyConditionByMemberEmail(((MemberVO)request.getSession().getAttribute("memberVO")).getMemberEmail(), nowPage);
	}
	
	/**
	 * 댓글 삭제하기
	 * @param commentNo 삭제할 댓글 번호
	 */
	@RequestMapping(value="/deleteCommentByCommentNo", method=RequestMethod.POST)
	@ResponseBody
	public void deleteCommentByCommentNo(int commentNo) {
		recruitDAO.deleteCommentByCommentNo(commentNo);
	}
	
	/**
	 * 댓글 수정하기
	 * @param commentNo 수정할 댓글번호
	 * @param content 수정할 내용
	 */
	@RequestMapping(value="/updateCommentByCommentNo", method=RequestMethod.POST)
	@ResponseBody
	public void updateCommentByCommentNo(int commentNo, String content) {
		Map<String, Object> map = new HashMap<>();
		map.put("commentNo", commentNo);
		map.put("content", content);
		recruitDAO.updateCommentByCommentNo(map);
	}
	
	

}
