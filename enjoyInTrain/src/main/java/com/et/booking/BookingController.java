package com.et.booking;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.et.crew.SessionInfo;

@Controller("bookingController")
@RequestMapping("/booking/*")
public class BookingController {
	
	@Autowired
	private BookingService service;
	
	
	@RequestMapping(value="reservation", method=RequestMethod.GET)
	public String reservation(
			Model model,
			@RequestParam Map<String, Object> paramMap,
			HttpSession session
			) {
		
		
		List<Booking> list = service.readPromotionDetail(paramMap);
		Booking startDto = null, endDto = null;
		for(Booking dto : list) {
			if(Integer.parseInt(dto.getTrainCode())%2==0)
				startDto = dto;
			else endDto = dto;
		}
		Booking dto = new Booking();
		SessionInfo info = (SessionInfo)session.getAttribute("crew");
		dto.setCrewId(info.getCrewId());
		Map<String , Object> map = new HashMap<>();
		map.put("crewId", dto.getCrewId());
		dto=service.readCrew(map);
		
		model.addAttribute("mode", "reservation");
		model.addAttribute("startDto",startDto);
		model.addAttribute("endDto",endDto);
		model.addAttribute("pmStartDate",paramMap.get("pmStartDate"));
		model.addAttribute("prPersonnel", paramMap.get("prPersonnel"));
		model.addAttribute("dto", dto);
		
		return ".booking.reservation";
	}
	
	@RequestMapping(value="reservation", method=RequestMethod.POST)
	public String reservationSubmit(
			Booking dto,
			HttpSession session
			) {
		SessionInfo info = (SessionInfo)session.getAttribute("crew");
		int seq = 0;
		try {
			dto.setCrewId(info.getCrewId());
			seq = service.insertReservation(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/booking/receipt?prCode="+seq;
	}
	
	
	@RequestMapping(value="receipt")			// 영수증
	public String receipt(
			@RequestParam int prCode,
			HttpSession session,
			Model model
			) {
		SessionInfo info = (SessionInfo)session.getAttribute("crew");
		Map<String, Object> map = new HashMap<>();
		map.put("prCode", prCode);
		map.put("crewId", info.getCrewId());
		try {
			Booking dto = new Booking();
			dto= service.readReservation(map);
			model.addAttribute("dto", dto);
			model.addAttribute("prCode", prCode);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ".booking.receipt";
	}
	
	
	@RequestMapping(value="payment", method=RequestMethod.GET)			// 결제폼
	public String paymentForm(
			@RequestParam int prCode,
			HttpSession session,
			Model model
			) {
		SessionInfo info = (SessionInfo)session.getAttribute("crew");
		Map<String, Object> map = new HashMap<>();
		map.put("prCode", prCode);
		map.put("crewId", info.getCrewId());
		try {
			Booking dto = new Booking();
			dto= service.readReservation(map);
			model.addAttribute("dto", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ".booking.payment";
	}
	
	@RequestMapping(value="payment", method=RequestMethod.POST)			// 결제완료
	public String paymentSubmit() {
		
		return "redirect:/";
	}
	
}
