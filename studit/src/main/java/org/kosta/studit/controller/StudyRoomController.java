package org.kosta.studit.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.kosta.studit.model.PagingBean;
import org.kosta.studit.model.dao.StudyRoomDAO;
import org.kosta.studit.model.vo.MemberVO;
import org.kosta.studit.model.vo.StudyRoomConditionListVO;
import org.kosta.studit.model.vo.StudyRoomConditionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/studyroom")
public class StudyRoomController {
	@Autowired
	private StudyRoomDAO studyroomDAO;
	
	@RequestMapping("/findStudyConditionByEmail")
	public String findStudyConditionByEmail(HttpServletRequest request, Model model) {
		//1. 총 게시물로 pagingbean 만들기
		int totalPage = studyroomDAO.getTotalStudyRoomCondition();
		PagingBean pb= new PagingBean(totalPage);
		//2. 조건문을 위해 이메일과 pb로 Map을 만들어 전달
		Map<String, Object> map = new HashMap<>();
		map.put("pagingBean", pb);
		map.put("memberEmail", ((MemberVO)request.getSession().getAttribute("memberVO")).getMemberEmail());
		//3. Map으로 paging처리된 결과 List로 받아오기
		List<StudyRoomConditionVO>list =  studyroomDAO.findStudyConditionByEmail(map);
		pb.setMyTotalPostCount(list.size());
		//4. paging된 list와 pb객체를 StudyRoomConditionListVO에 담아 전달
		StudyRoomConditionListVO srcListVO = new StudyRoomConditionListVO();
		srcListVO.setList(list);
		srcListVO.setPagingBean(pb);
		model.addAttribute("srcListVO", srcListVO);
		return "member/mypage2.tiles";
	}
	
}
