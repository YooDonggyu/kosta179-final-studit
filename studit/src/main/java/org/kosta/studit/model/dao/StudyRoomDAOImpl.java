package org.kosta.studit.model.dao;

import java.util.List;
import java.util.Map;

import org.kosta.studit.model.vo.StudyRoomConditionVO;
import org.kosta.studit.model.vo.StudyRoomVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class StudyRoomDAOImpl implements StudyRoomDAO {
	@Autowired
	   private SqlSessionTemplate template;
	   
	   /**
	    * 신청한 스터디룸 중 승인대기중인 스터디룸이 있는가를 확인.
	    * 탈퇴하기 전에 신청한 스터디룸 중 승인대기중인 스터디룸을 처리해야 한다.
	    * @author 송용준
	    * @param memberEmail 회원 이메일
	    * @return 신청한 스터디룸 중 승인대기중인 스터디룸의 개수
	    */
	   @Override
	   public String findWaitStudyRoomByEmail(String memberEmail) {
	      String list=template.selectOne("studyroom.findWaitStudyRoomByEmail", memberEmail);
	      return list;
	   }
	   
	   /**
	    * paging처리를 위한 전체 스터디 룸 신청현황 수를 반환
	    * @author 유동규
	    * @return 전체 스터디룸 신청현황 수
	    */
	   @Override
	   public int findTotalStudyRoomConditionByEmail(String memberEmail) {
		   return template.selectOne("studyroom.findTotalStudyRoomConditionByEmail", memberEmail);
	   }
	   /**
	    * 사용자에 따른 스터디 룸 신청현황을 반환
	    * @author 유동규
	    * @param memberEmail 현황을 조회할 사용자 Email
	    * @return List<StudyRoomConditionVO> 스터디 룸 신청현황이 담긴 객체
	    */
	   @Override
	   public List<StudyRoomConditionVO> findStudyConditionByEmail(Map<String, Object> map){
		   return template.selectList("studyroom.findStudyConditionByEmail", map);
	   }
	   
	   /**
	    * 스터디룸 번호로 스터디 룸 정보 조회
	    * @author 김유란
	    * @param studyRoomNo 스터디룸 번호
	    * @return studyRoomVO 스터디룸 정보를 담은 VO
	    */
	   @Override
	   public StudyRoomVO findStudyRoomInfoByStudyRoomNo(String studyRoomNo) {
		   return template.selectOne("studyroom.findStudyRoomInfoByStudyRoomNo", studyRoomNo);
	   }
	   
	   /**
	    * 업체 등록 시 입력된 스터디룸 정보를 등록하는 메서드
	    * 
	    * @author 변태섭
	    * @param studyRoomVO
	    */
	   @Override
	   public void registerStudyRoom(StudyRoomVO studyRoomVO) {
		   template.insert("studyroom.registerStudyRoom", studyRoomVO);
	   }
	   
	   /**
	    * 스터디룸 등록 시 업로드 된 사진들의 경로를 등록하는 메서드
	    * @author 변태섭
	    * @param Map 사진의 경로와 해당 스터디룸 번호를 담은 객체
	    */
	   @Override
	   public void registerStudyRoomPicPath(Map<String, Object> map) {
		   template.insert("studyroom.registerStudyRoomPicPath", map);
	   }
	   
	   /**
	    * 스터디룸 등록 시 이용 기능들을 등록하는 메서드
	    * @author 변태섭
	    * @param Map 스터디룸 번호와 기능명을 담은 객체
 	    */
	   @Override
	   public void registerStudyRoomFunction(Map<String, Object> map) {
		   template.insert("studyroom.registerStudyRoomFunction", map);
	   }

		/**
		 * 스터디룸 번호와 날짜로 예약현황 조회
		 * @author 김유란
		 * @param studyRoomConditionVO 스터디룸 번호와 사용일자 정보를 담은 VO
		 * @return List<studyRoomConditionVO> 스터디룸 예약 정보를 담은 VO 리스트
		 */
	   @Override
	   public List<StudyRoomConditionVO> findStudyRoomConditionByStudyRoomNoAndDate(StudyRoomConditionVO studyRoomConditionVO) {
		   return template.selectList("studyroom.findStudyRoomConditionByStudyRoomNoAndDate", studyRoomConditionVO);
	   }
	   
	   /**
	    * 스터디룸 예약 메서드
	    * @author 김유란
	    * @param studyRoomConditionVO 스터디룸 예약 정보 담은 VO
	    */
		@Override
		public void createStudyRoomCondition(StudyRoomConditionVO studyRoomConditionVO) {
			template.insert("studyroom.createStudyRoomCondition", studyRoomConditionVO);
			
		}

	  /**
	    * 업체 번호에 따른 스터디룸 정보 반환
	    * @author 유동규
	    * @param companyNo 업체번호
	    * @return List<StudyRoomVO> 스터디룸 정보가 담긴 객체 list
	    */
	   @Override
	   public List<StudyRoomVO>findStudyRoomInfoByCompanyNo(int companyNo){
		   return template.selectList("studyroom.findStudyRoomInfoByCompanyNo", companyNo);
	   }
	   /**
	    * 업체 번호에 따른 스터디룸 사진 정보 반환
	    * @author 유동규
	    * @param companyNo 업체번호
	    * @return List<Map<String, Object>> 스터디룸 사진 정보가 담긴 map list
	    */
	   @Override
	   public List<Map<String, Object>> findStudyRoomPicByCompanyNo(int companyNo){
		   return template.selectList("studyroom.findStudyRoomPicByCompanyNo", companyNo);
	   }
	   /**
	    * 업체 번호에 따른 스터디룸 기능 정보 반환
	    * @author 유동규
	    * @param companyNo 업체번호
	    * @return List<Map<String, Object>> 스터디룸 기능 정보가 담긴 map list
	    */
	   @Override
	   public List<Map<String, Object>> findstudyroomFunctionByCompanyNo(int companyNo){
		   return template.selectList("studyroom.findstudyroomFunctionByCompanyNo", companyNo);
	   }
	   
	   /**
	    * 스터디룸 신청 취소(데이터 유지하되 state를 '예약취소'로 변경)
	    * @author 김유란
	    * @param studyRoomConditionVO 신청번호와 회원이메일 정보를 담은 VO
	    */
	   @Override
	   public void updateStudyRoomConditionByMember(StudyRoomConditionVO studyRoomConditionVO) {
		   template.update("studyroom.updateStudyRoomConditionByMember", studyRoomConditionVO);
	   }

	   /**
	    * 회원 이메일로 해당 회원의 스터디룸 정보리스트를 얻어오는 메서드
	    * 
	    * @author 변태섭
	    * @param memberEmail 회원 이메일
	    * @return List<StudyRoomVO> 해당 회원이 보유한 스터디룸 리스트
	    */
	   @Override
	   public List<StudyRoomVO> findStudyRoomListByMemberEmail(String memberEmail){
		   return template.selectList("studyroom.findStudyRoomListByMemberEmail", memberEmail);
	   }
	   
	   /**
	    * 회원 이메일로 해당 회원이 등록한 스터디룸의 사진 경로를 받아오는 메서드
	    * @author 변태섭
	    * @param memberEmail	회원 이메일
	    * @return 해당 회원이 등록한 스터디룸 사진 경로가 담긴 List 객체
	    */
	   @Override
	   public List<Map<String, String>> findStudyRoomPicPathByMemberEmail(String memberEmail){
		   return template.selectList("studyroom.findStudyRoomPicPathByMemberEmail", memberEmail);
	   }
	   
	   /**
	    * 회원 이메일로 해당 회원이 등록한 스터디룸의 제공 기능을 받아오는 메서드
	    * @author 변태섭
	    * @param memberEmail 회원 이메일
	    * @return 해당 회원이 등록한 스터디룸 제공 기능이 담긴 List 객체
	    */
	   @Override
	   public List<Map<String, String>> findStudyRoomFunctionByMemberEmail(String memberEmail){
		   return template.selectList("studyroom.findStudyRoomFunctionByMemberEmail", memberEmail);
	   }
	   
	   /**
	    * 스터디룸 번호로 해당 스터디룸의 제공 기능 리스트를 받아오는 쿼리
	    * @param studyRoomNo 스터디룸 번호
	    * @return 해당 스터디룸의 제공 기능 리스트
	    */
	   @Override
	   public List<String> findStudyRoomFunctionByStudyRoomNo(int studyRoomNo){
		   return template.selectList("studyroom.findStudyRoomFunctionByStudyRoomNo", studyRoomNo);
	   }
	   
	   /**
	    * 해당 스터디룸의 모든 제공 기능을 삭제하는 메서드
	    * @author 변태섭
	    * @param studyRoomNo 스터디룸 번호
	    */
	   @Override
	   public void deleteStudyRoomFunctionByStudyRoomNo(int studyRoomNo) {
		   template.delete("studyroom.deleteStudyRoomFunctionByStudyRoomNo", studyRoomNo);
	   }
	   
	   /**
	    * 해당 스터디룸의 모든 사진을 삭제하는 메서드
	    * @author 변태섭
	    * @param
	    */
	   @Override
	   public void deleteStudyRoomPicFileByStudyRoomNo(int studyRoomNo) {
		   template.delete("studyroom.deleteStudyRoomPicFileByStudyRoomNo", studyRoomNo);
	   }
	   
	   /**
	    * 해당 스터디룸의 사진을 변경하는 메서드
	    * @author 변태섭
	    * @param Map 스터디룸 번호와 사진 경로를 담은 객체
	    */
	   @Override
	   public void updateStudyRoomPicFile(Map<String, Object> map) {
		   template.update("studyroom.updateStudyRoomPicFile", map);
	   }
	   
	   /**
	    * 스터디룸 정보를 수정하는 메서드
	    * @author 변태섭
	    * @param studyRoomVO
	    */
	   @Override
	   public void updateStudyRoom(StudyRoomVO studyRoomVO) {
		   template.update("studyroom.updateStudyRoom", studyRoomVO);
	   }
}
