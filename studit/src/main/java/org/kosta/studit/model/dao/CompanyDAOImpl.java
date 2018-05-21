package org.kosta.studit.model.dao;

import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.CompanyVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CompanyDAOImpl implements CompanyDAO {
	@Autowired
	private SqlSessionTemplate template;

	/**
	 * 승인대기중인 예약이 있는가를 확인. 업체라면, 탈퇴하기 전에 승인대기중인 예약건수를 처리해야 한다.
	 * 
	 * @author 송용준
	 * @param memberEmail
	 *            회원 이메일
	 * @return 승인대기중인 예약의 개수
	 */
	@Override
	public String findWaitReservationByEmail(String memberEmail) {
		return template.selectOne("company.findWaitReservationByEmail", memberEmail);
	}
	
	/**
	 * select box에 제공할 모든 업체의 addr1 값을 불러온다
	 * 
	 * @author 송용준
	 * @return 모든 업체의 addr1 값
	 */
	@Override
	public List<String> readFirstAddr() {
		return template.selectList("company.readFirstAddr");
	}
	
	/**
	 * 등록이 승인된 모든 업체 정보를 불러온다
	 * 
	 * @author 송용준
	 * @return 모든 업체 정보
	 */
	@Override
	public List<CompanyVO> readAllCompany() {
		return template.selectList("company.readAllCompany");
	}
	
	/**
	 * 등록이 승인된 모든 업체의 해쉬태그 정보를 불러온다
	 * 
	 * @author 송용준
	 * @return 모든 해쉬태그 정보
	 */
	@Override
	public List<Map<String, Object>> readAllHashTag() {
		return template.selectList("company.readAllHashTag");
	}
	
	/**
	 * 스터디룸(업체) 검색 뷰에서 선택된 addr1에 대응되는 addr2를 조회.
	 * 
	 * @author 송용준
	 * @param addr1 뷰에서 선택된 첫번째 주소값
	 * @return List<String> 조회한 addr2 리스트를 담은 객체
	 */
	@Override
	public List<String> findSecondAddressListByFirstAddressName(String addr1) {
		return template.selectList("company.findSecondAddressListByFirstAddressName", addr1);
	}
	
	/**
	 * 스터디룸(업체) 검색 뷰에서 선택된 addr2에 대응되는 addr3를 조회.
	 * 
	 * @author 송용준
	 * @param addr2 뷰에서 선택된 두번째 주소값
	 * @return List<String> 조회한 addr3 리스트를 담은 객체
	 */
	@Override
	public List<String> findThirdAddressListBySecondAddressName(String addr2) {
		return template.selectList("company.findThirdAddressListBySecondAddressName", addr2);
	}
}








