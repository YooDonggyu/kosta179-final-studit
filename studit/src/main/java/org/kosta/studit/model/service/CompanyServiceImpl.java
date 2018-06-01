
package org.kosta.studit.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.studit.model.CompanyPagingBean;
import org.kosta.studit.model.dao.CompanyDAO;
import org.kosta.studit.model.dao.MemberDAO;
import org.kosta.studit.model.dao.StudyRoomDAO;
import org.kosta.studit.model.vo.CompanyListVO;
import org.kosta.studit.model.vo.CompanyVO;
import org.kosta.studit.model.vo.StudyRoomConditionVO;
import org.kosta.studit.model.vo.StudyRoomVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.minidev.json.JSONArray;
import net.minidev.json.JSONObject;

@Service
public class CompanyServiceImpl implements CompanyService {
	@Autowired
	private CompanyDAO companyDAO;
	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private StudyRoomDAO studyRoomDAO;
	
	/**
	 * 등록이 승인된 업체들의 첫번째 주소를 조회 : 뷰에 셀렉트 박스에 제공될 주소목록
	 * @author 송용준
	 * @return List<String> 등록이 승인된 업체들의 첫번째 주소
	 */
	@Override
	public List<String> readFirstAddr() {
		return companyDAO.readFirstAddr();
	}
	
	/**
	 * 등록이 승인된 업체 정보들을 조회 : 뷰에 카드 형식으로 표시
	 * @author 송용준
	 * @return List<CompanyVO> 등록이 승인된 업체들의 정보
	 */
	@Override
	public List<CompanyVO> readAllCompany() {
		return companyDAO.readAllCompany();
	}
	
	/**
	 * 등록이 승인된 업체 정보들의 해쉬태그를 조회
	 * @author 송용준
	 * @return List<Map<String, Object>> 등록이 승인된 업체 정보들의 해쉬태그
	 */
	@Override
	public List<Map<String, Object>> readAllHashTag() {
		return companyDAO.readAllHashTag();
	}
	
	/**
	    * 스터디룸 정보를 가져와 json형태로 변환하여 반환하는 메서드
	    * 풀캘린더에 예약현황을 보여줄 때 사용
	    * @author 김유란
	    * @param memberEmail 접속중인 사용자의 세션에 저장된 회원 식별 정보(임시*****)
	    * @return JSONArray VO List로 받은 정보를 json객체로 변환하여 담은 json배열
	    */
	@Override
	public JSONArray findStudyRoomByCompanyNo(int companyNo) {
		JSONArray jsArr = new JSONArray();
		List<StudyRoomVO> studyRoomlist = companyDAO.findStudyRoomByCompanyNo(companyNo);
		for(StudyRoomVO vo : studyRoomlist) {
			JSONObject studyRoom= new JSONObject();
			studyRoom.put("id", vo.getStudyRoomNo());
			studyRoom.put("title", vo.getName());
			studyRoom.put("capacity", vo.getCapacity());
			studyRoom.put("holiday", vo.getCompanyVO().getHoliday());
			studyRoom.put("open", vo.getCompanyVO().getOpen());
			studyRoom.put("close", vo.getCompanyVO().getClose());
			studyRoom.put("companyNo", vo.getCompanyVO().getCompanyNo());
			studyRoom.put("companyName", vo.getCompanyVO().getName());
			jsArr.add(studyRoom);
		}
		
		return jsArr;
	}
	
	
	/**
	    * 선택된 월 정보를 이용해 스터디룸 예약정보를 조회하는 메서드
	    * 풀캘린더에 예약현황을 보여줄 때 사용
	    * @author 김유란
	    * @param studyRoomNo 스터디룸 번호
	    * @param startDate 선택된 월의 첫날
	    * @param endDate 선택된 월의 마지막날
	    * @return 조회된 예약현황 정보를 담은 VO 리스트
	    */
	@Override 
	public JSONArray findStudyRoomConditionByCompanyNoAndMonth(String companyNo, String startDate, String endDate) {
		JSONArray arr = new JSONArray();
		Map<String, String> map = new HashMap<>();
		map.put("companyNo", companyNo);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		List<StudyRoomConditionVO> list = companyDAO.findStudyRoomConditionByCompanyNoAndMonth(map);
			for(StudyRoomConditionVO srcVO : list) {
				JSONObject condition= new JSONObject();
				condition.put("id", srcVO.getStudyRoomConditionNo());
				condition.put("resourceId", srcVO.getStudyRoomVO().getStudyRoomNo());
				condition.put("resourceName", srcVO.getStudyRoomVO().getName());
				condition.put("start", srcVO.getUseDate()+"T"+srcVO.getStartTime()+":00");
				condition.put("end", srcVO.getUseDate()+"T"+srcVO.getEndTime()+":50");
				condition.put("title", srcVO.getMemberVO().getName());
				condition.put("state", srcVO.getState());
				arr.add(condition);
			}
		return arr;
	}
	

