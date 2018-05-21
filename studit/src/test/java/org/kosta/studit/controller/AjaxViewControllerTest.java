package org.kosta.studit.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

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
public class AjaxViewControllerTest {
	   @Autowired
	   private WebApplicationContext wac;
	   
	   private MockMvc mock;
	   
	   @Before
	   public void setUp() {
	      this.mock = MockMvcBuilders.webAppContextSetup(wac).build();
	   }
	   
	   /**
	    * 회원가입 시 ID로 사용하는 Email 입력 시 실시간으로 중복 체크 하는 메서드
	    * @author 변태섭
	    */
	   //@Test
	    public void findCheckByEmailTest() throws Exception{
	      // email이 중복인 경우 false return
	       mock.perform(get("/ajax/findCheckByEmail")
	             .param("memberEmail", "a@a.com"))
	          .andDo(print())
	          .andExpect(content().contentType("application/json;charset=UTF-8")) 
	          .andExpect(status().isOk());
	       
	       // email이 중복이 아닌 경우 true returnX
	       mock.perform(get("/ajax/findCheckByEmail")
	             .param("memberEmail", "bts@a.com"))
	       .andDo(print())
	       .andExpect(content().contentType("application/json;charset=UTF-8")) 
	       .andExpect(status().isOk());
	    }
	   
	   @Test
	   public void getSmallCategoryByBigCategory() throws Exception {
		   mock.perform(get("/getSmallCategoryByBigCategoryAjax")
		             .param("bigCategoryNo", "3"))
		          .andDo(print())
		          .andExpect(content().contentType("application/json;charset=UTF-8")) 
		          .andExpect(status().isOk());
	   }
}
