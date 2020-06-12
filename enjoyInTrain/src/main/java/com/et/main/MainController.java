package com.et.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("mainController")
public class MainController {
	@RequestMapping("/main")
	public String main() {
		return ".layout.footer";
	}
}
