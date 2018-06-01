package org.kosta.studit.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.kosta.studit.exception.EmailNotFoundException;
import org.kosta.studit.exception.IsNotMemberException;
import org.kosta.studit.exception.PasswordIncorrectException;
import org.kosta.studit.model.dao.CompanyDAO;
import org.kosta.studit.model.dao.GroupDAO;
import org.kosta.studit.model.dao.MemberDAO;
import org.kosta.studit.model.dao.RecruitDAO;
import org.kosta.studit.model.service.CompanyService;
import org.kosta.studit.model.service.GroupService;
import org.kosta.studit.model.service.MemberService;
import org.kosta.studit.model.service.RecruitService;
import org.kosta.studit.model.service.StudyRoomService;
import org.kosta.studit.model.vo.CompanyListVO;
import org.kosta.studit.model.vo.GroupMemberListVO;
import org.kosta.studit.model.vo.GroupMemberVO;
import org.kosta.studit.model.vo.MemberVO;
import org.kosta.studit.model.vo.RecruitPostListVO;
import org.kosta.studit.model.vo.SmallCategoryVO;
import org.kosta.studit.model.vo.StudyConditionListVO;
import org.kosta.studit.model.vo.StudyRoomConditionListVO;
import org.kosta.studit.model.vo.StudyRoomConditionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import net.minidev.json.JSONArray;
import net.minidev.json.JSONObject;

@Controller
@RequestMapping("/ajax")
public class AjaxViewController {

	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private MemberService memberService;
	@Autowired
	private RecruitDAO recruitDAO;
	@Autowired
	private CompanyDAO companyDAO;
	@Autowired
	private RecruitService recruitService;
	@Autowired
	private StudyRoomService studyroomService;
	@Autowired
	private CompanyService companyService;
	@Autowired
	private GroupService groupService;
	@Autowired
	private GroupDAO GroupDAO;
	   

