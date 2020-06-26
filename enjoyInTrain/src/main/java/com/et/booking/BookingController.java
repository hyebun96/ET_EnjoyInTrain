package com.et.booking;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.et.crew.SessionInfo;

@Controller("bookingController")
@RequestMapping("/booking/*")
public class BookingController {
	
	@Autowired
	private BookingService service;
	
	
	@RequestMapping(value="reservation", method=RequestMethod.GET)
	public String reservation(
			Model model,
			Booking dto
			) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pmcode", dto.getPmCode());
		map.put("trCode", dto.getStartTrain());

		dto = service.readPromotionDetail(map);
		
		model.addAttribute("mode", "reservation");
		model.addAttribute("dto",dto);
		
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("pmcode", dto.getPmCode());
		map1.put("trCode", dto.getEndTrain());
		
		dto = service.readPromotionDetail(map);
		
		model.addAttribute("vo",dto);
		
		
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
			service.insertReservation(dto);
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
