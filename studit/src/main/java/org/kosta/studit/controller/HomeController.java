package org.kosta.studit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	
	@RequestMapping("/")
	public String home() {
		return"home.tiles";
	}
	
	@RequestMapping("/loginView")
	public String loginView() {
		return "member/login";
	}

}
