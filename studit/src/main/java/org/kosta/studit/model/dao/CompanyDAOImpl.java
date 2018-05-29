package org.kosta.studit.model.dao;

import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.CompanyVO;
import org.kosta.studit.model.vo.StudyRoomConditionVO;
import org.kosta.studit.model.vo.StudyRoomVO;
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
	
	/**
    * 스터디룸(업체) 검색조건에 대응되는 업체 리스트를 조회.
    * 검색조건으로 조회한 업체 리스트을 List<CompanyVO> 타입으로 반환받는다.
    * @author 송용준
    * @param Map<String, Object> map 검색조건을 가지고 있는 객체
    * @return List<CompanyVO> 검색조건에 대응되는 업체 리스트
    */
	@Override
	public List<CompanyVO> findCompanyListByCondition(Map<String, Object> map) {
		return template.selectList("company.findCompanyListByCondition", map);
	}
		
	   /**
	    * 회원 이메일로 업체 정보 불러오기
	    * 업체권한을 가진 회원인지 인증한 후 사용
	    * @author 김유란
	    * @param memberEmail 회원 이메일
	    * @return CompanyVO 업체 정보를 담은 VO
	    */
	   @Override
	   public CompanyVO findCompanyByMemberEmail(String memberEmail) {
		   return template.selectOne("company.findCompanyByMemberEmail", memberEmail);
	   }
	   
	   /**
	    * 업체 번호로 스터디룸 정보 불러오기
	    * 업체가 보유한 스터디룸 목록을 조회한다.
	    * @author 김유란
	    * @param companyNo 업체 식별 번호
	    * @return List<StudyRoomVO> 스터디룸 객체를 담은 리스트
	    */
	   @Override
	   public List<StudyRoomVO> findStudyRoomByCompanyNo(int companyNo) {
		   return template.selectList("company.findStudyRoomByCompanyNo", companyNo);
	   }
	   
	   /**
	    * 스터디룸 번호로 스터디룸 예약현황 정보 불러오기
	    * 회원이메일이 아닌 스터디룸 번호로 조회하므로 업체 예약 관리, 스터디룸 예약 등에 사용 가능
	    * @author 김유란
	    * @param studyRoomNo 업체 식별 번호
	    * @return List<StudyRoomConditionVO> 스터디룸 예약정보 객체를 담은 리스트
	    */
	   @Override
	   public List<StudyRoomConditionVO> findStudyRoomConditionByCompanyNoAndMonth(Map<String,String> map){
		   return template.selectList("company.findStudyRoomConditionByCompanyNoAndMonth", map);
	   }
	   

	   /**
	    * 스터디룸 예약 정보를 수정하는 메서드
	    * 
	    * @author 김유란
	    * @param studyRoomConditionVO 스터디룸 예약 정보 담은 VO
	    */
	   @Override
	   public void updatStudyRoomCondition(StudyRoomConditionVO studyRoomConditionVO) {
		   template.update("company.updatStudyRoomCondition", studyRoomConditionVO);
	   }
	   
	   /**
	    * 업체 영업일 조회
	    * 업체 번호로 조회한 영업 요일을 List<String> 타입으로 반환받는다.
	    * @author 김유란
	    * @param studyRoomNo 업체 식별 번호
	    * @return List<StudyRoomConditionVO> 스터디룸 예약정보 객체를 담은 리스트
	    */
	   @Override
	   public List<String> findBusinessDayByCompanyNo(int companyNo) {
		   return template.selectList("company.findBusinessDayByCompanyNo", companyNo); 
	   }

	   /**
	    * 업체 등록 시 해시태그를 등록하는 메서드
	    * 
	    * @author 변태섭
	    * @param Map 업체 번호와 해시태그들을 담은 맵
	    */
	   @Override
	   public void registerHashtag(Map<String, Object> map) {
		   template.insert("company.registerHashtag", map);
	   }
	   
	   /**
	    * 업체 등록 시 영업 요일을 등록하는 메서드
	    * 
	    * @author 변태섭
	    * @param Map 업체 번호와 영업 요일을 담은 맵
	    */
	   @Override
	   public void registerBusinessDay(Map<String, Object> map) {
		   template.insert("company.registerBusinessDay", map);
	   }
	  
	   /**
	    * 업체 등록 시 입력된 데이터를 업체 테이블에 등록하는 메서드
	    * 
	    * @author 변태섭
	    * @param Map 입력된 업체 정보와 해당 회원 이메일을 담은 맵
	    */
	   @Override
	   public void registerCompany(CompanyVO companyVO) {
		   template.insert("company.registerCompany", companyVO);
	   }
	   
	   /**
	    * 업체 등록 시 업로드 된 사진들의 경로를 등록하는 메서드
	    * 
	    * @author 변태섭
	    * @param Map 사진의 경로와 해당 업체 번호를 담은 객체
	    */
	   @Override
	   public void registerCompanyPicPath(Map<String, Object> map) {
		   template.insert("company.registerCompanyPicPath", map);
	   }
	   
	   /**
	    * 사업자 등록 번호 중복 체크를 위해 Count를 받아오는 메서드
	    * 
	    * @author 변태섭
	    * @param license 입력된 사업자 등록 번호
	    * @return 입력된 사업자 등록번호로 조회되는 데이터의 개수
	    */
	   @Override
	   public int findCountCompanyByLicense(String license) {
		   return template.selectOne("company.findCountCompanyByLicense", license);
	   }
	   
	   
	   /**
	    * 업체 번호에 따른 업체 정보 반환
	    * @author 유동규
	    * @param companyNo 업체 번호
	    * @return companyVO 업체 정보가 담긴 객체
	    */
	   @Override
	   public CompanyVO findCompanyByCompanyNo(int companyNo) {
		   return template.selectOne("company.findCompanyByCompanyNo", companyNo);
	   }
	   /**
	    * 업체 번호에 따른 업체 사진 반환
	    * @author 유동규
	    * @param companyNo 업체 번호
	    * @return List<Map<String, Object>> 업체 사진 정보가 담긴 list
	    */
	   @Override
	   public List<Map<String, Object>> findComPicByCompanyNo(int companyNo){
		   return template.selectList("company.findComPicByCompanyNo", companyNo);
	   }
	   
	   /**
	    * 업체 번호에 따른 해시태그 반환
	    * @author 유동규
	    * @param companyNo 업체 번호
	    * @return List<Map<String, Object>> 업체 사진 해시태그가 담긴 list
	    */
	   @Override
	   public List<Map<String, Object>> findHashTagByCompanyNo(int companyNo){
		   return template.selectList("company.findHashTagByCompanyNo", companyNo);
	   }

	   /**
	    * 월별 스터디룸 예약 통계 조회
	    * @author 김유란
	    * @param companyNo 업체 식별 번호
	    * @return List<Map<String,String>> 스터디룸 예약 통계 정보를 담은 list(m, count) 
	    */
	   @Override
	   public List<Map<String, String>> findStudyRoomConditionCountByMonth(String companyNo){
		   return template.selectList("company.findStudyRoomConditionCountByMonth",companyNo);
	   }
	   
	   /**
	    * 검색조건에 부합하는 총 업체 리스트 수를 조회
	    * @author 송용준
	    * @param Map<String, Object> map 검색 조건을 담은 객체
	    * @return int 업체 리스트 수  
	    */
		@Override
		public int findTotalCountOfCompany(Map<String, Object> map) {
			return template.selectOne("company.findTotalCountOfCompany", map);
		}
	   
	   
}








