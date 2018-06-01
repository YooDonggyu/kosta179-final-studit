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

	void createStudyRoomCondition(StudyRoomConditionVO studyRoomConditionVO);

	List<StudyRoomConditionVO> findStudyRoomConditionByStudyRoomNoAndDate(StudyRoomConditionVO studyRoomConditionVO);

	List<StudyRoomVO> findStudyRoomInfoByCompanyNo(int companyNo);

	List<Map<String, Object>> findStudyRoomPicByCompanyNo(int companyNo);

	List<Map<String, Object>> findstudyroomFunctionByCompanyNo(int companyNo);

	void updateStudyRoomConditionByMember(StudyRoomConditionVO studyRoomConditionVO);

	List<StudyRoomVO> findStudyRoomListByMemberEmail(String memberEmail);

	List<Map<String, String>> findStudyRoomPicPathByMemberEmail(String memberEmail);

	List<Map<String, String>> findStudyRoomFunctionByMemberEmail(String memberEmail);

	List<String> findStudyRoomFunctionByStudyRoomNo(int studyRoomNo);

	void deleteStudyRoomFunctionByStudyRoomNo(int studyRoomNo);

	void deleteStudyRoomPicFileByStudyRoomNo(int studyRoomNo);

	void updateStudyRoomPicFile(Map<String, Object> map);

	void updateStudyRoom(StudyRoomVO studyRoomVO);

}
