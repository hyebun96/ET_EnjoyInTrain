package com.et.admin.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("admin.mainController")
public class MainController {
	 
	@RequestMapping("/admin")
	public String mian() {
		return ".adminLayout";
	}
}
