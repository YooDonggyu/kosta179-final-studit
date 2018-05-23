package org.kosta.studit.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.studit.model.PagingBean;
import org.kosta.studit.model.dao.StudyRoomDAO;
import org.kosta.studit.model.vo.StudyRoomConditionListVO;
import org.kosta.studit.model.vo.StudyRoomConditionVO;
import org.kosta.studit.model.vo.StudyRoomVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class StudyRoomServiceImpl implements StudyRoomService {
	
	@Autowired
	private StudyRoomDAO studyroomDAO;
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
		studyroomDAO.registerStudyRoom(studyRoomVO);
		
		Map<String, Object> studyRoomMap = new HashMap<String, Object>();
		studyRoomMap.put("studyRoomNo", studyRoomVO.getStudyRoomNo());
		
		for(int i=0; i<studyRoomPicFileList.size(); i++) {
			studyRoomMap.put("studyRoomPicPath", studyRoomPicFileList.get(i));
			studyroomDAO.registerStudyRoomPicPath(studyRoomMap);
		}
		
		for(String fun : studyRoomFunction) {
			studyRoomMap.put("studyRoomFunction", fun);
			studyroomDAO.registerStudyRoomFunction(studyRoomMap);
		}
	}
}
