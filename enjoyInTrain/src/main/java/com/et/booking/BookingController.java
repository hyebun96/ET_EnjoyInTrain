package com.et.booking;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.et.reservation.ReservationService;
import com.et.reservation.ReservedSeat;
import com.et.reservation.Seat;

@Controller("booking.bookingController")
@RequestMapping("/booking/*")
public class BookingController {

	@Autowired
	private BookingService service;

	@Autowired
	private ReservationService service1;

	@RequestMapping(value = "reservation", method = RequestMethod.GET)
	public String reservation(Model model, @RequestParam Map<String, Object> paramMap, HttpSession session) {

		List<Booking> list = service.readPromotionDetail(paramMap);
		List<Booking> list1 = service.readPromotionDetail(paramMap);
		Booking startDto = null, endDto = null;
		Booking start = null, end = null;
		for (Booking dto : list) {
			if (Integer.parseInt(dto.getTrainCode()) % 2 == 0) {
				startDto = dto;
			} else {
				endDto = dto;
			}
		}
		for (Booking vo : list1) {
			if (Integer.parseInt(vo.getTrainCode()) % 2 == 0) {
				start = vo;
				start = service.readtrainlist(start);
				start.setPrAddPrice(service.readsPay(start));
			} else {
				end = vo;
				end = service.readtrainlist(end);
				end.setPrAddPrice(service.readsPay1(end));
			}
		}
		startDto.setStartStation(service.readStartStation(startDto.getStartStation()));
		startDto.setEndStation(service.readEndStation(startDto.getEndStation()));
		endDto.setStartStation(service.readStartStation(endDto.getStartStation()));
		endDto.setEndStation(service.readEndStation(endDto.getEndStation()));

		SessionInfo info = (SessionInfo) session.getAttribute("crew");

		Map<String, Object> map = new HashMap<>();
		map.put("crewId", info.getCrewId());
		Booking dto = service.readCrew(map);

		String s = (String) paramMap.get("pmStartDate");
		String sDate = "";
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy/M/d(E)");

			Date date = sdf.parse(s);
			sDate = sdf2.format(date);
		} catch (Exception e) {
		}
		

		model.addAttribute("mode", "reservation");
		model.addAttribute("startDto", startDto);
		model.addAttribute("endDto", endDto);
		model.addAttribute("pmStartDate", paramMap.get("pmStartDate"));
		model.addAttribute("pmStartDate2", sDate);
		model.addAttribute("prPersonnel", paramMap.get("prPersonnel"));
		model.addAttribute("dto", dto);
		model.addAttribute("start", start);
		model.addAttribute("end", end);

