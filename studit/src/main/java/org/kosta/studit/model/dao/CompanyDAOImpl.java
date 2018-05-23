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
	   public List<StudyRoomConditionVO> findStudyRoomConditionByStudyRoomNo(int studyRoomNo){
		   return template.selectList("company.findStudyRoomConditionByStudyRoomNo", studyRoomNo);
	   }
	   

	   /**
	    * 스터디룸 예약 정보를 수정하는 메서드
	    * 
	    * @author 김유란
	    * @param studyRoomConditionNo 스터디룸 예약 식별 번호
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


	@Override
	public List<CompanyVO> findCompanyListByAddress(Map<String, String> map) {
		return template.selectList("company.findCompanyListByAddress", map);
	}

}








