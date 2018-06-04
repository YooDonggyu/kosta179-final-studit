package org.kosta.studit.model.dao;

import java.util.List;
import java.util.Map;

import org.kosta.studit.model.CompanyPagingBean;
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

	List<CompanyVO> findCompanyByMemberEmail(String memberEmail);
	
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

	int findTotalCountOfCompany(Map<String, Object> map);

	List<CompanyVO> getTopThreeComapny();

	void updateCompanyHit(int companyNo);

	String findCompanyMemberEmailByCompanyNO(int companyNo);

	List<Map<String, String>> findStudyRoomConditionCountByMonth(Map<String, String> map);

	List<Map<String, String>> findWaitStudyRoomConditionCountByCompanyNo(String companyNo);

	List<Map<String, Object>> findHashTagByMemberEmail(String memberEmail);

	List<Map<String, Object>> findDaysByMemberEmail(String memberEmail);

	List<Map<String, String>> findCompanyPicPathByMemberEmail(String memberEmail);

	void updateCompany(CompanyVO companyVO);

	void updateCompanyProfilePath(CompanyVO companyVO);

	void deleteHashtagByCompanyNo(int companyNo);

	void deleteCompanyBusinessDayByCompanyNo(int companyNo);

	int getTotalCompanyCount(String comSrch);

	List<CompanyVO> getCompanyListForAdmin(Map<String, Object> map);

	void updateCompanyCondition(Map<String, Object> map);

	int findCountCompanyPicFileByCompanyNo(int companyNo);

	void deleteCompanyPicFileByCompanyNo(int companyNo);

	void deleteOneCompanyPicFileByCompanyNo(int companyNo);
}
