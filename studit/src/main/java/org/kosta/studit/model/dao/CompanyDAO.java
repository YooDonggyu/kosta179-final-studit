package org.kosta.studit.model.dao;

import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.CompanyVO;
import org.kosta.studit.model.vo.StudyRoomConditionVO;
import org.kosta.studit.model.vo.StudyRoomVO;

public interface CompanyDAO {

	String findWaitReservationByEmail(String memberEmail);

	List<String> readFirstAddr();

	List<CompanyVO> readAllCompany();

	List<Map<String, Object>> readAllHashTag();

	List<String> findSecondAddressListByFirstAddressName(String addr1);

	List<String> findThirdAddressListBySecondAddressName(String addr2);

	List<String> findBusinessDayByCompanyNo(int companyNo);

	void updatStudyRoomCondition(StudyRoomConditionVO studyRoomConditionVO);

	List<StudyRoomConditionVO> findStudyRoomConditionByStudyRoomNo(int studyRoomNo);

	List<StudyRoomVO> findStudyRoomByCompanyNo(int companyNo);

	CompanyVO findCompanyByMemberEmail(String memberEmail);

}
