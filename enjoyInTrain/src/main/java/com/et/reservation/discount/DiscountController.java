package com.et.reservation.discount;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("discount.generalController")
@RequestMapping("/reservation/discount/*")
public class DiscountController {
	
	@RequestMapping("main")
	public String main() {
		return "reservation/discount/main";
	}
}
