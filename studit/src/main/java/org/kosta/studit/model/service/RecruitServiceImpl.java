package org.kosta.studit.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.studit.model.PagingBean;
import org.kosta.studit.model.dao.RecruitDAO;
import org.kosta.studit.model.vo.RecruitPostListVO;
import org.kosta.studit.model.vo.StudyConditionListVO;
import org.kosta.studit.model.vo.StudyConditionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RecruitServiceImpl implements RecruitService {
	@Autowired
	private RecruitDAO recruitDAO;
	
	/**
	 * 스터디 현황 조회 시 내역 list를 불러온다.
	 * 
	 * @author 변태섭
	 * @param String 회원 Email
	 * @return StudyConditionVO 스터디 현황 내역 list
	 */
	@Override
	public StudyConditionListVO findStudyConditionByMemberEmail(String memberEmail, String pageNo) {
		PagingBean pb=null;
		if(pageNo==null) {
			pb = new PagingBean(recruitDAO.findCountStudyConditionByMemberEmail(memberEmail));
		}else {
			pb = new PagingBean(recruitDAO.findCountStudyConditionByMemberEmail(memberEmail), Integer.parseInt(pageNo));
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberEmail", memberEmail);
		map.put("pb", pb);
		
		List<StudyConditionVO> list = recruitDAO.findStudyConditionByMemberEmail(map);
		
		StudyConditionListVO studyConditionListVO = new StudyConditionListVO(list, pb);
		
		return studyConditionListVO;
	}

	/**
	 * 스터디를 신청할떄 사용하는 메서드.
	 * 
	 * 스터디게시글번호,회원이메일,자기소개내용을 받아 Map에 저장해서 DAO에 전달
	 * 
	 * @author 이승수
     * @param 스터디게시글번호,회원이메일,자기소개내용
	 */
	@Override
	public void registerRecruitStudy(int recruitPostNo, String memberEmail, String context) {
			HashMap<String,Object> map = new HashMap<String,Object>();
			map.put("recruitPostNo", recruitPostNo);
			map.put("memberEmail", memberEmail);
			map.put("context", context);
			recruitDAO.registerRecruitStudy(map);
	}
	
	/**
	 * 스터디를 신청할떄 사용하는 메서드.
	 * 
	 * 스터디신청시 이미 거절상태일때 다시 미승인 상태로 바꿔주는 메서드.
	 * 
	 * @author 이승수
     * @param 스터디게시글번호,회원이메일,자기소개내용
	 */
	@Override
	public void updateRecruitStudy(int recruitPostNo, String memberEmail, String context) {
			HashMap<String,Object> map = new HashMap<String,Object>();
			map.put("recruitPostNo", recruitPostNo);
			map.put("memberEmail", memberEmail);
			map.put("context", context);
			recruitDAO.updateRecruitStudy(map);
	}
	
	 /**
	    * 
	       * 전체 모집글 목록을 불러오기 위한 메서드
	       *  전체 모집글 목록을 페이징 처리하여 받아온 후 pagingBean과 함께 담아 넘겨준다.
	       * 
	       * @author 김유란
	       * @param pagingBean
	       * @return List<RecruitPostVO> 전체 모집글 목록
	    */
	@Override
	public RecruitPostListVO getRecruitPostList(String pageNo){
		int totalCount = recruitDAO.getTotalRecruitPostCount();
		PagingBean pagingBean = null;
		if(pageNo==null) {
			pagingBean = new PagingBean(totalCount);
		}else {
			pagingBean = new PagingBean(totalCount, Integer.parseInt(pageNo));
		}
		return new RecruitPostListVO(pagingBean, recruitDAO.getRecruitPostList(pagingBean));
	}
	
	 /**
	    * 
	       * 모집글 검색 결과 목록을 불러오기 위한 메서드
	       * Controller에게 선택된  카테고리와 키워드, 페이지넘버를 전달받아 map객체에 담은 후
	       * 소분류와 키워드로 검색된 모집글 pagingBean과 함께 넘겨준다.
	       * 검색 키워드는 글 제목, 내용, 지역 컬럼을 검색한다.
	       * @param category[] 체크박스로 선택한 소분류값을 담은 배열 
	       * @param keyword 사용자가 입력한 검색어
	       * @param pageNo 검색결과 목록 페이지 번호
	       * @author 김유란
	       * @return List<RecruitPostVO> 검색된 모집글 목록
	    */
	@Override
	public RecruitPostListVO findRecruitPostByCategoryAndKeyword(String category[], String keyword, String pageNo){
		
		Map<String, Object> map = new HashMap<>();
		if(category!=null) {
			List<String> list = new ArrayList<>();
			for(int i=0; i<category.length; i++) {
				System.out.println(category[i]);
				list.add(category[i]);
			}
			map.put("category", list);
		}
		map.put("keyword", keyword);
		
		int totalCount = recruitDAO.findRecruitPostCountByCategoryAndKeyword(map);
		PagingBean pagingBean = null;
		if(pageNo==null) {
			pagingBean = new PagingBean(totalCount);
		}else {
			pagingBean = new PagingBean(totalCount, Integer.parseInt(pageNo));
		}
		map.put("pagingBean", pagingBean);
		return new RecruitPostListVO(pagingBean, recruitDAO.findRecruitPostByCategoryAndKeyword(map));
	}

}
