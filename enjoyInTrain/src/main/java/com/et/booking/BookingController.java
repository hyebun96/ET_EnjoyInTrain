package com.et.booking;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.et.crew.SessionInfo;

@Controller("bookingController")
@RequestMapping("/booking/*")
public class BookingController {
	
	@RequestMapping(value="reservation", method=RequestMethod.GET)
	public String reservation(
			Model model
			) {
		
		model.addAttribute("mode", "insert");
		
		return ".booking.reservation";
	}
	
	@RequestMapping(value="reservation", method=RequestMethod.POST)
	public String reservationSubmit(
			Booking dto,
			HttpSession session
			) {
		
		SessionInfo info = (SessionInfo)session.getAttribute("crew");
		
		try {
			dto.setCrewId(info.getCrewId());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/";
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
