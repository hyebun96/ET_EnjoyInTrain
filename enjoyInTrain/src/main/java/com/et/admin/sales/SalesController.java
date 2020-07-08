package com.et.admin.sales;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.et.booking.BookingService;
import com.et.common.MyUtil;

@Controller("admin.promotion.salesController")
public class SalesController {
	
	@Autowired
	private BookingService bookingService;
	
	@Autowired
	private MyUtil myutil;
	
	@RequestMapping("/admin/sales/list")
	public String list(@RequestParam(value="page", defaultValue="1") int page,
			@RequestParam(defaultValue="all")String condition,
			@RequestParam(defaultValue="")String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		
		
		return "";
		}
	}
