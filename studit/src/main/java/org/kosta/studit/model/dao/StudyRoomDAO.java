package org.kosta.studit.model.dao;

import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.StudyRoomConditionVO;

public interface StudyRoomDAO {

	String findWaitStudyRoomByEmail(String memberEmail);


	int getTotalStudyRoomCondition();




	List<StudyRoomConditionVO> findStudyConditionByEmail(Map<String, Object> map);

}
