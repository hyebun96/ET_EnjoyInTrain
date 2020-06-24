package com.et.booking;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("bookingController")
@RequestMapping("/booking/*")
public class BookingController {
	
	@RequestMapping(value="reservation", method=RequestMethod.GET)
	public String reservation() {
		return ".booking.reservation";
	}
	
	@RequestMapping(value="reservation", method=RequestMethod.POST)
	public String reservationSubmit(
			Booking dto
			) {
		
		return "";
	}
	
	
	
	
	@RequestMapping(value="payment", method=RequestMethod.GET)			// 결제폼
	public String paymentForm() {
		
		return ".booking.payment";
	}
	
	public String paymentSubmit() {
		
		
		return "redirect:/";
	}
	
	@RequestMapping(value="receipt")			// 영수증
	public String receipt() {
		
		return ".booking.receipt";
	}
}