	/**
	    * 업체의 영업일 정보를 가져와 json형태로 변환하여 반환하는 메서드
	    * 풀캘린더에 스터디룸 예약 가능일을 보여줄 때 사용
	    * 풀캘린더의 business hour 설정에서 요구하는 필드명과 값으로 변환함
	    * @author 김유란
	    * @param memberEmail 접속중인 사용자의 세션에 저장된 회원 식별 정보(임시*****)
	    * @return JSONObject VO List로 받은 정보를 담은 json객체
	    */
	@Override
	public JSONObject findBusinessDayByCompanyNo(int companyNo) {
		JSONObject obj = new JSONObject();
		List<String> days = companyDAO.findBusinessDayByCompanyNo(companyNo);
		List<Integer> days2 = new ArrayList<>();
		for(int i=0; i<days.size(); i++) {
			if(days.get(i).equals("일")) {
				days2.add(0);
			}else if(days.get(i).equals("월")) {
				days2.add(1);
			}else if(days.get(i).equals("화")) {
				days2.add(2);
			}else if(days.get(i).equals("수")) {
				days2.add(3);
			}else if(days.get(i).equals("목")) {
				days2.add(4);
			}else if(days.get(i).equals("금")) {
				days2.add(5);
			}else if(days.get(i).equals("토")) {
				days2.add(6);
			}
		}
		obj.put("dow", days2);
		return obj;
	}
	

	@Override
	public CompanyListVO findCompanyListByCondition(Map<String, Object> map) {
		CompanyPagingBean pb=null;
		List<CompanyVO> list=null;
		//첫 로딩 시, 검색 조건 없음
		if(map==null) {
			pb=new CompanyPagingBean(companyDAO.findTotalCountOfCompany(null));
			list=findCompanyList(pb);
		}else {
			int nowPage=0;
			if(map.get("nowPage")!=null && map.get("nowPage")!="") {
				nowPage=Integer.parseInt((String)map.get("nowPage"));
			}
			
			if(nowPage==0) {
				pb=new CompanyPagingBean(companyDAO.findTotalCountOfCompany(map));
			}else {
				pb=new CompanyPagingBean(companyDAO.findTotalCountOfCompany(map), nowPage);
			}
			map.put("pagingBean", pb);
			list=findCompanyList(map);
		}
		
		/*System.out.println(map.get("firstAddr"));
		System.out.println(map.get("secondAddr"));
		System.out.println(map.get("thirdAddr"));
		System.out.println(map.get("keywordORhashtag"));
		System.out.println(map.get("nowPage"));*/
		CompanyListVO pagingList=new CompanyListVO(list, pb);
		
		return pagingList;
	}
	
	/**
	    * 스터디룸(업체) 검색 뷰에서 선택된 주소값을 기반으로 페이징 처리된 업체 리스트를 조회.
	    * 3개의 주소값을 기반으로 페이징 처리된 업체 리스트을 List<CompanyVO> 타입으로 반환받는다.
	    * @author 송용준
	    * @param Map<String, String> map 3개의 주소값과 페이징 객체를 가지고 있는 객체
	    * @return List<CompanyVO> 페이징 처리된 업체 리스트
	    */
	public List<CompanyVO> findCompanyList(Map<String, Object> map) {
		return companyDAO.findCompanyListByCondition(map);
	}
	
	/**
    * 스터디룸(업체) 스터디 검색 뷰 첫 로딩 시, 페이징 처리된 모든 업체 리스트를 조회.
    * 페이징 처리된 업체 리스트을 List<CompanyVO> 타입으로 반환받는다.
    * @author 송용준
    * @param CompanyPagingBean 페이징을 위한 객체
    * @return List<CompanyVO> 페이징 처리된 모든 업체 리스트
    */
	public List<CompanyVO> findCompanyList(CompanyPagingBean pb) {
		Map<String, Object> map=new HashMap<>();
		map.put("pagingBean", pb);
		return companyDAO.findCompanyListByCondition(map);
	}

	/**
	 * 업체 및 업체 연관 테이블을 등록하는 메서드
	 * @author 변태섭
	 * @param CompanyVO 업체 관련 정보가 담긴 객체
	 * @param String day 영업요일
	 * @param String hashtag 해시태그
	 * @param List 업체 사진들의 경로가 담긴 객체
	 */
	@Transactional
	@Override
	public void registerCompany(CompanyVO companyVO, String day, String hashtag, List<String> companyPicFileList) {
		String[] days = day.split(" ");
		String[] hashtags = hashtag.split(",");
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("days: "+days+", hashtags: "+hashtags+",before map: "+map);
		
		companyDAO.registerCompany(companyVO);
		System.out.println("registerCompany Complete");
		
		map.put("companyNo", companyVO.getCompanyNo());
		System.out.println("after map: "+map);
		
		for(int i=0; i<days.length; i++) {
			map.put("day", days[i]);
			System.out.println("days map: "+map);
			companyDAO.registerBusinessDay(map);
		}
		System.out.println("registerBusinessDay  Complete");
		
		for(int i=0; i<hashtags.length; i++) {
			map.put("tag", hashtags[i]);
			System.out.println("hashtags map: "+map);
			companyDAO.registerHashtag(map);
		}
		System.out.println("registerHashtag  Complete");
		
		for(int i=0; i<companyPicFileList.size(); i++) {
			map.put("companyPicPath", companyPicFileList.get(i));
			companyDAO.registerCompanyPicPath(map);
		}
		System.out.println("companyPicFile Upload Complete");
		
		Map<String, String> memberPositionMap = new HashMap<String, String>();
		memberPositionMap.put("memberEmail", companyVO.getMemberVO().getMemberEmail());
		memberPositionMap.put("memberPosition", "업체");
		if(memberDAO.findCountMemberPositionByMemberPositionAndMemberEmail(memberPositionMap)==0) {
			memberDAO.registerMemberPosition(memberPositionMap);
		}
	}
	
