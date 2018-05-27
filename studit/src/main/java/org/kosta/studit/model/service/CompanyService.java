package org.kosta.studit.model.service;

import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.CompanyVO;

import net.minidev.json.JSONArray;
import net.minidev.json.JSONObject;

public interface CompanyService {

	List<String> readFirstAddr();

	List<CompanyVO> readAllCompany();

	List<Map<String, Object>> readAllHashTag();

	JSONArray findStudyRoomConditionByMemberEmail(String memberEmail);

	JSONArray findStudyRoomByMemberEmail(String memberEmail);

	JSONObject findBusinessDayByCompanyNo(int companyNo);

	JSONObject findBusinessDayByMemberEmail(String memberEmail);
	
	List<CompanyVO> findCompanyListByAddress(Map<String, String> map);
	
	void registerCompany(CompanyVO companyVO, String day, String hashtag, List<String> companyPicFileList);

	Map<String, Object> findDetailCompanyInfoByCompanyNo(int companyNo);

}
