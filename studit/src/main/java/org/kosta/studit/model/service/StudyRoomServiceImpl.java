package org.kosta.studit.model.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.studit.model.PagingBean;
import org.kosta.studit.model.dao.CompanyDAO;
import org.kosta.studit.model.dao.StudyRoomDAO;
import org.kosta.studit.model.vo.CompanyVO;
import org.kosta.studit.model.vo.MemberVO;
import org.kosta.studit.model.vo.StudyRoomConditionListVO;
import org.kosta.studit.model.vo.StudyRoomConditionVO;
import org.kosta.studit.model.vo.StudyRoomVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
public class StudyRoomServiceImpl implements StudyRoomService {
	
	@Autowired
	private StudyRoomDAO studyroomDAO;
	
	@Autowired
	private CompanyDAO companyDAO;
	
	/**
	 * 스터디 룸 신청현황에 따른 페이징 결과 처리
	 * @author 유동규
	 * @param memberEmail 스터디 룸 신청현황을 조회할 이메일
	 * @param nowPage 현재 페이지
	 * @return StudyRoomConditionListVO 페이징 처리 후 List 와 pagingBean 객체가 담겨 있는 객체
	 */
	@Override
	public StudyRoomConditionListVO findStudyRoomConditionListVOByEmail(String memberEmail, int nowPage) {
		//스터디 룸 현황조회
		//1. 총 게시물로 pagingbean 만들기
		PagingBean pb= null;
		if(nowPage == 0) {
			pb = new PagingBean(studyroomDAO.findTotalStudyRoomConditionByEmail(memberEmail));
		}else {
			pb = new PagingBean(studyroomDAO.findTotalStudyRoomConditionByEmail(memberEmail), nowPage);
		}
		//2. 조건문을 위해 이메일과 pb로 Map을 만들어 전달
		Map<String, Object> map = new HashMap<>();
		map.put("pagingBean", pb);
		map.put("memberEmail", memberEmail);
		//3. Map으로 paging처리된 결과 List로 받아오기
		List<StudyRoomConditionVO>list =  studyroomDAO.findStudyConditionByEmail(map);
		//4. paging된 list와 pb객체를 StudyRoomConditionListVO에 담아 전달
		StudyRoomConditionListVO srcListVO = new StudyRoomConditionListVO(list, pb);
		return srcListVO;
	}
	
	/**
	 * 스터디룸 및 스터디룸 연관 테이블을 등록하는 메서드
	 * 
	 * @author 변태섭
	 * @param StudyRoomVO 스터디룸 정보가 담긴 객체
	 * @param List 스터디룸 사진 경로들이 담긴 객체
	 */
	@Transactional
	@Override
	public void registerStudyRoom(StudyRoomVO studyRoomVO, List<String> studyRoomPicFileList, String[] studyRoomFunction) {
		System.out.println("Service 진입");
		studyroomDAO.registerStudyRoom(studyRoomVO);
		System.out.println("registerStudyRoom");
		System.out.println("after studyRoomVO: "+studyRoomVO);
		Map<String, Object> studyRoomMap = new HashMap<String, Object>();
		studyRoomMap.put("studyRoomNo", studyRoomVO.getStudyRoomNo());
		System.out.println("studyRoomMap: "+studyRoomMap);
		for(int i=0; i<studyRoomPicFileList.size(); i++) {
			studyRoomMap.put("studyRoomPicPath", studyRoomPicFileList.get(i));
			studyroomDAO.registerStudyRoomPicPath(studyRoomMap);
		}
		System.out.println("registerStudyRoomPic");
		
		for(String fun : studyRoomFunction) {
			studyRoomMap.put("studyRoomFunction", fun);
			studyroomDAO.registerStudyRoomFunction(studyRoomMap);
		}
		System.out.println("registerStudyRoomFunction");
	}

	/**
	 * 스터디룸 번호와 날짜로 예약현황 정보 불러오는 메서드
	 * 
	 * @author 김유란
	 * @param selectedDate 예약현황 조회를 원하는 날짜
	 * @param studyRoomNo 예약현황 조회를 원하는 스터디룸 번호
	 * @param List<StudyRoomConditionVO> 스터디룸 예약현황 정보를 담은 VO리스트
	 */
	@Override
	public List<StudyRoomConditionVO> findStudyRoomConditionByStudyRoomNoAndDate(String selectedDate, String studyRoomNo) {
		StudyRoomConditionVO studyRoomConditionVO = new StudyRoomConditionVO();
		studyRoomConditionVO.setStudyRoomVO(new StudyRoomVO(Integer.parseInt(studyRoomNo)));
		studyRoomConditionVO.setUseDate(selectedDate);
		return studyroomDAO.findStudyRoomConditionByStudyRoomNoAndDate(studyRoomConditionVO);
	}
	
	/**
	 * 스터디룸 예약 취소 메서드(데이터는 유지하되 상태를 변경)
	 * 
	 * @author 김유란
	 * @param memberEmail 회원 이메일
	 * @param studyRoomConditionNo 스터디룸 예약 신청 번호
	 */
	@Override
	public void updateStudyRoomConditionByMember(String memberEmail, String studyRoomConditionNo) {
		StudyRoomConditionVO studyRoomConditionVO = new StudyRoomConditionVO();
		studyRoomConditionVO.setMemberVO(new MemberVO(memberEmail, null));
		studyRoomConditionVO.setStudyRoomConditionNo(Integer.parseInt(studyRoomConditionNo));
		studyroomDAO.updateStudyRoomConditionByMember(studyRoomConditionVO);
	}
	
	/**
	 * 스터디룸 정보를 수정하는 메서드
	 * @author 변태섭
	 * @param companyNo 업체 번호
	 * @param studyRoomNo 스터디룸 번호
	 * @param studyRoomPicFile 스터디룸 사진 경로
	 * @param studyRoomFunction 스터디룸 제공 기능
	 */
	@Transactional
	@Override
	public void updateStudyRoom(String companyNo, String memberEmail, String studyRoomNo, StudyRoomVO studyRoomVO, MultipartFile studyRoomPicFile, String[] studyRoomFunction) {
		studyroomDAO.updateStudyRoom(studyRoomVO);
		Map<String, Object> map = new HashMap<String, Object>();
		 map.put("studyRoomNo", studyRoomNo);
		CompanyVO cvo = companyDAO.findCompanyByCompanyNo(Integer.parseInt(companyNo));
			//스터디룸 사진 인코딩
			if(studyRoomPicFile!=null && !studyRoomPicFile.isEmpty()) {
			     String fileName = memberEmail+"_"+cvo.getName()+"_"+studyRoomVO.getName()+"_"+studyRoomPicFile.getOriginalFilename();
			     //String path = request.getSession(false).getServletContext().getRealPath("upload"); 개발 완료 후 적용
			     map.put("path", fileName);
			     String path = "C:/resources/upload/";
			     
			     try {
			    	 studyRoomPicFile.transferTo(new File(path, fileName));//지정 경로에 실제 파일 저장
			    	 studyroomDAO.updateStudyRoomPicFile(map);
			     } catch (IllegalStateException | IOException e) {
			        System.out.println("Update StudyRoom PicFile Error(StudyRoomServiceImpl_updateStudyRoom)");
			     } 
			  }
			studyroomDAO.deleteStudyRoomFunctionByStudyRoomNo(Integer.parseInt(studyRoomNo));
			for(int i=0; i<studyRoomFunction.length; i++) {
				map.put("studyRoomFunction", studyRoomFunction[i]);
				studyroomDAO.registerStudyRoomFunction(map);
			}
	}
}
