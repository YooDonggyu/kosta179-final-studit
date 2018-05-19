
package org.kosta.studit.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.studit.model.PagingBean;
import org.kosta.studit.model.vo.BigCategoryVO;
import org.kosta.studit.model.vo.GroupMemberVO;
import org.kosta.studit.model.vo.RecruitPostVO;
import org.kosta.studit.model.vo.SmallCategoryVO;
import org.kosta.studit.model.vo.StudyConditionVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RecruitDAOImpl implements RecruitDAO {
	@Autowired
	SqlSessionTemplate template;
	
	/**
	 * 신청한 스터디 중 승인대기중인 스터디가 있는가를 확인.
	 * 탈퇴하기 전에 신청한 스터디 중 승인대기중인 스터디를 처리해야 한다.
	 * @author 송용준
	 * @param memberEmail 회원 이메일
	 * @return 신청한 스터디 중 승인대기중인 스터디의 개수
	 */
	@Override
	public String findWaitStudyByEmail(String memberEmail) {
		return template.selectOne("recruit.findWaitStudyByEmail", memberEmail);
	}
	
	/**
	 * 스터디 현황 조회 시 내역 list를 불러온다.
	 * 
	 * @author 변태섭
	 * @param String 회원 Email
	 * @return StudyConditionVO 스터디 현황 내역 list
	 */
	@Override
	public List<StudyConditionVO> findStudyConditionByMemberEmail(Map<String, Object> map){
			return template.selectList("recruit.findStudyConditionByMemberEmail", map);
	}
	
	/**
	 * 스터디 내역 개수를 가져온다.
	 * 
	 * @author 변태섭
	 * @param String 회원 Email
	 * @return int 스터디 내역 개수
	 */
	@Override
	public int findCountStudyConditionByMemberEmail(String memberEmail) {
		return template.selectOne("recruit.findCountStudyConditionByMemberEmail", memberEmail);
	}

	
	/**
	 * 스터디 신청 메소드
	 * 
	 * map에 들어있는정보는 게시판번호,멤버 이메일,자기소개
	 * 
	 * @author 이승수
	 */
	@Override
	public void registerRecruitStudy(HashMap<String, Object> map) {
		template.insert("recruit.registerRecruitStudy",map);
	}
	
	/**
	 * 게시판번호로 스터디그룹멤버를 찾는 메소드
	 * 
	 * 스터디그룹에 멤버를 찾아서 스터디신청시 예외사항판단에 사용한다.
	 * 
	 * @author 이승수
	 */
	@Override
	public GroupMemberVO findGroupMemberByRecruitPostNo(int recruitPostNo) {
		GroupMemberVO gmVO = template.selectOne("recruit.findGroupMemberByRecruitPostNo", recruitPostNo);
		return gmVO;
	}
	
	@Override
    public int findStudyConditionCountByEmailAndRecruitNo(HashMap<String, Object> map) {
       return template.selectOne("recruit.findStudyConditionCountByEmailAndRecruitNo", map);
    }
	
	
	/**
	 *  스터디 신청시 사용하는 메서드.
	 *  
	 *  스터디 신청시 거절당했던 회원이 다시신청했을때 상태를 미승인 상태로 업데이트해주는 메서드
	 *  @author 이승수
	 */
	@Override
	public void updateRecruitStudy(HashMap<String, Object> map) {
		template.update("recruit.updateRecruitStudy",map);
	}
	
	  /**
	    * 
	       * 스터디 대분류 목록 가져오기
	       * 
	       * @author 김유란
	       * @return List<BigCategoryVO> 대분류 전체 항목을 List에 담아 반환
	    */
	@Override
	public List<BigCategoryVO> getBigCategoryList(){
		return template.selectList("recruit.getBigCategoryList");
	}
	
	   /**
	    * 
	       * 스터디 소분류 목록 가져오기
	       * 대분류 번호로 검색하여 소분류 목록을 가져오는 메서드
	       * @author 김유란
	       * @param bigCategoryNo 사용자가 선택한 대분류 번호
	       * @return List<SmallCategoryVO> 검색된 소분류 항목을 List에 담아 반환
	    */
	@Override
	public List<SmallCategoryVO> findSmallCategoryListByBigCategoryNo(String bigCategoryNo){
		return template.selectList("recruit.findSmallCategoryListByBigCategoryNo", bigCategoryNo);
	}
	
	 /**
	    * 
	       * 모집글 검색 결과 수 가져오기
	       * 카테고리와 키워드로 검색한 모집글 수를 계산하여 가져오는 메서드.
	       * 검색결과 목록을 페이징 처리하기 위해 필요
	       * 
	       * @author 김유란
	       * @param map 사용자가 입력한 검색조건(keyword, category list)을 담은 map
	       * @return int 검색된 모집글 개수
	    */
	@Override
	public int findRecruitPostCountByCategoryAndKeyword(Map<String, Object> map) {
		return template.selectOne("recruit.findRecruitPostCountByCategoryAndKeyword", map);
	}
	
	   /**
	    * 
	       * 검색 목록 가져오기
	       * 소분류와 검색 키워드로 모집글을 검색하여 페이징 처리 후 반환하는 메서드
	       * 검색 키워드는 글 제목, 내용, 지역 컬럼을 검색한다.
	       * @param Map<String, Object> category와 keyword(list), PagingBean을 담은 map
	       * @author 김유란
	       * @return List<RecruitPostVO> 검색된 모집글 목록
	    */
	@Override
	public List<RecruitPostVO> findRecruitPostByCategoryAndKeyword(Map<String, Object> map){
		return template.selectList("recruit.findRecruitPostByCategoryAndKeyword", map);
	}
	
	 /**
	    * 
	       * 전체 모집글 수 가져오기
	       * 전체 모집글 목록을 페이징 처리하기 위해 필요
	       * 
	       * @author 김유란
	       * @return int 전체 모집글 개수
	    */
	@Override
	public int getTotalRecruitPostCount() {
		return template.selectOne("recruit.getTotalRecruitPostCount");
	}
	
	 /**
	    * 
	       * 전체 모집글을 페이징 처리하여 가져오기
	       * 
	       * @author 김유란
	       * @param pagingBean
	       * @return List<RecruitPostVO> 전체 모집글 목록
	    */
	@Override
	public List<RecruitPostVO> getRecruitPostList(PagingBean pagingBean){
		return template.selectList("recruit.getRecruitPostList", pagingBean);
	}


}
