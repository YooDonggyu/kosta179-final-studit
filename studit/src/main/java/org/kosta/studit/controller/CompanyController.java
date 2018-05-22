package org.kosta.studit.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.kosta.studit.model.dao.CompanyDAO;
import org.kosta.studit.model.service.CompanyService;
import org.kosta.studit.model.vo.CompanyVO;
import org.kosta.studit.model.vo.MemberVO;
import org.kosta.studit.model.vo.StudyRoomConditionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/company")
@Controller
public class CompanyController {
	
	@Autowired
	private CompanyDAO companyDAO;
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
	
	/**
	 * 업체의 스터디룸 예약현황 뷰를 호출하는 메서드
	 * 업체회원이 보유한 스터디룸의 예약현황 정보 조회를 위해 
	 * 영업일, 스터디룸 정보, 각 스터디룸별 예약현황 데이터를 가져와 뷰로 전송한다.
	 * 
	 * @author 김유란
	 * @param request 세션을 얻기 위해 호출
	 * @return 업체 스터디룸 예약현황 관리 뷰로 이동(tiles)
	 */
	@RequestMapping("/findStudyRoomConditionByCompanyNo")
	public String findStudyRoomConditionByCompanyNo(HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession(false).getAttribute("memberVO");
		request.setAttribute("businessHour", companyService.findBusinessDayByMemberEmail(memberVO.getMemberEmail()));
		request.setAttribute("studyRoomResource", companyService.findStudyRoomByMemberEmail(memberVO.getMemberEmail()));
		request.setAttribute("studyRoomCondition", companyService.findStudyRoomConditionByMemberEmail(memberVO.getMemberEmail()));
		return "company/find_studyRoom_condition.tiles";
	}
	
	/**
	 * 업체의 스터디룸 예약현황 수정 메서드
	 * 업체회원이 스터디룸 예약을 승인하거나 수정할 때 실행 
	 * 
	 * @author 김유란
	 * @param studyRoomConditionVO 수정된 예약정보를 담은 VO
	 * @return 업체 스터디룸 예약현황 관리 뷰로 이동하기 위해 해당 뷰 호출 메서드로 redirect
	 */
	@RequestMapping("/updateStudyRoomCondition")
	public String updateStudyRoomCondition(StudyRoomConditionVO studyRoomConditionVO){
		System.out.println(studyRoomConditionVO);
		companyDAO.updatStudyRoomCondition(studyRoomConditionVO);
		return "redirect:/company/findStudyRoomConditionByCompanyNo";
	}
}
