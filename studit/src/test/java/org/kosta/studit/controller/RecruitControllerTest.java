package org.kosta.studit.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Before;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring-model.xml",
		"file:src/main/webapp/WEB-INF/spring-web.xml" })
public class RecruitControllerTest {

	@Autowired
	private WebApplicationContext wac;

	private MockMvc mock;

	@Before
	public void setUp() {
		this.mock = MockMvcBuilders.webAppContextSetup(wac).build();
	}

	/**
	 * 스터디 모집 게시글 상세보기 TEST (로그인이 선행되어야 하기 때문에 현재로썬 spring-web.xml에서 interceptor
	 * 예외처리 후 TEST - TEST 완료 후 꼭 다시 주석 !)
	 * 
	 * @author 유동규
	 */
	//@Test
	 public void findDetailRecruitPostInfoByRecruitNoTest() {
		// Test하기 위해서 Login이 선행되어야 함
		// 따라서 spring-web.xml 의 interceptor 부분에서
		// mapping exclude - /recruit/findDetailRecruitPostInfoByRecruitNo 를 주석 해제하고
		// TEST
		try {
			mock.perform(get("/recruit/findDetailRecruitPostInfoByRecruitNo")
					// parameter type이 int여도 String으로 넣어주면 실행 가능
					.param("recruitNo", "1")).andDo(print()).andExpect(status().isOk());
		} catch (Exception e) {
			e.printStackTrace();
		}
	 }
	 /**
	  * 모집 게시글 번호에 따른 상태변경(모집중 -> 삭제)
	  * @author 유동규
	  */
	 //@Test
	 public void deleteRecruitPostByRecruitNo() {
			try {
				mock.perform(post("/recruit/deleteRecruitPostByRecruitNo")
						.param("recruitNo", "1"))
							.andDo(print())
							.andExpect(status().isOk());
			} catch (Exception e) {
				e.printStackTrace();
			}
	 }
	 
	 /**
	  * 회원 정보 수정할 데이터 TEST
	  * TEST방법이 오류 ! WEB에서 작동완료 방법이 필요
	  * @author 유동규
	  */
	 //@Test
	 public void updateRecruitPostInfoByRecruitNo() {
			try {
				mock.perform(post("/recruit/updateRecruitPostInfoByRecruitNo")
						.param("recruitPostNo", "1")
						.param("title", "제목수정")
						.param("content", "내용수정")
						.param("capacity", "희망인원수정")
						.param("location", "지역수정")
						.param("smallCategoryVO.smallCategoryNo", "3")
						.param("day", "화요일"))
							.andDo(print())
							.andExpect(status().isOk());
			} catch (Exception e) {
				e.printStackTrace();
			}
	 }
	 
	 /**
	 * 모집 게시글 상세보기에서 수정하기 눌렀을 때 데이터를 가지고 이동하기 위한 메서드 TEST.
	 * @author 유동규
	  */
	 //@Test
	 public void updateRecruitPostInfoByRecruitNoView() {
			try {
				mock.perform(post("/recruit/updateRecruitPostInfoByRecruitNoView")
						.param("recruitNo", "1")
						.param("bigCategoryNo", "1"))
							.andDo(print())
							.andExpect(status().isOk());
			} catch (Exception e) {
				e.printStackTrace();
			}
	 }
	 
	 /**
	 * 모집 게시글 번호에 따른 상세보기 및 조회수 증가 및 정보, 카테고리(소, 대), 댓글, 요일을 반환 TEST
	 * 세션이 필요해서 TEST 작동은 안되고 WEB에서는 완료
	 * @author 유동규
	  */
	 //@Test
	 public void findDetailRecruitPostInfoByRecruitNo() {
			try {
				mock.perform(post("/recruit/findDetailRecruitPostInfoByRecruitNo")
						.param("recruitNo", "1"))
							.andDo(print())
							.andExpect(status().isOk());
			} catch (Exception e) {
				e.printStackTrace();
			}
	 }
	
}
