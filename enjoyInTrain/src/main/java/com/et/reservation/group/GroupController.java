package com.et.reservation.group;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("reservation.groupController")
@RequestMapping("/reservation/group/*")
public class GroupController {
	
	@RequestMapping("main")
	public String main() {
		return "reservation/group/main";
	}
}