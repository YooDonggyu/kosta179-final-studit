package org.kosta.studit.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.kosta.studit.model.service.CompanyService;
import org.kosta.studit.model.vo.CompanyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/company")
@Controller
public class CompanyController {
	@Autowired
	private CompanyService companyService;
	
	/**
	 * 업체 검색을 위한 뷰로 이동시키는 메서드. 초기 검색 시 필요한 정보를 저장하여 업체 검색 뷰로 이동
	 * 
	 * @author 송용준
	 * @param request 초기 검색 시 필요한 정보를 저장하기 위한 객체
	 * @return 업체 검색 뷰 : tiles 적용
	 */
	@RequestMapping("/findCompanyView")
	public String findCompanyView(HttpServletRequest request) {
		//첫번째 주소 셀렉트 박스에 제공될 주소목록
		List<String> firstAddrList=companyService.readFirstAddr();
		//검색조건을 아무것도 선택하지 않을 경우 제공되는 모든 업체 목록
		List<CompanyVO> allCompanyList=companyService.readAllCompany();
		//DB에 저장된 모든 해쉬태그 목록 : 업체가 가진 해쉬태그를 뷰에 표시
		List<Map<String, Object>> allHashTagList=companyService.readAllHashTag();
		
		request.setAttribute("firstAddrList", firstAddrList);
		request.setAttribute("allCompanyList", allCompanyList);
		request.setAttribute("allHashTagList", allHashTagList);
		
		return "company/findCompanyView.tiles";
	}
}
