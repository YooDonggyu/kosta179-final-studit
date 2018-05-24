package org.kosta.studit.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.kosta.studit.model.dao.RecruitDAO;
import org.kosta.studit.model.service.RecruitService;
import org.kosta.studit.model.vo.BigCategoryVO;
import org.kosta.studit.model.vo.MemberVO;
import org.kosta.studit.model.vo.RecruitPostListVO;
import org.kosta.studit.model.vo.RecruitPostVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/recruit")
public class RecruitController {
	@Autowired
	private RecruitService recruitService;
	@Autowired
	private RecruitDAO recruitDAO;

	/**
	 * 스터디를 신청시 사용하는 메서드
	 * @author 이승수
	 * @param recruitPostNo 현재 보고있는 등록게시글 번호
	 * @param memberEmail 현재 로그인되어있는 회원 이메일
	 * @param context 신청시 작성하는 자기소개
	 * @param request 세션을 불러오기위해 사용
	 */
	@RequestMapping("/registerRcruitStudy")
	public String registerRecruitStudy(int recruitPostNo, String memberEmail, String context) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("recruitNo", recruitPostNo);
		map.put("memberEmail", memberEmail);
		int state = recruitDAO.findStudyConditionCountByEmailAndRecruitNo(map);
		if (state == 1) {
			if (recruitDAO.findStudyConditionStateByEmailAndRecruitNo(map).equals("미승인")) {
				return "recruit/register_recruit_fail";
			}
			recruitService.updateRecruitStudy(recruitPostNo, memberEmail, context);
		} else {
			recruitService.registerRecruitStudy(recruitPostNo, memberEmail, context);
		}
		return "recruit/register_recruit_ok";
	}

	/**
	 * 전체 모집글을 불러오는 메서드
	 * @author 이승수, 유동규
	 * @param pageNo 요청된 페이지 번호
	 * @param model 모집글 리스트 객체를 담아 전송하기 위해 호출
	 * @return recruit/list_recruit.tiles 스터디 모집 메인 페이지
	 */
	@RequestMapping("/getRecruitPostList")
	public String getRecruitPostList(Model model, String pageNo) {
		RecruitPostListVO rplVO = recruitService.findRecruitPostByCategoryOrKeyword("", "", "", Integer.parseInt(pageNo));
		model.addAttribute("recruitPostListVO", rplVO);
		model.addAttribute("bigCategoryList", recruitDAO.getBigCategoryList());
		return "recruit/list_recruit.tiles";
	}

	/**
	 * 모집 게시글 번호에 따른 상세보기 및 조회수 증가 및 정보, 카테고리(소, 대), 댓글, 요일을 반환 
	 * 조회수는 자기자신 것과 session이 유효한 상태에서 들어갔던 게시글은 올리지 않는다.
	 * @author 유동규
	 * @param recruitNo 조회할 모집 게시글 번호
	 * @param model view에 데이터 보여주기 위한 model
	 * @param request request객체를 이용해서 session 값 가져오기
	 * @return detail_recruit.tiles tiles가 적용된 상세보기화면으로 이동
	 */
	@RequestMapping("/findDetailRecruitPostInfoByRecruitNo")
	public String findDetailRecruitPostInfoByRecruitNo(int recruitNo, Model model, HttpServletRequest request) {
		// 1.세션 이메일과 게시글 작성자를 비교해서 작성자이면 조회수 증가 방지
		// 2.hitList에 포함된 게시글은 조회수 증가 방지
		String sessionEmail = ((MemberVO) request.getSession().getAttribute("memberVO")).getMemberEmail();
		String postEmail = recruitDAO.findRecruitWriterByRecruitNo(recruitNo);
		ArrayList<Integer> hitList = (ArrayList<Integer>) request.getSession().getAttribute("hitList");
		if (!hitList.contains(recruitNo) && !sessionEmail.equals(postEmail)) {
			recruitDAO.updateRecruitPostHitByRecruitNo(recruitNo);
			hitList.add(recruitNo);
		}
		// 값 가져오기
		Map<String, Object> map = recruitService.findRecruitPostDetailByRecruitNo(sessionEmail, recruitNo);
		model.addAttribute("recruitInfo", map);
		return "recruit/detail_recruit.tiles";
	}

	/**
	 * 모집 게시글 상세보기에서 수정하기 눌렀을 때 데이터를 가지고 이동하기 위한 메서드. 카테고리 상태를 유지하기 위해서 해당 대분류번호를 같이
	 * 넘겨 소분류 목록을 조회후 반환
	 * @author 유동규
	 * @param recruitNo 수정할 모집 게시글 번호
	 * @param model 데이터를 넘겨주기 위한 Model 사용
	 * @param bigCategoryNo 소분류 목록을 조회하기 위해 선택한 대분류 목록을 사용
	 * @return update_recruit.tiles tiles가 적용된 update 페이지로 이동
	 */
	@RequestMapping("/updateRecruitPostInfoByRecruitNoView")
	public String updateRecruitPostInfoByRecruitNoView(int recruitNo, Model model, int bigCategoryNo) {
		Map<String, Object> map = recruitService.findRecruitPostDetailByRecruitNo(null, recruitNo);
		model.addAttribute("recruitInfo", map);
		model.addAttribute("bigCategoryList", recruitDAO.getBigCategoryList());
		model.addAttribute("smallCategoryList", recruitDAO.findSmallCategoryListByBigCategoryNo(Integer.toString(bigCategoryNo)));
		return "recruit/update_recruit.tiles";
	}

	/**
	 * 카테고리, 모집게시글 정보와 요일을 수정.
	 * @author 유동규
	 * @param recruitPostVO 수정할 정보가 담긴 객체
	 * @param day 수정할 요일(배열)
	 * @return detail_recruit 수정된 내용을 확인해주기 위해 상세화면으로 이동
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/updateRecruitPostInfoByRecruitNo")
	public String updateRecruitPostInfoByRecruitNo(RecruitPostVO recruitPostVO, String day) {
		// day를 list에 담기
		List<String> days = new ArrayList<>();
		for (int i = 0; i < day.split(",").length; i++) {
			days.add(day.split(",")[i]);
		}
		// 카테고리, 상세정보, 요일 UPDATE
		recruitService.updateRecruitPostInfoByRecruitNo(recruitPostVO, days);
		return "redirect:/recruit/findDetailRecruitPostInfoByRecruitNo?recruitNo=" + recruitPostVO.getRecruitPostNo();
	}

	/**
	 * 모집 게시글 번호의 상태를 '삭제'로 변경.
	 * @author 유동규
	 * @param recruitNo 상태 변경할 모집게시글 번호
	 * @return getRecruitPostList 전체 목록 조회 화면으로 보내준다.
	 */
	@RequestMapping(value = "deleteRecruitPostByRecruitNo", method = RequestMethod.POST)
	public String deleteRecruitPostByRecruitNo(int recruitNo) {
		recruitDAO.updateDeleteStudyConditionByRecruitNo(recruitNo);
		return "redirect:/recruit/getRecruitPostList?pageNo=1";
	}

	/**
	 * 
	 * 모집 게시판에 글을 작성하고자 할 때 제공되는 작성 페이지
	 * @author 송용준
	 * @return 글작성을 위한 폼을 제공하는 페이지
	 */
	@RequestMapping("/createRecruitPostView")
	public String createRecruitPostView(HttpServletRequest request) {
		List<BigCategoryVO> cList = recruitService.getBigCategoryList();
		request.setAttribute("cList", cList);
		return "recruit/create_recruit_post.tiles";
	}

	/**
	 * 
	 * 사용자가 작성한 글을 DB에 저장하는 메서드
	 * @author 송용준
	 * @param recruitPostVO 사용자가 작성한 글의 정보를 저장한 객체
	 * @param recruitDay 사용자가 작성한 글의 모집요일을 저장한 배열 객체
	 * @return 작성완료된 글의 상세보기 페이지로 이동
	 */
	@RequestMapping("/createRecruitPost")
	public String createRecruitPost(RecruitPostVO recruitPostVO, String days, HttpServletRequest request) {
		String[] recruitDay = days.split(",");
		HttpSession session=request.getSession();
		recruitPostVO.setMemberVO((MemberVO)session.getAttribute("memberVO"));
		recruitService.createRecruitPost(recruitPostVO, recruitDay);
		// 모집글 상세보기로 이동
		return "redirect:/recruit/findDetailRecruitPostInfoByRecruitNo?recruitNo="+recruitPostVO.getRecruitPostNo();
	}
}
