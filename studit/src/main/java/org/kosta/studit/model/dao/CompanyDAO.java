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

	List<StudyRoomVO> findStudyRoomByCompanyNo(int companyNo);

	CompanyVO findCompanyByMemberEmail(String memberEmail);
	
	List<CompanyVO> findCompanyListByCondition(Map<String, Object> map);
	
	void registerHashtag(Map<String, Object> map);

	void registerBusinessDay(Map<String, Object> map);

	void registerCompany(CompanyVO companyVO);

	void registerCompanyPicPath(Map<String, Object> map);

	int findCountCompanyByLicense(String license);

	CompanyVO findCompanyByCompanyNo(int companyNo);

	List<Map<String, Object>> findComPicByCompanyNo(int companyNo);

	List<Map<String, Object>> findHashTagByCompanyNo(int companyNo);

	List<StudyRoomConditionVO> findStudyRoomConditionByCompanyNoAndMonth(Map<String, String> map);

	List<Map<String, String>> findStudyRoomConditionCountByMonth(String companyNo);
	
	int findTotalCountOfCompany(Map<String, Object> map);
}
