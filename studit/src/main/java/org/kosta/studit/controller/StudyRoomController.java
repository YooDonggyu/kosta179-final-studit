package org.kosta.studit.controller;

import org.kosta.studit.model.dao.StudyRoomDAO;
import org.kosta.studit.model.service.CompanyService;
import org.kosta.studit.model.service.StudyRoomService;
import org.kosta.studit.model.vo.StudyRoomConditionVO;
import org.kosta.studit.model.vo.StudyRoomVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/studyroom")
public class StudyRoomController {
	@Autowired
	private StudyRoomService studyRoomService;
	@Autowired
	private StudyRoomDAO studyRoomDAO;
	
	@Autowired
	private CompanyService companyService;
	
	/**
	 * 스터디룸 예약 뷰 호출 메서드
	 *****캘린더 테스트 위해 작성한 임시 코드이므로 스터디룸 예약 메뉴가 정리되면 맞춰서 수정할 예정
	 * @author 김유란
	 * @param studyRoomNo 스터디룸 번호
	 * @param model 스터디룸 정보와 업체 영업일 정보 전송을 위해 호출
	 * @return 스터디룸 예약 뷰(업체 및 스터디룸 선택 뷰가 아직 없어서 스터디룸 번호 임의로 넣어 바로 호출)
	 */
	@RequestMapping("/createStudyRoomReservation")
	public String createStudyRoomReservationView(String studyRoomNo, Model model) {
		StudyRoomVO studyRoomVO =  studyRoomDAO.findStudyRoomInfoByStudyRoomNo("2");
		model.addAttribute("studyRoomVO", studyRoomVO);
		model.addAttribute("businessDay", companyService.findBusinessDayByCompanyNo(studyRoomVO.getCompanyVO().getCompanyNo()));
		return "studyroom/create_studyRoom_reservation.tiles";
	}
	
	/**
	 * 스터디 룸 신청
	 * @author 유동규, 이승수
	 * @param studyRoomConditionVO
	 * @return
	 */
	@RequestMapping(value="registerStudyRoomCondition", method=RequestMethod.POST)
	public String registerStudyRoom(StudyRoomConditionVO studyRoomConditionVO) {
		studyRoomDAO.registerStudyRoomCondition(studyRoomConditionVO);
		return "redirect:/studyroom/register_studyroom_ok";
	}
}
