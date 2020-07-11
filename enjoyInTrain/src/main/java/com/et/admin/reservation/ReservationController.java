package com.et.admin.reservation;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("admin.reservation.reservationController")
@RequestMapping("/admin/reservation/*")
public class ReservationController {
	@RequestMapping("list")
	public String list() {
		return ".admin.reservation.list";
	}
}
