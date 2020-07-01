package com.et.admin.sales;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.et.booking.BookingService;

@Controller("admin.promotion.salesController")
public class SalesController {
	
	@Autowired
	private BookingService bookingService;
	
	@RequestMapping("/admin/sales/list")
	public String list() {
		
		return ".admin.sales.list";
	}
}
