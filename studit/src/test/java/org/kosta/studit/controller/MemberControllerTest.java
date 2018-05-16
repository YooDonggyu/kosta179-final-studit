package org.kosta.studit.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import javax.servlet.http.HttpSession;

import org.junit.Before;
import org.junit.Test;
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
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring-model.xml", "file:src/main/webapp/WEB-INF/spring-web.xml"})
public class MemberControllerTest {
	
	@Autowired
	private WebApplicationContext wac;
	
	private MockMvc mock;
	
	@Before
	public void setUp() {
		this.mock = MockMvcBuilders.webAppContextSetup(wac).build();
	}
	
	/**
	 * Login TEST.
	 * MemberVO의 instance 변수명과 값을 넣어 TEST해본다.
	 * @author 유동규
	 * @param memberEmail Test할 Email
	 * @param password Test할 비밀번호
	 */
	 @Test
	 public void loginTest() {
	 	HttpSession session = null;
		try {
			session = mock.perform(post("/member/login")
					.param("loginEmail", "a@a.com")
					.param("loginPassword", "1"))
						.andDo(print())
						/*.andExpect(status().isOk())*/
						.andExpect(redirectedUrl("/"))
						.andReturn().getRequest().getSession();
			System.out.println(session.getAttribute("memberVO"));
		} catch (Exception e) {
			System.out.println("error");
			e.printStackTrace();
		}
	 }
}
