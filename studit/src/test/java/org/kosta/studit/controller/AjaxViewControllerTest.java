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
	   
	    //mockmvc를 이용하여 controller test
	    //perfom(get("/controllertest.do"))
	    // :get방식으로 url-pattern이 "controllertest.do" 실행
	    // .andDO(print()) : console에 출력
	    // .andExpect(status().isOk()); : 상태가 ok일때만 콘솔에 출력(아마도..?)
	   // 아래주석은 참고용으로 사용
	   
	   /**
	    * 회원가입 시 ID로 사용하는 Email 입력 시 실시간으로 중복 체크 하는 메서드
	    * @author 변태섭
	    */
	   @Test
	    public void findCheckByEmailTest() throws Exception{
	      // email이 중복인 경우 false return
	       mock.perform(get("/findCheckByEmail")
	             .param("memberEmail", "a@a.com"))
	          .andDo(print())
	          .andExpect(content().contentType("application/json;charset=UTF-8")) //이 부분은 Ajax에서만 사용 Controller에서는 이거 빼고 사용
	          .andExpect(status().isOk());
	       
	       // email이 중복이 아닌 경우 true returnX
	       mock.perform(get("/findCheckByEmail")
	             .param("memberEmail", "bts@a.com"))
	       .andDo(print())
	       .andExpect(content().contentType("application/json;charset=UTF-8")) //이 부분은 Ajax에서만 사용 Controller에서는 이거 빼고 사용
	       .andExpect(status().isOk());
	    }
}
