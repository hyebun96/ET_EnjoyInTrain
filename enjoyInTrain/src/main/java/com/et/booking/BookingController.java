package com.et.booking;

import java.util.ArrayList;
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
import com.et.reservation.Condition;
import com.et.reservation.Seat;
import com.et.reservation.Train;

@Controller("booking.bookingController")
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
		List<Booking> list1 = service.readPromotionDetail(paramMap);
		Booking startDto = null, endDto = null;
		Booking start = null, end = null;
		for(Booking dto : list) {
			if(Integer.parseInt(dto.getTrainCode())%2!=0) {
				startDto = dto;
			}
			else {
				endDto = dto;
			}
		}
		for(Booking vo : list1) {
			if(Integer.parseInt(vo.getTrainCode())%2!=0) {
				start = vo;
			}
			else {
				end = vo;
			}
		}
		startDto.setStartStation(service.readStartStation(startDto.getStartStation()));
		startDto.setEndStation(service.readEndStation(startDto.getEndStation()));			
		endDto.setStartStation(service.readStartStation(endDto.getStartStation()));
		endDto.setEndStation(service.readEndStation(endDto.getEndStation()));			

		start = service.readtrainlist(start);
		end = service.readtrainlist(end);
		SessionInfo info = (SessionInfo)session.getAttribute("crew");

		Map<String , Object> map = new HashMap<>();
		map.put("crewId", info.getCrewId());
		Booking dto=service.readCrew(map);
		
		model.addAttribute("mode", "reservation");
		model.addAttribute("startDto",startDto);
		model.addAttribute("endDto",endDto);
		model.addAttribute("pmStartDate",paramMap.get("pmStartDate"));
		model.addAttribute("prPersonnel", paramMap.get("prPersonnel"));
		model.addAttribute("dto", dto);
		model.addAttribute("start", start);
		model.addAttribute("end", end);
		
		return ".booking.reservation";
	}
	
	@RequestMapping(value="reservation", method=RequestMethod.POST)
	public String reservationSubmit(
			Booking dto,
			HttpSession session
			) {
		SessionInfo info = (SessionInfo)session.getAttribute("crew");
		int prSeq = 0;
		try {
			dto.setCrewId(info.getCrewId());
			prSeq = service.insertReservation(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/booking/receipt?prSeq="+prSeq;
	}
	
	
	@RequestMapping(value="receipt")			// 영수증
	public String receipt(
			@RequestParam int prSeq,
			HttpSession session,
			Model model
			) {
		SessionInfo info = (SessionInfo)session.getAttribute("crew");
		Map<String, Object> map = new HashMap<>();
		map.put("prSeq", prSeq);
		map.put("crewId", info.getCrewId());
		try {
			
			List<Booking> list = service.readReservation(map);
			List<Booking> list1 = service.readReservation(map);
			Booking startDto = null, endDto = null;
			Booking start = null, end = null;
			for(Booking dto : list) {
				if(Integer.parseInt(dto.getTrainCode())%2!=0) {
					startDto = dto;
				}
				else {
					endDto = dto;
				}
			}
			for(Booking vo : list1) {
				if(Integer.parseInt(vo.getTrainCode())%2!=0) {
					start = vo;
				}
				else {
					end = vo;
				}
			}
			
			startDto.setStartStation(service.readStartStation(startDto.getStartStation()));
			startDto.setEndStation(service.readEndStation(startDto.getEndStation()));			
			endDto.setStartStation(service.readStartStation(endDto.getStartStation()));
			endDto.setEndStation(service.readEndStation(endDto.getEndStation()));	
			
			start = service.readtrainlist(start);
			end = service.readtrainlist(end);
			model.addAttribute("prSeq", prSeq);
			model.addAttribute("startDto",startDto);
			model.addAttribute("endDto",endDto);
			model.addAttribute("start", start);
			model.addAttribute("end", end);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return ".booking.receipt";
	}
	
	
	@RequestMapping(value="paymentSuccess")			// 결제폼
	public String paymentForm(
			@RequestParam int prSeq,
			HttpSession session,
			Model model
			) {
		SessionInfo info = (SessionInfo)session.getAttribute("crew");
		Map<String, Object> map = new HashMap<>();
		map.put("prSeq", prSeq);
		map.put("crewId", info.getCrewId());
		try {
			List<Booking> list = service.readReservation(map);
			List<Booking> list1 = service.readReservation(map);
			Booking startDto = null, endDto = null;
			Booking start = null, end = null;
			for(Booking dto : list) {
				if(Integer.parseInt(dto.getTrainCode())%2!=0) {
					startDto = dto;
				}
				else {
					endDto = dto;
				}
			}
			startDto.setStartStation(service.readStartStation(startDto.getStartStation()));
			startDto.setEndStation(service.readEndStation(startDto.getEndStation()));			
			endDto.setStartStation(service.readStartStation(endDto.getStartStation()));
			endDto.setEndStation(service.readEndStation(endDto.getEndStation()));
			
			for(Booking vo : list1) {
				if(Integer.parseInt(vo.getTrainCode())%2!=0) {
					start = vo;
					start = service.readtrainlist(start);
				}
				else {
					end = vo;
					end = service.readtrainlist(end);
				}
			}
			
				model.addAttribute("startDto",startDto);
				model.addAttribute("endDto",endDto);
				model.addAttribute("start", start);
				model.addAttribute("end", end);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ".booking.paymentSuccess";
	}
	@RequestMapping(value="delete")
	public String cancleReservation(
			@RequestParam int prSeq,
			HttpSession session
			) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("crew");
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
//	
//	@RequestMapping(value="paymentSuccess", method=RequestMethod.POST)			// 결제완료
//	public String paymentSubmit() {
//		
//		try {
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		return "redirect:/travel/main";
//	}
//	
	@RequestMapping("seat")
	public String seatForm(
			@RequestParam Map<String, String> map,
			Condition rsDto,
			Model model
			) {		
		if(map.get("tCategory").equals("all")) {
			map.put("tCategory", "KTX");  //수정필요
		}else if(map.get("tCategory").equals("KTX")) {
			map.put("tCategory", "KTX");
		}else if(map.get("tCategory").equals("ITX")) {
			map.put("tCategory", "ITX");
		}else if(map.get("tCategory").equals("mugunghwa")) {
			map.put("tCategory", "mugunghwa");
		}
		Seat dto=new Seat();
		dto.setRoomNum(Integer.parseInt(map.get("roomNum")));
		dto=service.readSeat(map);
		List<Seat> list=service.listSeat(map.get("tCategory"));
		
		rsDto.setTotal(rsDto.getAdult()+rsDto.getChild()+rsDto.getSenior()+rsDto.getDisabled1()+rsDto.getDisabled2());
		
		List<Train> listtrain=new ArrayList<>();
		listtrain=service.listTrain(rsDto);
		for(Train train:listtrain) {
			//소요시간
			train.setTotalTime(service.totalTime(train));
		}
		
		model.addAttribute("list",list);
		model.addAttribute("listtrain",listtrain);
		model.addAttribute("rsDto",dto);
		model.addAttribute("dto",dto);
		model.addAttribute("map",map);
		return "booking/seat";
	}
}
