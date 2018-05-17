package org.kosta.studit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/")
public class HomeController {
	/**
	 * 
	 * 메인 홈페이지로 이동.
	 * tiles를 적용하기 위해 .tiles를 붙여준다.
	 * @author 유동규
	 * @return home.tiles tiles가 적용된 메인 홈페이지로 이동
	 */
	@RequestMapping("/")
	public String home() {
		return"home.tiles";
	}
	
	
	//@PathVariable : 요청 url 정보를 변수로 할당받기 위한 어노테이션
	// 요청 url과 일치하는 별도의 RequestMapping이 있으면 그 메서드가 m
	
	// 실행되고 없으면 PathVariable 적용된 메서드가 실행된다. 
	/**
	 * session처리가 필요없는 요청에 즉각 페이지를 이동하기 위한 메서드.
	 * 이동할 .jsp를 viewName으로 url-pattern으로 지정해서 viewName.tiles로 이동한다. 
	 * 
	 * @author 유동규
	 * @param viewName @PathVariable 어노테이션을 이용해 이동할 .jsp 이름을 저장
	 * @return member/viewName member에서만 session을 사용하지 않기 때문에 member/를 붙여준다. 
	 */
	@RequestMapping("/{viewName}")
	public String showTiles(@PathVariable String viewName) {
		return "member/"+viewName+".tiles";
	}


}
