package org.kosta.studit.model.service;

import java.util.List;
import java.util.Map;

import org.kosta.studit.model.CompanyPagingBean;
import org.kosta.studit.model.vo.CompanyListVO;
import org.kosta.studit.model.vo.CompanyVO;
import org.kosta.studit.model.vo.StudyRoomVO;

import net.minidev.json.JSONArray;
import net.minidev.json.JSONObject;

public interface CompanyService {

	List<String> readFirstAddr();

	List<CompanyVO> readAllCompany();

	List<Map<String, Object>> readAllHashTag();

	JSONArray findStudyRoomByCompanyNo(int companyNo);

	JSONObject findBusinessDayByCompanyNo(int companyNo);
	
	CompanyListVO findCompanyListByCondition(Map<String, Object> map);
	
	void registerCompany(CompanyVO companyVO, String day, String hashtag, List<String> companyPicFileList);

	Map<String, Object> findDetailCompanyInfoByCompanyNo(int companyNo);
	
	List<CompanyVO> findCompanyList(Map<String, Object> map);
	
	List<CompanyVO> findCompanyList(CompanyPagingBean pb);

	JSONArray findStudyRoomConditionByCompanyNoAndMonth(String companyNo, String startDate, String endDate);
	
	List<StudyRoomVO> findStudyRoomListByCompanyNo(int companyNo);
	
	JSONArray findStudyRoomConditionCountByMonth(String companyNo);

	void updateCompany(CompanyVO companyVO, String day, String hashtag);
}
