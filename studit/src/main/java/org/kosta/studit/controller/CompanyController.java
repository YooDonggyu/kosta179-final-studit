package org.kosta.studit.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.kosta.studit.model.dao.CompanyDAO;
import org.kosta.studit.model.dao.MemberDAO;
import org.kosta.studit.model.dao.StudyRoomDAO;
import org.kosta.studit.model.service.CompanyService;
import org.kosta.studit.model.service.MemberService;
import org.kosta.studit.model.service.StudyRoomService;
import org.kosta.studit.model.vo.CompanyListVO;
import org.kosta.studit.model.vo.CompanyVO;
import org.kosta.studit.model.vo.MemberVO;
import org.kosta.studit.model.vo.StudyRoomConditionVO;
import org.kosta.studit.model.vo.StudyRoomVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/company")
public class CompanyController {
	
	@Autowired
	private CompanyDAO companyDAO;
	@Autowired
	private CompanyService companyService;
	@Autowired
	private StudyRoomService studyroomService;
	@Autowired
	private StudyRoomDAO studyroomDAO;
	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private MemberService memberService;
	
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
		CompanyListVO allCompanyList=companyService.findCompanyListByCondition(null);
		//DB에 저장된 모든 해쉬태그 목록 : 업체가 가진 해쉬태그를 뷰에 표시
		List<Map<String, Object>> allHashTagList=companyService.readAllHashTag();
		
		request.setAttribute("firstAddrList", firstAddrList);
		request.setAttribute("allCompanyList", allCompanyList.getList());
		request.setAttribute("pagingBean", allCompanyList.getPagingBean());
		request.setAttribute("allHashTagList", allHashTagList);
		
