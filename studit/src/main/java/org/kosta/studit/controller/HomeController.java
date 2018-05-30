package org.kosta.studit.controller;

import java.util.List;
import java.util.Map;

import org.kosta.studit.model.dao.CompanyDAO;
import org.kosta.studit.model.dao.RecruitDAO;
import org.kosta.studit.model.vo.CompanyVO;
import org.kosta.studit.model.vo.RecruitPostVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/")
public class HomeController {
	
	@Autowired
	private RecruitDAO recruitDAO;
	@Autowired
	private CompanyDAO companyDAO;
	
	
	/**
	 * 
	 * 메인 홈페이지로 이동.
	 * tiles를 적용하기 위해 .tiles를 붙여준다.
	 * @author 유동규
	 * @return home.tiles tiles가 적용된 메인 홈페이지로 이동
	 */
	@RequestMapping("/")
	public String home(Model model) {
		//1. 인기 검색어 TOP5 가져오기
		List<Map<String, Object>> keywordList = recruitDAO.getTopFiveKeyword();
		//2. 최근 등록된 스터디 모집 게시글 TOP5 가져오기
		List<RecruitPostVO> recruitPostList = recruitDAO.getTopFiveRecruitPost();
		//3. 조회수가 가장 높은 업체 3곳 가져오기
		List<CompanyVO> companyList = companyDAO.getTopThreeComapny();
		
		model.addAttribute("keywordList", keywordList);
		model.addAttribute("recruitPostList", recruitPostList);
		model.addAttribute("companyList", companyList);
		return"home.tiles";
	}
	
	@RequestMapping("/loginNeed")
	public String loginNeed() {
		return"member/login_needed.tiles";
	}
	
	
	
	
	/**
	 * session처리가 필요없는 요청에 즉각 페이지를 이동하기 위한 메서드.
	 * 이동할 .jsp를 viewName으로 url-pattern으로 지정해서 viewName.tiles로 이동한다. 
	 * @author 유동규
	 * @param viewName @PathVariable 어노테이션을 이용해 이동할 .jsp 이름을 저장
	 * @return member/viewName member에서만 session을 사용하지 않기 때문에 member/를 붙여준다. 
	 */
	@RequestMapping("/{viewName}")
	public String showTiles(@PathVariable String viewName) {
		System.out.println("homecontroller viewName:"+ viewName);
		return "member/"+viewName+".tiles";
	}


}