	/**
	 * 아아디 중복확인을 위한 메서드. 사용자가 입력한 Email을 실시간으로 중복확인 한다.
	 * @author 송용준,변태섭
	 * @param 사용자가 입력한 Email
	 * @return 중복인 경우 false, 중복이 아닌 경우 true
	 */
	@RequestMapping("/findCheckByEmail")
	@ResponseBody
	public boolean findCheckByEmail(String memberEmail) {
		if (memberDAO.findMemberByEmail(memberEmail) == null) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 
	 * 비밀번호 검증 메서드 사용자가 입력한 현재 비밀번호를 DB에 저장된 정보와 비교하여 검증하여 결과값을 반환
	 * @author 김유란
	 * @param HttpServletRequest 파라미터를 받아오기 위해 호출
	 * @exception EmailNotFoundException 아이디가 없을 때 발생하는 예외
	 * @exception PasswordIncorrectException  비밀번호가 틀릴 때 발생하는 예외
	 * @return boolean 파라미터로 받아온 비밀번호 입력값의 DB 일치 여부에 따라 true/false 반환
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/checkPassword")
	@ResponseBody
	public boolean checkPassword(HttpServletRequest request) {
		String memberEmail = request.getParameter("memberEmail");
		String password = request.getParameter("nowPassword");
		try {
			memberService.login(new MemberVO(memberEmail, password));
		} catch (EmailNotFoundException | PasswordIncorrectException | IsNotMemberException e) {
			return false;
		}
		return true;
	}

	/**
	 * 
	 * 소분류 목록을 불러오는 메서드 
	 * 사용자가 선택한 대분류 번호를 전달받아 소분류 목록을 즉시 로드
	 * 
	 * @author 김유란
	 * @param bigCategoryNo  사용자가 선택한 대분류 번호
	 * @return List<SmallCategoryVO> 소분류 번호와 이름 정보를 담은 VO 리스트
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/getSmallCategoryList")
	@ResponseBody
	public List<SmallCategoryVO> getSmallCategoryList(String bigCategoryNo) {
		return recruitDAO.findSmallCategoryListByBigCategoryNo(bigCategoryNo);
	}

	/**
	 * 모집게시글에 따른 댓글 등록
	 * @author 유동규
	 * @param recruitNo 댓글을 가지고 있는 모집 게시글 번호
	 * @param comment 입력할 댓글
	 * @return true 정상 작동하면 true
	 */
	@RequestMapping(value = "/registerComment", method = RequestMethod.POST)
	@ResponseBody
	public String registerComment(int recruitNo, String comment, HttpServletRequest request) {
		String userEmail = ((MemberVO)request.getSession().getAttribute("memberVO")).getMemberEmail();
		Map<String, Object> commentMap = new HashMap<>();
		commentMap.put("comment", comment);
		commentMap.put("userEmail", userEmail);
		commentMap.put("recruitNo", recruitNo);
		recruitDAO.registerCommentByRecruitNo(commentMap);
		return "true";
	}
	
	/**
	 * 스터디 룸 현황 조회를 위한 페이징.
	 * 해당 사용자에 따른 전체 수를 구한 뒤 페이징처리를 한다.
	 * @author 유동규
	 * @param nowPage 현재 페이지
	 * @return StudyRoomConditionListVO 페이징한 결과(list)와 페이징 객체가 담겨있는 객체
	 */
	@RequestMapping("/findStudyRoomConditionByNowPage")
	@ResponseBody
	public StudyRoomConditionListVO findStudyRoomConditionByNowPage(int nowPage, HttpServletRequest request){
		return studyroomService.findStudyRoomConditionListVOByEmail(((MemberVO)request.getSession().getAttribute("memberVO")).getMemberEmail(), nowPage);
	}
	
	/**
	 * 입력된 주소에 따른 업체 리스트 반환
	 * @author 송용준
	 * @param addr1, addr2, addr3 입력된 주소값
	 * @param keywordORhashtag, nowPage 키워드와 현재 페이지정보
	 * @return CompanyListVO 검색 조건에 부합하는 페이징된 업체 리스트
	 */
	@RequestMapping("/findCompanyListByConditionAjax")
	@ResponseBody
	public CompanyListVO findCompanyListByCondition(String addr1, String addr2, String addr3, String keywordORhashtag, String nowPage) {
		Map<String, Object> map=new HashMap<>();
		if(addr1!=null) {
			if(addr1.equals("주소1")||addr1.equals("")) {
				map.put("firstAddr", null);
			}else {
				map.put("firstAddr", addr1);
			}
		}else {
			map.put("firstAddr", addr1);
		}
		if(addr2!=null) {
			if(addr2.equals("주소2")||addr2.equals("")) {
				map.put("secondAddr", null);
			}else {
				map.put("secondAddr", addr2);
			}
		}else {
			map.put("secondAddr", addr2);
		}
		if(addr3!=null) {
			if(addr3.equals("주소3")||addr3.equals("")) {
				map.put("thirdAddr", null);
			}else {
				map.put("thirdAddr", addr3);
			}
		}else {
			map.put("thirdAddr", addr3);
		}
		
		map.put("keywordORhashtag", keywordORhashtag);
		map.put("nowPage", nowPage);
		
		return companyService.findCompanyListByCondition(map);
	}
	
	/**
	 * 뷰에서 선택된 대분류에 대응되는 소분류를 조회.
	 * @author 송용준
	 * @param bigCategoryNo 뷰에서 선택된 대분류
	 * @return List<SmallCategoryVO> 조회한 소분류 리스트를 담은 객체
	 */
	@RequestMapping("/getSmallCategoryByBigCategoryAjax")
	@ResponseBody
	public List<SmallCategoryVO> getSmallCategoryByBigCategory(String bigCategoryNo) {
		List<SmallCategoryVO> list = recruitService.findSmallCategoryListByBigCategoryNo(bigCategoryNo);
		//System.out.println(list);
		return list;
	}
	
	
	/**
	 * 스터디룸(업체) 검색 뷰에서 선택된 addr1에 대응되는 addr2를 조회.
	 * @author 송용준
	 * @param addr1 뷰에서 선택된 첫번째 주소값
	 * @return List<String> 조회한 addr2 리스트를 담은 객체
	 */
	@RequestMapping("/findSecondAddressListByFirstAddressName")
	@ResponseBody
	public List<String> findSecondAddressListByFirstAddressName(String addr1){
		List<String> list=companyDAO.findSecondAddressListByFirstAddressName(addr1);
		return list;
	}
	
	/**
	 * 스터디룸(업체) 검색 뷰에서 선택된 addr2에 대응되는 addr3를 조회.
	 * @author 송용준
	 * @param addr2 뷰에서 선택된 두번째 주소값
	 * @return List<String> 조회한 addr3 리스트를 담은 객체
	 */
	@RequestMapping("/findThirdAddressListBySecondAddressName")
	@ResponseBody
	public List<String> findThirdAddressListBySecondAddressName(String addr2){
		List<String> list=companyDAO.findThirdAddressListBySecondAddressName(addr2);
		return list;
	}
	/**
	 * 스터디 현황 조회를 위한 페이징.
	 * 해당 사용자에 따른 전체 수를 구한 뒤 페이징처리를 한다.
	 * @author 변태섭, 유동규
	 * @param nowPage 현재 페이지
	 * @return StudyConditionListVO 페이징한 결과(list)와 페이징 객체가 담겨있는 객체
	 */
	@RequestMapping("/findStudyConditionByNowPage")
	@ResponseBody
	public StudyConditionListVO findStudyConditionByNowPage(int nowPage, HttpServletRequest request) {
		return  recruitService.findStudyConditionByMemberEmail(((MemberVO)request.getSession().getAttribute("memberVO")).getMemberEmail(), nowPage);
	}
	
	/**
	 * 댓글 삭제하기
	 * @author 유동규
	 * @param commentNo 삭제할 댓글 번호
	 */
	@RequestMapping(value="/deleteCommentByCommentNo", method=RequestMethod.POST)
	@ResponseBody
	public void deleteCommentByCommentNo(int commentNo) {
		recruitDAO.deleteCommentByCommentNo(commentNo);
	}
	
	/**
	 * 댓글 수정하기
	 * @author 유동규
	 * @param commentNo 수정할 댓글번호
	 * @param content 수정할 내용
	 */
	@RequestMapping(value="/updateCommentByCommentNo", method=RequestMethod.POST)
	@ResponseBody
	public void updateCommentByCommentNo(int commentNo, String content) {
		Map<String, Object> map = new HashMap<>();
		map.put("commentNo", commentNo);
		map.put("content", content);
		recruitDAO.updateCommentByCommentNo(map);
	}
	
	
	/**
	 * 소분류, 대분류, 키워드에 따른 페이징 AJAX
	 * nowPage를 받아 소분류, 대분류, 키워드를 같이 넘겨 페이징 결과 받기
	 * @author 유동규
	 * @param bigCategoryNo 대분류
	 * @param smallCategoryNo 소분류
	 * @param keyword 검색조건(제목, 지역)
	 * @return RecruitPostListVO pagingBean과 List<RecruitPostVO>가 담긴 객체 반환
	 */
	@RequestMapping("/findRecruitPostByCategoryAndKeyword")
	@ResponseBody
	public RecruitPostListVO findRecruitPostByCategoryAndKeyword(String bigCategoryNo, String smallCategoryNo, String keyword, HttpServletRequest request) {
		int nowPage = 1;
		if(request.getParameter("nowPage") != null && request.getParameter("nowPage") != "") {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		return recruitService.findRecruitPostByCategoryOrKeyword(bigCategoryNo, smallCategoryNo, keyword, nowPage);
	}
	
	/**
	 *업체 등록 시 사업자등록번호 중복확인을 위한 메서드. 
	 *사용자가 입력한 사업자 등록번호를 실시간으로 중복확인 한다.
	 * 
	 * @author 변태섭
	 * @param 입력된 사업자 등록 번호
	 * @return 중복인 경우 false, 중복이 아닌 경우 true
	 */
	@RequestMapping("/findCheckByLicense")
	@ResponseBody
	public boolean findCheckByLicense(String license) {
		if (companyDAO.findCountCompanyByLicense(license) == 0) {
			return true;
		} else {
			return false;
		}
	}
	

	/**
	 *예약현황 정보를 불러오는 메서드
	 *사용자가 선택한 스터디룸과 날짜에 해당하는 예약 현황 정보를 조회하여 전송한다.
	 * 
	 * @author 김유란
	 * @param selectedDate 사용자가 선택한 날짜
	 * @param studyRoomNo 사용자가 선택한 스터디룸의 번호
	 * @return StudyRoomConditionVO 예약 현황 정보를 담은 VO 리스트
	 */
	@RequestMapping(value="/findStudyRoomConditionByStudyRoomNoAndDate", method=RequestMethod.POST)
	@ResponseBody
	public List<StudyRoomConditionVO> findStudyRoomConditionByStudyRoomNoAndDate(String selectedDate, String studyRoomNo) {
		return studyroomService.findStudyRoomConditionByStudyRoomNoAndDate(selectedDate, studyRoomNo);
	}
	
	/**
	 *스터디룸 예약 취소 
	 *스터디룸 예약상태를 '예약취소'로 변경한다.
	 * 
	 * @author 김유란
	 * @param memberEmail 회원 이메일
	 * @param studyRoomConditionNo 스터디룸 예약 번호
	 */
	@RequestMapping(method=RequestMethod.POST, value="/updateStudyRoomConditionByMember")
	@ResponseBody
	public void updateStudyRoomConditionByMember(String memberEmail, String studyRoomConditionNo) {
		studyroomService.updateStudyRoomConditionByMember(memberEmail, studyRoomConditionNo);
	}
	
	/**
	 *스터디 신청 취소 
	 *스터디 신청 내역을 삭제한다.
	 * 
	 * @author 김유란
	 * @param memberEmail 회원 이메일
	 * @param studyConditionNo 스터디 신청 번호
	 */
	@RequestMapping(method=RequestMethod.POST, value="/deleteStudyConditionByStudyConditionNo")
	@ResponseBody
	public void deleteStudyConditionByStudyConditionNo(String memberEmail, String studyConditionNo) {
		System.out.println(memberEmail+" "+studyConditionNo);
			recruitService.deleteStudyConditionByStudyConditionNo(memberEmail, studyConditionNo);
	}
	
	/**
	    * 선택된 월 정보를 이용해 스터디룸 예약정보를 조회하는 메서드
	    * 캘린더의 월이 변경될 때마다 호출
	    * 
	    * @author 김유란
	    * @param studyRoomNo 스터디룸 번호
	    * @param startDate 선택된 월의 첫날
	    * @param endDate 선택된 월의 마지막날
	    * @return 조회된 예약현황 정보를 담은 VO 리스트
	    */
	@RequestMapping("/findStudyRoomConditionByStudyRoomNoAndMonth")
	@ResponseBody
	public JSONArray findStudyRoomConditionByStudyRoomNoAndMonth(String companyNo, String startDate, String endDate){
		return companyService.findStudyRoomConditionByCompanyNoAndMonth(companyNo, startDate, endDate);
	}
	
	/**
	 * 공휴일 정보 받아 예약현황 캘린더에 전송
	 * @author 김유란
	 * @param year 정보 조회를 원하는 연도
	 * @param month 정보 조회를 원하는 월
	 * @return JSONArray 공휴일 정보를 담은 JSON객체 배열
	 */
	@RequestMapping("/findHolidayInfoByDate")
	@ResponseBody
	public JSONArray findHolidayInfoByDate(String year, String month) throws IOException {
		 StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=esTFesfy%2FQV6VHLKYY4%2BpN2t9zAFnLmx9lInXwDXqRFTA%2FZcRvMgcVSDTCIiVelBr4KESA3BNGKabphAj2fs1w%3D%3D"); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("solYear","UTF-8") + "=" + URLEncoder.encode(year, "UTF-8")); /*연*/
	        urlBuilder.append("&" + URLEncoder.encode("solMonth","UTF-8") + "=" + URLEncoder.encode(month, "UTF-8")); /*월*/
	      //  urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /**/
	       // urlBuilder.append("&" + URLEncoder.encode("totalCount","UTF-8") + "=" + URLEncoder.encode("16", "UTF-8")); /**/
	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        conn.setRequestProperty("Accept", "application/json;charset=UTF-8");

	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        rd.close();
	        conn.disconnect();
 
	    ObjectMapper mapper = new ObjectMapper();
	     JsonFactory factory = mapper.getFactory();
	     JsonParser jsonParser = factory.createParser(sb.toString());
	     JsonNode node = mapper.readTree(jsonParser);

	     JSONArray arr = new JSONArray();
	     List<String> titleList = node.findValuesAsText("dateName");
	     List<String> dateList = node.findValuesAsText("locdate");	     

	     for(int i=0; i<titleList.size();i++) {
	    	 JSONObject obj = new JSONObject();
	    	 obj.put("title", titleList.get(i));
			obj.put("start", dateList.get(i));			
	    	 arr.add(obj);
	     }
	     return arr;

	     }
	
	/**
	 * 스터디 그룹 멤버 조회
	 * @author 김유란
	 * @param nowPage 현재 페이지
	 * @return GroupMemberListVO 페이징한 결과(list)와 페이징 객체가 담겨있는 객체
	 */
	@RequestMapping("/findGroupMemberByNowPage")
	@ResponseBody
	public GroupMemberListVO findGroupMemberByNowPage(String groupNo, String nowPage){
		return groupService.findGroupMemberByGroupNo(groupNo, nowPage);
	}
	
	/**
	 * 스터디 그룹 신청자 조회
	 * @author 김유란
	 * @param nowPage 현재 페이지
	 * @return studyConditionListVO 페이징한 결과(list)와 페이징 객체가 담겨있는 객체
	 */
	@RequestMapping("/findStudyConditionByNowPageAndConditionNo")
	@ResponseBody
	public StudyConditionListVO findStudyConditionByNowPageAndConditionNo(String groupNo, String nowPage){
		return recruitService.findStudyConditionByGroupNo(groupNo, nowPage);
	}
	
	
	
	@RequestMapping(method=RequestMethod.POST, value="/registerGroupMember")
	@ResponseBody
	public void registerGroupMember(String state, String studyConditionNo, String groupNo) {
		groupService.registerGroupMember(state, studyConditionNo, groupNo);
	}

	
}
