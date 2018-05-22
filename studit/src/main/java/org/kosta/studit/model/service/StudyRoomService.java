package org.kosta.studit.model.service;

import org.kosta.studit.model.vo.StudyRoomConditionListVO;

public interface StudyRoomService {

	StudyRoomConditionListVO findStudyRoomConditionListVOByEmail(String memberEmail, int nowPage);
}