	@Override
	public Map<String, Object> findDetailCompanyInfoByCompanyNo(int companyNo) {
		//회사정보
		CompanyVO companyVO = companyDAO.findCompanyByCompanyNo(companyNo);
		//회사사진
		List<Map<String, Object>> comPicList = companyDAO.findComPicByCompanyNo(companyNo);
		//회사영업일
		List<String> comDayList = companyDAO.findBusinessDayByCompanyNo(companyNo);
		//회사해시태그
		List<Map<String, Object>> comHashTagList = companyDAO.findHashTagByCompanyNo(companyNo);
		//스터디룸 정보
		List<StudyRoomVO> studyList = studyRoomDAO.findStudyRoomInfoByCompanyNo(companyNo);
		//스터디룸기능정보
		List<Map<String,Object>> studyFunctionList =  studyRoomDAO.findstudyroomFunctionByCompanyNo(companyNo);
		//스터디룸사진
		List<Map<String, Object>> studyPicList = studyRoomDAO.findStudyRoomPicByCompanyNo(companyNo);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("companyVO", companyVO);
		dataMap.put("comPicList", comPicList);
		dataMap.put("comDayList", comDayList);
		dataMap.put("comHashTagList", comHashTagList);
		dataMap.put("studyList", studyList);
		dataMap.put("studyFunctionList", studyFunctionList);
		dataMap.put("stduyPicList", studyPicList);
		
		return dataMap;
	}

	/**
	 * 업체 번호로 해당 업체의 스터디룸 리스트를 불러오는 메서드
	 * @author 변태섭
	 * @param companyNo 업체 번호
	 * @return List<StudyRoomVO> 해당 업체가 등록한 스터디룸 정보 리스트
	 */
	@Override
	public List<StudyRoomVO> findStudyRoomListByCompanyNo(int companyNo){
		return companyDAO.findStudyRoomByCompanyNo(companyNo);
	}
	
	@Override
	public JSONArray findStudyRoomConditionCountByMonth(String companyNo){
		Map<String, String> map = new HashMap<>();
		map.put("companyNo", companyNo);
		JSONObject waitList = new JSONObject();
		JSONObject completeList = new JSONObject();
		JSONObject denyList = new JSONObject();
		JSONObject cancelList = new JSONObject();
		map.put("state", "예약대기");
		waitList.put("예약대기", companyDAO.findStudyRoomConditionCountByMonth(map));
		map.put("state", "예약완료");
		completeList.put("예약완료", companyDAO.findStudyRoomConditionCountByMonth(map));
		map.put("state", "예약불가");
		denyList.put("예약불가", companyDAO.findStudyRoomConditionCountByMonth(map));
		map.put("state", "예약취소");
		cancelList.put("예약취소", companyDAO.findStudyRoomConditionCountByMonth(map));

		JSONArray arr = new JSONArray();
		arr.add(waitList);
		arr.add(completeList);
		arr.add(denyList);
		arr.add(cancelList);
		
		return arr;
		}

	/**
	 * 업체 정보를 수정하는 메서드
	 * @author 변태섭
	 * @param companyVO 입력된 업체 정보
	 * @param day 입력된 요일 정보
	 * @param hashtag 입력된 해시태그 정보
	 */
	@Transactional
	@Override
	public void updateCompany(CompanyVO companyVO, String day, String hashtag) {
		String[] days = day.split(" ");
		String[] hashtags = hashtag.split(",");
		System.out.println("day: "+days);
		System.out.println("hashtag: "+hashtags);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("companyNo", companyVO.getCompanyNo());
		
		companyDAO.updateCompany(companyVO);
		System.out.println("updateCompany Complete");
		
		companyDAO.deleteCompanyBusinessDayByCompanyNo(companyVO.getCompanyNo());
		System.out.println("delete BusinessDay Complete");
		companyDAO.deleteHashtagByCompanyNo(companyVO.getCompanyNo());
		System.out.println("delete Hashtag Complete");
		
		for(int i=0; i<days.length; i++) {
			map.put("day", days[i]); 
			companyDAO.registerBusinessDay(map);
		}
		System.out.println("register BusinessDay Complete");
	
		for(int j=0; j<hashtags.length; j++) {
			map.put("tag", hashtags[j]);
			companyDAO.registerHashtag(map);
		}
		System.out.println("register Hashtag Complete");
	}
}
