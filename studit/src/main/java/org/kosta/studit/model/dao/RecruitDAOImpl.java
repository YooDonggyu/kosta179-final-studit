
package org.kosta.studit.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.studit.model.PagingBean;
import org.kosta.studit.model.vo.BigCategoryVO;
import org.kosta.studit.model.vo.GroupMemberVO;
import org.kosta.studit.model.vo.RecruitPostCommentVO;
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
	 * map에 들어있는정보는 게시판번호,멤버 이메일,자기소개
	 * @author 이승수
	 */
	@Override
	public void registerRecruitStudy(HashMap<String, Object> map) {
		template.insert("recruit.registerRecruitStudy",map);
	}
	
	/**
	 * 게시판번호로 스터디그룹멤버를 찾는 메소드
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
	  * @author 김유란
	  * @param pagingBean
	  * @return List<RecruitPostVO> 전체 모집글 목록
  	  */
	@Override
	public List<RecruitPostVO> getRecruitPostList(PagingBean pagingBean){
		return template.selectList("recruit.getRecruitPostList", pagingBean);
	}
	
	   /**
	    * 모집 게시글 번호에 따른 모집 게시글 내용과 카테고리(소, 대)를 검색 
	    * @author 유동규
	    * @param recruitNo 조회할 모집 게시글 번호
	    * @return recruitVO 모집 게시글 객체 반환
	    */
	   @Override
	   public RecruitPostVO findDetailRecruitPostAndCategoryByRecruitNo(int recruitNo) {
		   return template.selectOne("recruit.findDetailRecruitPostAndCategoryByRecruitNo", recruitNo);
	   }
	   /**
	    * 모집 게시글에서 희망한 모집 요일들을 반환
	    * @author 유동규
	    * @param recruitNo 요일을 구할 모집 게시글 번호
	    * @return day list안에 요일을 담아 반환
	    */
	   @Override
	   public List<String> findDayByRecruitNo(int recruitNo){
		   return template.selectList("recruit.findDayByRecruitNo", recruitNo);
	   }
	   /**
	    * 모집 게시글 번호에 따른 댓글을 조회
	    * @author 유동규
	    * @param recruitNo 조회할 모집 게시글 번호
	    * @return List<RecruitPostCommentVO> 댓글을 list형태로 반환
	    */
	   @Override
	   public List<RecruitPostCommentVO> findRecruitCommentByRecruitNo(int recruitNo) {
		   return template.selectList("recruit.findRecruitCommentByRecruitNo", recruitNo);
	   }
	   
	   
	   @Override
	   public void updateRecruitPostHitByRecruitNo(int recruitNo) {
		   template.update("recruit.updateRecruitPostHitByRecruitNo", recruitNo);
	   }
	   /**
	    * 모집 게시글 번호에 따른 작성자 찾는 메서드
	    * @author 유동규
	    * @param recruitNo 조회할 모집 게시글 번호
	    * @return name 작성자 이름 반환
	    */
	@Override
	public String findRecruitWriterByRecruitNo(int recruitNo) {
		return template.selectOne("recruit.findRecruitWriterByRecruitNo", recruitNo);
	}
	
	/**
	 * 모집 게시글 번화와 이메일로 회원 신청 상태를 찾는 메서드
	 * @author 유동규
	 * @param member_email study_condition에서 찾을 회원 이메일
	 * @param recruit_post_no study_condition에서 찾을 모집 게시글 번호
	 * @return state 이메일과 모집 게시글 번호에 해당하는 상태 반환
	 */
	@Override
	  public String findStudyConditionStateByEmailAndRecruitNo(Map<String, Object> map) {
		  return template.selectOne("recruit.findStudyConditionStateByEmailAndRecruitNo", map);
	  }
	
	/**
	 * 모집 게시글 번호에 따른 카테고리 수정
	 * @author 유동규
	 * @param map-recruitNo 수정할 모집 게시글 번호
	 * @param map-smallCategoryNo 수정될 소분류 카테고리 번호
	 */
	@Override
	public void updateSmallCategoryNoByRecruitNo(Map<String, Integer> map) {
		template.update("recruit.updateSmallCategoryNoByRecruitNo", map);
	}
	
	/**
	 * 모집 게시글 번호에 따른 상세정보 수정
	 * @author 유동규
	 * @param recruitPostVO 수정할 정보가 담긴 객체
	 */
	@Override
	public void updateRecruitPostByRecruitNo(RecruitPostVO recruitPostVO) {
		template.update("recruit.updateRecruitPostByRecruitNo", recruitPostVO);
	}
	
	/**
	 * 모집 게시글 번호에 따른 요일들 삭제.
	 * 삭제 후 다시 등록하는 로직을 위해 먼제 삭제할 때 사용
	 * @author 유동규
	 */
	@Override
	public void deleteDayByRecruitNo(int recruitNo) {
		template.delete("recruit.deleteDayByRecruitNo", recruitNo);
	}
	
	/**
	 * 모집게시글 번호에 따른 상태변경(모집중->삭제).
	 * @author 유동규
	 */
	@Override
	public void updateDeleteStudyConditionByRecruitNo(int recruitNo) {
		template.update("recruit.updateDeleteStudyConditionByRecruitNo", recruitNo);
	}
	
	
	@Override
	public void registerCommentByRecruitNo(Map<String, Object> map) {
		template.insert("recruit.registerCommentByRecruitNo", map);
	}
	
	/**
	 * 모집글을 작성하는 메서드.
	 * @author 송용준
	 * @param RecruitPostVO 등록할 모집글의 정보를 담은 객체
	 */
	@Override
	public void createRecruitPost(RecruitPostVO recruitPostVO) {
		template.insert("recruit.createRecruitPost", recruitPostVO);
	}
	
	/**
	 * 등록할 모집글의 요일을 등록하는 메서드.
	 * @author 송용준
	 * @param HashMap<String, Object> map 등록할 요일을 담은 객체
	 */
	@Override
	public void registerRecruitDay(Map<String, Object> map) {
		template.insert("recruit.registerRecruitDay", map);
	}
}




