package com.et.reservation;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("reservation.reservationController")
@RequestMapping("/reservation/*")
public class ReservationController {
	@Autowired
	private ReservationService service;
	
	@RequestMapping("main")
	public String main(Model model) {
		//기본으로 text박스에 출력해줄 역 가져오기
		Map<String, String> map=service.defaultSt();
		
		//모든 역 가져오기
		List<Station> list=service.listStation();
		
		//날짜(오늘날짜부터 10일후까지)
		List<String> daylist=new ArrayList<String>();
		Calendar cal=Calendar.getInstance();  //오늘
		String d="";
		for(int i=0; i<10; i++) {
			d=cal.get(Calendar.YEAR)+"/"+(cal.get(Calendar.MONTH)+1)+"/"+cal.get(Calendar.DATE)+"(";
			//요일(일~토)(1~7)
			switch(cal.get(Calendar.DAY_OF_WEEK)) {
				case 1: d+="일"; break;
				case 2: d+="월"; break;
				case 3: d+="화"; break;
				case 4: d+="수"; break;
				case 5: d+="목"; break;
				case 6: d+="금"; break;
				case 7: d+="토"; break;
			}
			d+=")";
			daylist.add(d);
			cal.set(Calendar.DATE, cal.get(Calendar.DATE)+1);
		}
		
		model.addAttribute("list",list);
		model.addAttribute("daylist",daylist);
		model.addAttribute("stationCount",14);
		model.addAttribute("firstSt",map.get("firstSt"));
		model.addAttribute("lastSt",map.get("lastSt"));
		return ".reservation.main";
	}
	
	@RequestMapping("list")
	public String list(
			Condition dto,
			Model model
			) {
		if(dto.gettCategory().equals("all")) {
			dto.settCategory("KTX");  //수정필요
		}else if(dto.gettCategory().equals("KTX")) {
			dto.settCategory("KTX");
		}else if(dto.gettCategory().equals("ITX")) {
			dto.settCategory("ITX");
		}else if(dto.gettCategory().equals("mugunghwa")) {
			dto.settCategory("mugunghwa");
		}
		
		//전체인원
		dto.setTotal(dto.getAdult()+dto.getChild()+dto.getSenior()+dto.getDisabled1()+dto.getDisabled2());
		
		List<Train> list=new ArrayList<>();
		list=service.listTrain(dto);
		for(Train train:list) {
			//소요시간
			train.setTotalTime(service.totalTime(train));
		}
		
		model.addAttribute("list",list);
		model.addAttribute("rsDto",dto);
		return "reservation/list";
	}
	
	@RequestMapping("seat")
	public String seatForm(
			@RequestParam Map<String, String> map,
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
		
		model.addAttribute("list",list);
		model.addAttribute("dto",dto);
		model.addAttribute("map",map);
		return "reservation/seat";
	}
	
	@RequestMapping("confirm")
	public String confirm(
			@RequestParam Map<String, String> map,
			Model model
			) {
		//좌석을 list에 담아준다.
		List<ReservedSeat> seatList=new ArrayList<>();
		
		
		int total=Integer.parseInt(map.get("total"));
		
		//승객유형
		int adult=Integer.parseInt(map.get("adult"));
		int child=Integer.parseInt(map.get("child"));
		int senior=Integer.parseInt(map.get("senior"));
		int disabled1=Integer.parseInt(map.get("disabled1"));
		int disabled2=Integer.parseInt(map.get("disabled2"));
		
		int seatType[]={adult,child,senior,disabled1,disabled2};
		List<String> seatTypelist=new ArrayList<>();
		
		for(int i=0; i<seatType.length; i++) {
			for(int j=0; j<seatType[i]; j++) {
				String name="";
				switch (i) {
					case 0: name="성인"; break;
					case 1: name="어린이"; break;
					case 2: name="경로"; break;
					case 3: name="중증장애인"; break;
					case 4: name="경증장애인"; break;
				}
				seatTypelist.add(name);
			}
		}
		
		int totalPay=0;
		for(int i=1; i<=total; i++) {
			ReservedSeat rvSeat=new ReservedSeat();
			rvSeat.setSeatNum(map.get("seatNum"+i));
			rvSeat.setSeatType(seatTypelist.get(i-1));
			rvSeat.setSeatPay(service.readsPay(map));
			seatList.add(rvSeat);
			totalPay+=rvSeat.getSeatPay();
		}
		map.put("totalPay", Integer.toString(totalPay));
		
		model.addAttribute("map",map);
		model.addAttribute("seatList",seatList);
		return ".reservation.confirm";
	}
	
	@RequestMapping("reservation")
	public String reservation(
			Reservation rv,
			ReservedSeat seat,
			@RequestParam Map<String,String> map
			) {
		service.reservation(rv, seat, map);
		return "redirect:/reservation/complete";
	}
	
	@RequestMapping("complete")
	public String complete() {
		return ".reservation.complete";
	}
}
