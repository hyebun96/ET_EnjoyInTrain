package com.et.reservation;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("reservation.reservationController")
@RequestMapping("/reservation/*")
public class ReservationController {
	@Autowired
	private ReservationService service;
	
	@RequestMapping("main")
	public String main(Model model) {
		List<Station> list=service.listStation();
		
		model.addAttribute("list",list);
		return ".reservation.main";
	}
}
