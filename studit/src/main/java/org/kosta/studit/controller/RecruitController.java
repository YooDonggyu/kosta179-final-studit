package org.kosta.studit.controller;


import java.util.HashMap;

import org.kosta.studit.model.dao.RecruitDAO;
import org.kosta.studit.model.service.RecruitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/recruit")
public class RecruitController {
	@Autowired
	private RecruitService recruitService;
	@Autowired
	private RecruitDAO recruitDAO;
	
	
	@RequestMapping("/getRecruitList")
	public String getRecruitList() {
		return"recruit/list_recruit.tiles";
	}
	
	
	/**
	 * 스터디를 신청시 사용하는 메서드
	 * 
	 * @author 이승수
	 * @param recruitPostNo 현재 보고있는 등록게시글 번호
	 * @param memberEmail 현재 로그인되어있는 회원 이메일
	 * @param context 신청시 작성하는 자기소개
	 * @param request 세션을 불러오기위해 사용
	 */
	@RequestMapping("/registerRcruitStudy")
	public String registerRecruitStudy(int recruitPostNo, String memberEmail, String context) {
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("recruitNo", recruitPostNo);
		map.put("memberEmail", memberEmail);
		int state=recruitDAO.findStudyConditionCountByEmailAndRecruitNo(map);
		if(state==1) {
			recruitService.updateRecruitStudy(recruitPostNo, memberEmail, context);
		}else {
			recruitService.registerRecruitStudy(recruitPostNo, memberEmail, context);
		}
		return "recruit/register_recruit_ok";
	}
	
	/**
	 * 전체 모집글을 불러오는 메서드
	 * 
	 * @author 이승수
	 * @param pageNo 요청된 페이지 번호
	 * @param model 모집글 리스트 객체를 담아 전송하기 위해 호출
	 * @return recruit/list_recruit.tiles 스터디 모집 메인 페이지
	 */
	@RequestMapping("/getRecruitPostList")
	public String getRecruitPostList(Model model, String pageNo) {
		model.addAttribute("bigCategoryList", recruitDAO.getBigCategoryList());
		model.addAttribute("recruitPostListVO", recruitService.getRecruitPostList(pageNo));
		return "recruit/list_recruit.tiles";
	}
	
	/**
	 * 검색된 모집글을 불러오는 메서드
	 * 
	 * @author 김유란
	 * @param category 선택된 소분류 배열
	 * @param keyword 사용자가 입력한 검색어
	 * @param pageNo 요청된 페이지 번호
	 * @param model 모집글 리스트 객체를 담아 전송하기 위해 호출
	 * @return recruit/findRecruitPostByCategoryAndKeyword 스터디 모집글 검색결과 페이지
	 */
	@RequestMapping("/findRecruitPostByCategoryAndKeyword")
	public String findRecruitPostCountByCategoryAndKeyword(String[] category, String keyword, String pageNo, Model model) {
		model.addAttribute("bigCategoryList", recruitDAO.getBigCategoryList());
		model.addAttribute("recruitPostListVO", recruitService.findRecruitPostByCategoryAndKeyword(category, keyword, pageNo));
		return  "recruit/findRecruitPostByCategoryAndKeyword.tiles";
	}
}
