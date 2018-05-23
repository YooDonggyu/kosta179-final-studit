package org.kosta.studit.model.service;

import java.util.List;

import org.kosta.studit.model.vo.StudyRoomConditionListVO;
import org.kosta.studit.model.vo.StudyRoomVO;

public interface StudyRoomService {

	StudyRoomConditionListVO findStudyRoomConditionListVOByEmail(String memberEmail, int nowPage);

void registerStudyRoom(StudyRoomVO studyRoomVO, List<String> studyRoomPicFileList);

}
