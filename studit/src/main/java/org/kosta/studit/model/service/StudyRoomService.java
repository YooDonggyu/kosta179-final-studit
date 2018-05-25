package org.kosta.studit.model.service;

import java.util.List;

import org.kosta.studit.model.vo.StudyRoomConditionListVO;

import org.kosta.studit.model.vo.StudyRoomVO;

import org.kosta.studit.model.vo.StudyRoomConditionVO;

public interface StudyRoomService {

	StudyRoomConditionListVO findStudyRoomConditionListVOByEmail(String memberEmail, int nowPage);

	void registerStudyRoom(StudyRoomVO studyRoomVO, List<String> studyRoomPicFileList, String[] studyRoomFunction);

	List<StudyRoomConditionVO> findStudyRoomConditionByStudyRoomNoAndDate(String selectedDate, String studyRoomNo);

}
