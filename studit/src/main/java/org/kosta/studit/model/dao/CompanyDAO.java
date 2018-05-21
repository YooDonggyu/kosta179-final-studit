package org.kosta.studit.model.dao;

import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.CompanyVO;

public interface CompanyDAO {

	String findWaitReservationByEmail(String memberEmail);

	List<String> readFirstAddr();

	List<CompanyVO> readAllCompany();

	List<Map<String, Object>> readAllHashTag();

	List<String> findSecondAddressListByFirstAddressName(String addr1);

	List<String> findThirdAddressListBySecondAddressName(String addr2);

}
