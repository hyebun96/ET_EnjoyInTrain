package com.et.reservation.general;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("reservation.generalController")
@RequestMapping("/reservation/general/*")
public class GeneralController {
	
	@RequestMapping("main")
	public String main() {
		return "reservation/general/main";
	}
}