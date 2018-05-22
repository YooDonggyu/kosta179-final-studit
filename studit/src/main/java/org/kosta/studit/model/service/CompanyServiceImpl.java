package org.kosta.studit.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.kosta.studit.model.dao.CompanyDAO;
import org.kosta.studit.model.vo.CompanyVO;
import org.kosta.studit.model.vo.StudyRoomConditionVO;
import org.kosta.studit.model.vo.StudyRoomVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.minidev.json.JSONArray;
import net.minidev.json.JSONObject;

@Service
public class CompanyServiceImpl implements CompanyService {
	@Autowired
	private CompanyDAO companyDAO;
	
	/**
	 * 
	 * 등록이 승인된 업체들의 첫번째 주소를 조회 : 뷰에 셀렉트 박스에 제공될 주소목록
	 * 
	 * @author 송용준
	 * @return List<String> 등록이 승인된 업체들의 첫번째 주소
	 */
	@Override
	public List<String> readFirstAddr() {
		return companyDAO.readFirstAddr();
	}
	
	/**
	 * 
	 * 등록이 승인된 업체 정보들을 조회 : 뷰에 카드 형식으로 표시
	 * 
	 * @author 송용준
	 * @return List<CompanyVO> 등록이 승인된 업체들의 정보
	 */
	@Override
	public List<CompanyVO> readAllCompany() {
		return companyDAO.readAllCompany();
	}
	
	/**
	 * 
	 * 등록이 승인된 업체 정보들의 해쉬태그를 조회
	 * 
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
	    * 
	    * @author 김유란
	    * @param memberEmail 접속중인 사용자의 세션에 저장된 회원 식별 정보(임시*****)
	    * @return JSONArray VO List로 받은 정보를 json객체로 변환하여 담은 json배열
	    */
	@Override
	public JSONArray findStudyRoomByMemberEmail(String memberEmail) {
		
		JSONArray jsArr = new JSONArray();
		CompanyVO companyVO = companyDAO.findCompanyByMemberEmail(memberEmail);
		List<StudyRoomVO> studyRoomlist = companyDAO.findStudyRoomByCompanyNo(companyVO.getCompanyNo());
		for(StudyRoomVO vo : studyRoomlist) {
			vo.setCompanyVO(companyVO);
			JSONObject studyRoom= new JSONObject();
			studyRoom.put("id", vo.getStudyRoomNo());
			studyRoom.put("title", vo.getName());
			studyRoom.put("capacity", vo.getCapacity());
			studyRoom.put("holiday", vo.getCompanyVO().getHoliday());
			studyRoom.put("open", vo.getCompanyVO().getOpen());
			studyRoom.put("close", vo.getCompanyVO().getClose());
			
			jsArr.add(studyRoom);
		}
		
		return jsArr;
	}
	
	
	/**
	    * 각 스터디룸별 예약정보를 가져와 json형태로 변환하여 반환하는 메서드
	    * 풀캘린더에 예약현황을 보여줄 때 사용
	    * (ajax 전송으로 변경할 예정)
	    * 
	    * @author 김유란
	    * @param memberEmail 접속중인 사용자의 세션에 저장된 회원 식별 정보(임시*****)
	    * @return JSONArray VO List로 받은 정보를 json객체로 변환하여 담은 json배열
	    */
	@Override 
	public JSONArray findStudyRoomConditionByMemberEmail(String memberEmail) {
		JSONArray jsArr = new JSONArray();
		CompanyVO companyVO = companyDAO.findCompanyByMemberEmail(memberEmail);
		List<StudyRoomVO> studyRoomlist = companyDAO.findStudyRoomByCompanyNo(companyVO.getCompanyNo());
		for(StudyRoomVO vo : studyRoomlist) {
			List<StudyRoomConditionVO> conditionList = companyDAO.findStudyRoomConditionByStudyRoomNo(vo.getStudyRoomNo());
			for(StudyRoomConditionVO srcVO : conditionList) {
				JSONObject condition= new JSONObject();
				condition.put("id", srcVO.getStudyRoomConditionNo());
				condition.put("resourceId", vo.getStudyRoomNo());
				condition.put("resourceName", vo.getName());
				condition.put("start", srcVO.getUseDate()+"T"+srcVO.getStartTime());
				condition.put("end", srcVO.getUseDate()+"T"+srcVO.getEndTime());
				condition.put("title", srcVO.getMemberVO().getName());
				condition.put("state", srcVO.getState());
				
				jsArr.add(condition);
			}
			
		}
		
		return jsArr;
	}
	

	/**
	    * 업체의 영업일 정보를 가져와 json형태로 변환하여 반환하는 메서드
	    * 풀캘린더에 스터디룸 예약 가능일을 보여줄 때 사용
	    * 풀캘린더의 business hour 설정에서 요구하는 필드명과 값으로 변환함
	    * 
	    * @author 김유란
	    * @param memberEmail 접속중인 사용자의 세션에 저장된 회원 식별 정보(임시*****)
	    * @return JSONObject VO List로 받은 정보를 담은 json객체
	    */
	@Override
	public JSONObject findBusinessDayByMemberEmail(String memberEmail) {
		JSONObject obj = new JSONObject();
		CompanyVO companyVO = companyDAO.findCompanyByMemberEmail(memberEmail);
		List<String> days = companyDAO.findBusinessDayByCompanyNo(companyVO.getCompanyNo());
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
	

	/*****캘린더 테스트 위해 임시로 만든 메서드. 
	 	*	바로 위에 있는 findBusinessDayByMemberEmail와 매개변수 제외하면 똑같아서 전체적인 뷰가 정리되면 하나로 통일할 예정
	    * 
	    * @author 김유란
	    * @param companyNo 업체 식별번호 
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



}