		return ".booking.reservation";
	}

	@RequestMapping(value = "reservation", method = RequestMethod.POST)
	public String reservationSubmit(
			Booking dto, 
			HttpSession session
			) {
		SessionInfo info = (SessionInfo) session.getAttribute("crew");
		int prSeq = 0;
		try {
			dto.setCrewId(info.getCrewId());
			prSeq = service.insertReservation(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/booking/receipt?prSeq=" + prSeq;
	}

	@RequestMapping(value = "receipt") // 영수증
	public String receipt(@RequestParam int prSeq, HttpSession session, Model model) {
		SessionInfo info = (SessionInfo) session.getAttribute("crew");
		Map<String, Object> map = new HashMap<>();
		map.put("prSeq", prSeq);
		map.put("crewId", info.getCrewId());
		try {

			List<Booking> list = service.readReservation(map);
			List<Booking> list1 = service.readReservation(map);
			Booking startDto = null, endDto = null;
			Booking start = null, end = null;
			for (Booking dto : list) {
				if (Integer.parseInt(dto.getTrainCode()) % 2 == 0) {
					startDto = dto;
				} else {
					endDto = dto;
				}
			}
			for (Booking vo : list1) {
				if (Integer.parseInt(vo.getTrainCode()) % 2 == 0) {
					start = vo;
					start = service.readtrainlist(start);
					start.setPrAddPrice(service.readsPay(start));
				} else {
					end = vo;
					end = service.readtrainlist(end);
					end.setPrAddPrice(service.readsPay1(end));
				}
			}

			startDto.setStartStation(service.readStartStation(startDto.getStartStation()));
			startDto.setEndStation(service.readEndStation(startDto.getEndStation()));
			endDto.setStartStation(service.readStartStation(endDto.getStartStation()));
			endDto.setEndStation(service.readEndStation(endDto.getEndStation()));

			model.addAttribute("prSeq", prSeq);
			model.addAttribute("startDto", startDto);
			model.addAttribute("endDto", endDto);
			model.addAttribute("start", start);
			model.addAttribute("end", end);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return ".booking.receipt";
	}

	@RequestMapping(value = "paymentSuccess") // 결제폼
	public String paymentForm(@RequestParam int prSeq, HttpSession session, Model model) {
		SessionInfo info = (SessionInfo) session.getAttribute("crew");
		Map<String, Object> map = new HashMap<>();
		map.put("prSeq", prSeq);
		map.put("crewId", info.getCrewId());
		try {
			List<Booking> list = service.readReservation(map);
			List<Booking> list1 = service.readReservation(map);
			Booking startDto = null, endDto = null;
			Booking start = null, end = null;
			for (Booking dto : list) {
				if (Integer.parseInt(dto.getTrainCode()) % 2 != 0) {
					startDto = dto;
				} else {
					endDto = dto;
				}
			}
			startDto.setStartStation(service.readStartStation(startDto.getStartStation()));
			startDto.setEndStation(service.readEndStation(startDto.getEndStation()));
			endDto.setStartStation(service.readStartStation(endDto.getStartStation()));
			endDto.setEndStation(service.readEndStation(endDto.getEndStation()));

			for (Booking vo : list1) {
				if (Integer.parseInt(vo.getTrainCode()) % 2 != 0) {
					start = vo;
					start = service.readtrainlist(start);
				} else {
					end = vo;
					end = service.readtrainlist(end);
				}
			}
			
			service.paymentSuccess(prSeq);

			model.addAttribute("startDto", startDto);
			model.addAttribute("endDto", endDto);
			model.addAttribute("start", start);
			model.addAttribute("end", end);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ".booking.paymentSuccess";
	}

	@RequestMapping(value = "delete")
	public String cancleReservation(@RequestParam int prSeq, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("crew");
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("crewId", info.getCrewId());
			map.put("prSeq", prSeq);
			service.deleteReservation(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/travel/main";
	}

	
	
	@RequestMapping("seat")
	public String seatForm(@RequestParam Map<String, String> map, Model model) {
		if (map.get("tCategory").equals("all")) {
			map.put("tCategory", "KTX"); // 수정필요
		} else if (map.get("tCategory").equals("KTX")) {
			map.put("tCategory", "KTX");
		} else if (map.get("tCategory").equals("ITX")) {
			map.put("tCategory", "ITX");
		} else if (map.get("tCategory").equals("mugunghwa")) {
			map.put("tCategory", "mugunghwa");
		}
		Seat dto = new Seat();
		if (map.get("firstPage").equals("true")) {
			String roomFirst = service1.roomFirst(map);
			dto.setRoomNum(Integer.parseInt(roomFirst));
			map.put("roomNum", roomFirst);
		} else {
			dto.setRoomNum(Integer.parseInt(map.get("roomNum")));
		}
		dto = service1.readSeat(map);
		List<Seat> list = service1.listSeat(map);

		// 해당 날짜, 기차코드, 칸번호에 해당하는 예약된 좌석 가져와서 넘겨줌.
		// (jsp에서는 넘겨준 좌석과 해당 표시하려는 좌석이 같으면 회색좌석으로 뜨게 처리)
		map.put("seatColumn", Integer.toString(dto.getSeatColumn()));
		List<String> rvlist = service1.listReservedSeat(map);

		// 정원초과인 칸번호 가져오기
		List<Integer> fullSeatlist = service1.fullSeat(map);

		model.addAttribute("list", list);
		model.addAttribute("dto", dto);
		model.addAttribute("map", map);
		model.addAttribute("rvlist", rvlist); // 이미 예약된 좌석 리스트
		model.addAttribute("fullSeatlist", fullSeatlist); // 정원초과 칸번호 리스트
		return "booking/seat";
	}

	@RequestMapping("confirm")
	public String confirm(@RequestParam Map<String, String> map, Model model) {
		if (map.get("directRv").equals("true")) {
			if (map.get("tCategory").equals("all")) {
				map.put("tCategory", "KTX"); // 수정필요
			} else if (map.get("tCategory").equals("KTX")) {
				map.put("tCategory", "KTX");
			} else if (map.get("tCategory").equals("ITX")) {
				map.put("tCategory", "ITX");
			} else if (map.get("tCategory").equals("mugunghwa")) {
				map.put("tCategory", "mugunghwa");
			}

			// 기차칸
			String roomNum = service1.roomFirst(map);
			map.put("roomNum", roomNum);
			// 좌석
			List<String> seatList = service1.unReservedSeat(map);
			int i = 1;
			for (String seat : seatList) {
				map.put("seatNum" + i, seat);
				i++;
			}
		}

		// 좌석을 list에 담아준다.
		List<ReservedSeat> seatList = new ArrayList<>();
		int total = Integer.parseInt(map.get("total"));

		// 승객유형
		int adult = Integer.parseInt(map.get("adult"));
		int child = Integer.parseInt(map.get("child"));
		int oldMan = Integer.parseInt(map.get("oldMan"));

		int seatType[] = { adult, child, oldMan };
		List<String> seatTypelist = new ArrayList<>();

		for (int i = 0; i < seatType.length; i++) {
			for (int j = 0; j < seatType[i]; j++) {
				String name = "";
				switch (i) {
				case 0:
					name = "성인";
					break;
				case 1:
					name = "어린이";
					break;
				case 2:
					name = "경로";
					break;
				}
				seatTypelist.add(name);
			}
		}


		model.addAttribute("map", map);
		model.addAttribute("seatList", seatList);
		return "/booking/reservation";
	}

}
