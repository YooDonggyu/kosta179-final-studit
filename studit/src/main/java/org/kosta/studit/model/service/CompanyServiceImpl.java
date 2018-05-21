package org.kosta.studit.model.service;

import java.util.List;
import java.util.Map;

import org.kosta.studit.model.dao.CompanyDAO;
import org.kosta.studit.model.vo.CompanyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CompanyServiceImpl implements CompanyService {
	@Autowired
	private CompanyDAO companyDAO;
	
	/**
	 * 
	 * 등록이 승인된 업체들의 첫번째 주소를 조회 : 뷰에 셀렉트 박스에 제공될 주소목록
	 * 
	 * @author 송용준
	 * @return List<String> 등록이 승인된 업체들의 첫번째 주소
	 */
	@Override
	public List<String> readFirstAddr() {
		return companyDAO.readFirstAddr();
	}
	
	/**
	 * 
	 * 등록이 승인된 업체 정보들을 조회 : 뷰에 카드 형식으로 표시
	 * 
	 * @author 송용준
	 * @return List<CompanyVO> 등록이 승인된 업체들의 정보
	 */
	@Override
	public List<CompanyVO> readAllCompany() {
		return companyDAO.readAllCompany();
	}
	
	/**
	 * 
	 * 등록이 승인된 업체 정보들의 해쉬태그를 조회
	 * 
	 * @author 송용준
	 * @return List<Map<String, Object>> 등록이 승인된 업체 정보들의 해쉬태그
	 */
	@Override
	public List<Map<String, Object>> readAllHashTag() {
		return companyDAO.readAllHashTag();
	}

}
