package org.kosta.studit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/recruit")
public class RecruitController {
	
	@RequestMapping("/getRecruitList")
	public String getRecruitList() {
		return"recruit/list_recruit.tiles";
	}
	
	
}
