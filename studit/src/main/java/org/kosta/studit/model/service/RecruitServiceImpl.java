package org.kosta.studit.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.studit.model.PagingBean;
import org.kosta.studit.model.dao.GroupDAO;
import org.kosta.studit.model.dao.RecruitDAO;
import org.kosta.studit.model.vo.BigCategoryVO;
import org.kosta.studit.model.vo.RecruitPostCommentVO;
import org.kosta.studit.model.vo.RecruitPostListVO;
import org.kosta.studit.model.vo.RecruitPostVO;
import org.kosta.studit.model.vo.SmallCategoryVO;
import org.kosta.studit.model.vo.StudyConditionListVO;
import org.kosta.studit.model.vo.StudyConditionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class RecruitServiceImpl implements RecruitService {
	@Autowired
	private RecruitDAO recruitDAO;
	@Autowired
	private GroupDAO groupDAO;
	/**
	 * 스터디 현황 조회 시 내역 list를 불러온다.
	 * @author 변태섭
	 * @param String 회원 Email
	 * @return StudyConditionVO 스터디 현황 내역 list
	 */
	@Override
	public StudyConditionListVO findStudyConditionByMemberEmail(String memberEmail, int nowPage) {
		PagingBean pb = null;
		if(nowPage == 0) {
			pb = new PagingBean(recruitDAO.findCountStudyConditionByMemberEmail(memberEmail));
		}else {
			pb = new PagingBean(recruitDAO.findCountStudyConditionByMemberEmail(memberEmail), nowPage);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pb", pb);
		map.put("memberEmail", memberEmail);
		List<StudyConditionVO> list = recruitDAO.findStudyConditionByMemberEmail(map);
		StudyConditionListVO studyConditionListVO = new StudyConditionListVO(list, pb);
		return studyConditionListVO;
	}

	/**
	 * 스터디를 신청할떄 사용하는 메서드.
	 * 스터디게시글번호,회원이메일,자기소개내용을 받아 Map에 저장해서 DAO에 전달
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
	 * 스터디신청시 이미 거절상태일때 다시 미승인 상태로 바꿔주는 메서드.
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
	
	/**
	 * 조회할 번호에 따른 게시글 정보을 검색.
	 * 조회할 정보에는 게시글 상세정보, 희망 요일, 카테고리(소,대), 댓글
	 * @author 유동규
	 * @param recruitNo 조회할 모집 게시글 번호
	 * @return list 조회한 정보가 담겨있는 list  
	 */
	@Override
	public Map<String, Object> findRecruitPostDetailByRecruitNo(String memberEmail, int recruitNo){
		/*
		 *  1. 게시글 내용과 카테고리 내용 가져오기
		 *  2. 요일 가져오기
		 *  3. 댓글가져오기
		 *  4. 신청할 수 있는 사람인지 확인
		 */
		Map<String, Object> map = new HashMap<>();
		//게시글 내용과 카테고리 내용 가져오기
		map.put("detail", recruitDAO.findDetailRecruitPostAndCategoryByRecruitNo(recruitNo));

		//요일 가져오기
		List<String> dayList = recruitDAO.findDayByRecruitNo(recruitNo);
		map.put("day", dayList);
		
		//스터디 모집 신청할 수 있는지 여부 
		//memberEmail이 null이면 수정
		//memberEmail이 null이 아니면 상세보기 
		//   상세보기 1 - 상세보기일 땐 신청할 수 있는지 확인 
		//   상세보기 2 - study_condition에서 member_email과 recurit_post_no를 비교 : 있으면 불가, 없으면 신청가능
		if(memberEmail != null) {
			//댓글 가져오기
			List<RecruitPostCommentVO> commentList = recruitDAO.findRecruitCommentByRecruitNo(recruitNo);
			map.put("comment", commentList);
			//study_condition에 있는 상태 가져오기(미승인, 승인, 거절 등)
			Map<String, Object> stateMap = new HashMap<String, Object>();
			stateMap.put("memberEmail", memberEmail);
			stateMap.put("recruitNo", recruitNo);
			String state = recruitDAO.findStudyConditionStateByEmailAndRecruitNo(stateMap);
			if(state != null) {
				map.put("studyState", state);
			}
		}
		return map;
	}
	
	/**
	 * 카테고리(소, 대), 상세내용(제목, 내용, 희망인원, 지역, 수정시간), 요일을 변경하는 메서드.
	 * 트랜잭션을 통해 하나라도 실행이 되지 않았을 경우 Rollback
	 * 모집 요일은 전부 지웠다가 다시 등록 - 함수 재사용성
	 * @author 유동규
	 * @param recruitPostVO 수정할 내용이 담긴 객체
	 * @param days 수정할 요일들이 담긴 객체
	 */
	@Override
	@Transactional
	public void updateRecruitPostInfoByRecruitNo(RecruitPostVO recruitPostVO, List<String> days ) {
		//1 카테고리 업데이트
		Map<String, Integer> smallCategoryMap = new HashMap<>();
		smallCategoryMap.put("smallCategoryNo", recruitPostVO.getSmallCategoryVO().getSmallCategoryNo());
		smallCategoryMap.put("recruitNo", recruitPostVO.getRecruitPostNo());
		recruitDAO.updateSmallCategoryNoByRecruitNo(smallCategoryMap);
		
		//2, 상세정보 업데이트
		recruitDAO.updateRecruitPostByRecruitNo(recruitPostVO);
		
		//3. 요일 업데이트
		//   3-1 모집 게시글 관련 요일 삭제
		recruitDAO.deleteDayByRecruitNo(recruitPostVO.getRecruitPostNo());
		//   3-2 새로 등록
		Map<String, Object> dayMap;
		for(int i =0; i<days.size(); i++) {
			dayMap = new HashMap<>();
			dayMap.put("recruitPostNo", recruitPostVO.getRecruitPostNo());
			dayMap.put("recruitDay", days.get(i));
			recruitDAO.registerRecruitDay(dayMap);
		}
	}
	
	/**
	 * 스터디 모집글 등록, 해당 모집글의 요일 등록, 해당 모집글의 스터디 그룹 등록, 해당 스터디 그룹에 팀장 등록
	 * @author 송용준
	 * @param RecruitPostVO 등록할 모집글의 정보를 담은 객체
	 * @param String[] recruitDay 등록할 모집글의 활동 요일을 담은 배열 객체
	 */
	@Override
	public void createRecruitPost(RecruitPostVO recruitPostVO, String[] recruitDay) {
		// 작성한 글을 데이터베이스에 등록
		recruitDAO.createRecruitPost(recruitPostVO);

		// 등록된 글의 모집 요일들을 데이터베이스에 등록
		HashMap<String, Object> RecruitPostDay = new HashMap<>();
		for (int i = 0; i < recruitDay.length; i++) {
			RecruitPostDay.put("recruitPostNo", recruitPostVO.getRecruitPostNo());
			RecruitPostDay.put("recruitDay", recruitDay[i]);
			recruitDAO.registerRecruitDay(RecruitPostDay);
		}

		// 등록된 글의 스터디 그룹을 생성
		HashMap<String, Object> createStudyGroupInfo = new HashMap<>();
		createStudyGroupInfo.put("memberName", recruitPostVO.getMemberVO().getName());
		createStudyGroupInfo.put("recruitPostNo", recruitPostVO.getRecruitPostNo());
		groupDAO.createStudyGroup(createStudyGroupInfo);

		// 등록된 글의 작성자를 해당 스터디 그룹맴버로 등록 : 팀장
		HashMap<String, Object> registerStudyGroupMemberInfo = new HashMap<>();
		int studyGroupNo = groupDAO.findStudyGroupNoByRecruitPostNo(recruitPostVO.getRecruitPostNo());
		registerStudyGroupMemberInfo.put("memberEmail", recruitPostVO.getMemberVO().getMemberEmail());
		registerStudyGroupMemberInfo.put("groupPosition", "팀장");
		registerStudyGroupMemberInfo.put("studyGroupNo", studyGroupNo);
		groupDAO.registerStudyGroupMember(registerStudyGroupMemberInfo);

	}
	
	/**
	 * 모든 대분류 리스트를 조회
	 * @author 송용준
	 * @return List<BigCategoryVO> 대분류 정보를 담은 리스트
	 */
	@Override
	public List<BigCategoryVO> getBigCategoryList() {
		return recruitDAO.getBigCategoryList();
	}
	
	/**
	 * 선택된 대분류가 포함하고 있는 소분류 리스트를 조회
	 * @author 송용준
	 * @param bigCategoryNo 선택된 대분류 넘버
	 * @param List<SmallCategoryVO> 소분류 정보를 담은 리스트
	 */
	@Override
	public List<SmallCategoryVO> findSmallCategoryListByBigCategoryNo(String bigCategoryNo) {
		return recruitDAO.findSmallCategoryListByBigCategoryNo(bigCategoryNo);
	}
}
