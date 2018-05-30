package org.kosta.studit.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.kosta.studit.model.dao.StudyRoomDAO;
import org.kosta.studit.model.service.CompanyService;
import org.kosta.studit.model.service.StudyRoomService;
import org.kosta.studit.model.vo.CompanyVO;
import org.kosta.studit.model.vo.MemberVO;
import org.kosta.studit.model.vo.StudyRoomConditionVO;
import org.kosta.studit.model.vo.StudyRoomVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/studyroom")
public class StudyRoomController {

	@Autowired
	private StudyRoomDAO studyRoomDAO;
	
	@Autowired
	private CompanyService companyService;
	
	@Autowired
	private StudyRoomService studyRoomService;
	
	/**
	 * 스터디룸 예약 뷰 호출 메서드
	 *****캘린더 테스트 위해 작성한 임시 코드이므로 스터디룸 예약 메뉴가 정리되면 맞춰서 수정할 예정
	 * @author 김유란
	 * @param studyRoomNo 스터디룸 번호
	 * @param model 스터디룸 정보와 업체 영업일 정보 전송을 위해 호출
	 * @return 스터디룸 예약 뷰(업체 및 스터디룸 선택 뷰가 아직 없어서 스터디룸 번호 임의로 넣어 바로 호출)
	 */
	@RequestMapping("/createStudyRoomConditionView")
	public String createStudyRoomConditionView(String studyRoomNo, Model model) {
		StudyRoomVO studyRoomVO =  studyRoomDAO.findStudyRoomInfoByStudyRoomNo("1");
		model.addAttribute("studyRoomVO", studyRoomVO);
		model.addAttribute("businessDay", companyService.findBusinessDayByCompanyNo(studyRoomVO.getCompanyVO().getCompanyNo()));
		return "studyroom/create_studyRoom_condition.tiles";
	}
	
	/**
	 * 스터디 룸 예약 메서드
	 * @author 유동규, 이승수, 김유란
	 * @param studyRoomConditionVO
	 * @return 예약 결과 뷰를 호출하는 메서드로 이동(redirect)
	 */
	@RequestMapping(value="/createStudyRoomCondition", method=RequestMethod.POST)
	public String createStudyRoom(StudyRoomConditionVO studyRoomConditionVO) {
		studyRoomDAO.createStudyRoomCondition(studyRoomConditionVO);
		return "redirect:/studyroom/createStudyRoomConditionResult";
	}
	
	/**
	 * 스터디 룸 예약 결과를 보여주는 메서드
	 * @author 유동규, 이승수, 김유란
	 * @param studyRoomConditionVO
	 * @return studyroom/create_studyroom_ok 예약 결과 뷰
	 */
	@RequestMapping("/createStudyRoomConditionResult")
	public String createStudyRoomConditionResult() {
		return "studyroom/create_condition_ok";
	}
	
	/**
	 * 추가 스터디룸을 등록하는 메서드
	 * 
	 * @author 변태섭
	 * @param memberEmail 회원 이메일
	 * @param companyName 스터디룸이 등록 될 업체명
	 * @param companyNo 스터디룸이 등록 될 업체 번호
	 * @param studyRoomVO 스터디룸 정보를 담은 객체
	 * @param studyRoomPicFile 스터디룸 사진경로들을 담은 객체
	 * @param studyRoomFunction 스터디룸 기능들을 담은 객체
	 */
	@PostMapping
	@RequestMapping("registerStudyRoom")
	public String resigetregisterStudyRoom(String memberEmail, String companyName, String companyNo, StudyRoomVO studyRoomVO, MultipartFile studyRoomPicFile, String[] studyRoomFunction) {
		
			System.out.println(memberEmail);
			System.out.println(companyNo);
			System.out.println(companyName);
			System.out.println(studyRoomVO);
			studyRoomVO.setCompanyVO(new CompanyVO());
			studyRoomVO.getCompanyVO().setMemberVO(new MemberVO());
			
			studyRoomVO.getCompanyVO().setCompanyNo(Integer.parseInt(companyNo));
			studyRoomVO.getCompanyVO().setName(companyName);
			studyRoomVO.getCompanyVO().getMemberVO().setMemberEmail(memberEmail);
			
			List<String> studyRoomPicFileList = new ArrayList<String>();
			System.out.println("studyRoomVO: "+studyRoomVO);
			//스터디룸 사진 인코딩
				if(studyRoomPicFile!=null && !studyRoomPicFile.isEmpty()) {
				     String fileName = memberEmail+"_"+studyRoomVO.getCompanyVO().getName()+"_"+studyRoomVO.getName()+"_"+studyRoomPicFile.getOriginalFilename();
				     //String path = request.getSession(false).getServletContext().getRealPath("upload"); 개발 완료 후 적용
				     
				     //태섭 경로
				     String path = "D:/KOSTA/workspace/resources/upload/studyroom/";
				     
				     //String path ="C:/java-kosta/project/Final/kosta179-final-studit/studit/src/main/webapp/resources/upload";
				     try {
				    	 studyRoomPicFile.transferTo(new File(path, fileName));//지정 경로에 실제 파일 저장
				    	 studyRoomPicFileList.add(fileName);
				     } catch (IllegalStateException | IOException e) {
				        return "member/update_pic_fail.tiles";
				     } 
				  }else {//파일을 첨부하지 않았을 때
					  studyRoomPicFileList.add("studyroom.png");
				  }
				
			System.out.println("studyRoomPic: "+studyRoomPicFileList);
			studyRoomService.registerStudyRoom(studyRoomVO, studyRoomPicFileList, studyRoomFunction);
		return "redirect:addStudyRoomOkView";
	}
	
	/**
	 * 추가 스터디룸 등록 완료 script
	 * 
	 * @author 변태섭
	 */
	@RequestMapping("addStudyRoomOkView")
	public String addStudyRoomOkView() {
		return "studyroom/add_studyroom_ok";
	}
}
