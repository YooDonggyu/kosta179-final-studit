package org.kosta.studit.model.dao;

import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.StudyRoomConditionVO;
import org.kosta.studit.model.vo.StudyRoomVO;

public interface StudyRoomDAO {

	String findWaitStudyRoomByEmail(String memberEmail);

	List<StudyRoomConditionVO> findStudyConditionByEmail(Map<String, Object> map);

	int findTotalStudyRoomConditionByEmail(String MemberEmail);

	StudyRoomVO findStudyRoomInfoByStudyRoomNo(String studyRoomNo);

	void registerStudyRoom(StudyRoomVO studyRoomVO);

	void registerStudyRoomPicPath(Map<String, Object> map);

	void registerStudyRoomFunction(Map<String, Object> map);

}