		return "company/find_Company_View.tiles";
	}
	
	/**ajax로 변경
	 * 업체의 스터디룸 예약현황 뷰를 호출하는 메서드
	 * 업체회원이 보유한 스터디룸의 예약현황 정보 조회를 위해 
	 * 영업일, 스터디룸 정보, 각 스터디룸별 예약현황 데이터를 가져와 뷰로 전송한다.
	 * 
	 * @author 김유란
	 * @param request 세션을 얻기 위해 호출
	 * @return 업체 스터디룸 예약현황 관리 뷰로 이동(tiles)
	 */
	@RequestMapping("/findStudyRoomConditionByCompanyNo")
	public String findStudyRoomConditionByCompanyNo(Model model, String companyNo) {
		model.addAttribute("businessHour", companyService.findBusinessDayByCompanyNo(1));
		model.addAttribute("studyRoomResource", companyService.findStudyRoomByCompanyNo(1));
		model.addAttribute("conditionCount", companyDAO.findStudyRoomConditionCountByMonth("1"));
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
	
	/**
	 * Host Page로 이동하는 Controller
	 * 
	 * @author 변태섭
	 */
	@RequestMapping("/companyView")
	public String companyView(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		MemberVO mvo=(MemberVO) session.getAttribute("memberVO");
		Map<String,String> map=new HashMap<String,String>();
		map.put("memberEmail",	mvo.getMemberEmail());
		map.put("memberPosition", "업체");
		if(memberDAO.findCountMemberPositionByMemberPositionAndMemberEmail(map)!=0) {
			model.addAttribute("cvoList", companyDAO.findCompanyByMemberEmail(mvo.getMemberEmail()));
			model.addAttribute("srvoList", studyroomDAO.findStudyRoomListByMemberEmail(mvo.getMemberEmail()));
			return "company/update_company/hostpage_left.tiles";
		}
		return "company/company_view.tiles";
	}
	
	/**
	 * 업체 등록 Form으로 이동하는 Controller
	 * @author 변태섭
	 */
	@RequestMapping("registerCompanyView")
	public String registerCompanyView() {
		return "company/register_company.tiles";
	}
	
	/**
	 * 업체 및 스터디룸을 등록하는 Controller
	 * 
	 * @author 변태섭
	 * @param request Session에 담긴 MemberVO.memberEmail을 활용
	 * @param studyRoomVO 입력받은 업체, 스터디룸 정보
	 * @param day String으로 받은 업체 영업 요일
	 * @param hashtag String으로 받은 해시태그
	 * @param companyPicFile 업체 사진 경로
	 * @param studyRoomPicFile 스터디룸 사진 경로
	 * @param studyRoomFunction[] 스터디룸 제공 기능 배열
	 */
	@RequestMapping(value="/registerCompany", method=RequestMethod.POST)
	public String registerCompany(HttpServletRequest request, StudyRoomVO studyRoomVO, String day, String hashtag, MultipartFile[] companyPicFile, MultipartFile studyRoomPicFile, String[] studyRoomFunction) {
		HttpSession session= request.getSession(false);
		MemberVO memberVO=(MemberVO) session.getAttribute("memberVO");
		studyRoomVO.getCompanyVO().setMemberVO(memberVO);
		List<String> companyPicFileList = new ArrayList<String>();
		List<String> studyRoomPicFileList = new ArrayList<String>();
		
	//업체 사진 인코딩
	for(int i=0; i<companyPicFile.length; i++) {
			if(companyPicFile[i]!=null && !companyPicFile[i].isEmpty()) {
			     String fileName = memberVO.getMemberEmail()+"_"+studyRoomVO.getCompanyVO().getName()+"_"+companyPicFile[i].getOriginalFilename();
			     //String path = request.getSession(false).getServletContext().getRealPath("upload"); 개발 완료 후 적용
			     
			     String path = "C:/resources/upload/";
			     try {
			    	companyPicFile[i].transferTo(new File(path, fileName));//지정 경로에 실제 파일 저장
			    	if(i==0) {
			    		studyRoomVO.getCompanyVO().setProfilePath(fileName);
			    	}else {
			    		companyPicFileList.add(fileName);
			    	}
			     } catch (IllegalStateException | IOException e) {
			        return "member/update_pic_fail.tiles";
			     } 
			  }else {//파일을 첨부하지 않았을 때
				  studyRoomVO.getCompanyVO().setProfilePath("company.png");
			  }
		}
	
		//스터디룸 사진 인코딩
				if(studyRoomPicFile!=null && !studyRoomPicFile.isEmpty()) {
				     String fileName = memberVO.getMemberEmail()+"_"+studyRoomVO.getCompanyVO().getName()+"_"+studyRoomVO.getName()+"_"+studyRoomPicFile.getOriginalFilename();
				     //String path = request.getSession(false).getServletContext().getRealPath("upload"); 개발 완료 후 적용
				     
				     String path ="C:/resources/upload/";
				     try {
				    	 studyRoomPicFile.transferTo(new File(path, fileName));//지정 경로에 실제 파일 저장
				    	 studyRoomPicFileList.add(fileName);
				     } catch (IllegalStateException | IOException e) {
				        return "redirect:/";
				     } 
				  }else {//파일을 첨부하지 않았을 때
					  studyRoomPicFileList.add("studyroom.png");
				  }
		
		System.out.println(studyRoomVO);
		System.out.println(day);
		System.out.println(hashtag);
		System.out.println(companyPicFileList);
		System.out.println(studyRoomPicFileList);
		
		CompanyVO companyVO = studyRoomVO.getCompanyVO();
		companyService.registerCompany(companyVO, day, hashtag, companyPicFileList);
		studyroomService.registerStudyRoom(studyRoomVO, studyRoomPicFileList, studyRoomFunction);
		return "redirect:registerCompanyOkView";
	}
	
	/**
	 * 업체 등록 완료 시 띄우는 script
	 * 
	 * @author 변태섭
	 */
	@RequestMapping("/registerCompanyOkView")
	public String  registerCompanyOkView() {
		return "/company/register_company_ok";
	}
	
	/**
	 * @author 유동규
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/findDetailCompanyInfoByCompanyNo")
	public String findDetailCompanyInfoByCompanyNo(Model model, HttpServletRequest request) {
		int companyNo = -1;
		if(request.getParameter("companyNo") != null ) {
			companyNo = Integer.parseInt(request.getParameter("companyNo"));
			
			// 1.세션 이메일과 게시글 작성자를 비교해서 작성자이면 조회수 증가 방지
			// 2.cHitList에 포함된 게시글은 조회수 증가 방지
			String sessionEmail = ((MemberVO) request.getSession().getAttribute("memberVO")).getMemberEmail();
			String companyMemberEmail = companyDAO.findCompanyMemberEmailByCompanyNO(companyNo);
			ArrayList<Integer> cHitList = (ArrayList<Integer>) request.getSession().getAttribute("cHitList");
			if (!cHitList.contains(companyNo) && !sessionEmail.equals(companyMemberEmail)) {
				companyDAO.updateCompanyHit(companyNo);
				cHitList.add(companyNo);
			}
			
		}
		model.addAttribute("com", companyService.findDetailCompanyInfoByCompanyNo(companyNo));
		
		return "company/detail_company.tiles";
	}
	
	/**
	 * 스터디룸을 추가하는 폼으로 이동
	 * 
	 * @author 변태섭
	 * @param companyNo 스터디룸이 추가 되는 업체 번호
	 * @param model companyNo을 받아 view로 넘겨주는 역할
	 */
	@RequestMapping("/registerStudyRoomForm")
	public String registerStudyroomForm(HttpServletRequest request, String companyNo, String companyName, Model model) {
		HttpSession session = request.getSession(false);
		MemberVO mvo = (MemberVO) session.getAttribute("memberVO");
		
		model.addAttribute("cvoList", companyDAO.findCompanyByMemberEmail(mvo.getMemberEmail()));
		model.addAttribute("srvoList", studyroomDAO.findStudyRoomListByMemberEmail(mvo.getMemberEmail()));
		model.addAttribute("cno", companyNo);
		model.addAttribute("cname", companyName);
		return "company/add_studyroom/hostpage_left.tiles";
	}
	
	/**
	 * 등록 된 스터디룸 정보를 조회하는 뷰
	 * 
	 * @author 변태섭
	 * @param studyRoomNo 조회하는 스터디룸 번호
	 * @param memberEmail 회원 이메일
	 * @param model View 단에 데이터를 전달하는 객체
	 */
	@RequestMapping("StudyRoomInfoView")
	public String StudyRoomInfoView(String studyRoomNo, String memberEmail, Model model) {
		model.addAttribute("cvoList", companyDAO.findCompanyByMemberEmail(memberEmail));
		model.addAttribute("srvoList", studyroomDAO.findStudyRoomListByMemberEmail(memberEmail));
		model.addAttribute("srno",studyRoomNo);
		return "company/studyroom_info_view/hostpage_left.tiles";
	}
}
