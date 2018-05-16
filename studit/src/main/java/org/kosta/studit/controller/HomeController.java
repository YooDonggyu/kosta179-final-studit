package org.kosta.studit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/")
public class HomeController {
	
	@RequestMapping("/")
	public String home() {
		return"home.tiles";
	}
	
	
	//@PathVariable : 요청 url 정보를 변수로 할당받기 위한 어노테이션
	// 요청 url과 일치하는 별도의 RequestMapping이 있으면 그 메서드가 
	// 실행되고 없으면 PathVariable 적용된 메서드가 실행된다. 
	@RequestMapping("/{viewName}")
	public String showTiles(@PathVariable String viewName) {
		return "member/"+viewName+".tiles";
	}


}
