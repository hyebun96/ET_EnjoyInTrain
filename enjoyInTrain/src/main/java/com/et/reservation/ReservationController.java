package com.et.reservation;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
		
		//전체 칸 매진인 기차코드 가져오기
		Map<String, String> map=new HashMap<String, String>();
		map.put("day", dto.getDay());
		map.put("startSt", dto.getStartSt());
		map.put("endSt", dto.getEndSt());
		map.put("roomGrade", "일반실");
		List<Integer> general=service.fulltrCode(map);
		map.put("roomGrade", "특실");
		List<Integer> special=service.fulltrCode(map);
		
		
		model.addAttribute("list",list);
		model.addAttribute("rsDto",dto);
		model.addAttribute("general",general);
		model.addAttribute("special",special);
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
		if(map.get("firstPage").equals("true")) {
			String roomFirst=service.roomFirst(map);
			dto.setRoomNum(Integer.parseInt(roomFirst));
			map.put("roomNum", roomFirst);
		}else {
			dto.setRoomNum(Integer.parseInt(map.get("roomNum")));
		}
		dto=service.readSeat(map);
		List<Seat> list=service.listSeat(map);
		
		//해당 날짜, 기차코드, 칸번호에 해당하는 예약된 좌석 가져와서 넘겨줌. 
		//(jsp에서는 넘겨준 좌석과 해당 표시하려는 좌석이 같으면 회색좌석으로 뜨게 처리)
		map.put("seatColumn", Integer.toString(dto.getSeatColumn()));
		List<String> rvlist=service.listReservedSeat(map);
		
		//정원초과인 칸번호 가져오기
		List<Integer> fullSeatlist=service.fullSeat(map);
		
		model.addAttribute("list",list);
		model.addAttribute("dto",dto);
		model.addAttribute("map",map);
		model.addAttribute("rvlist",rvlist);  //이미 예약된 좌석 리스트
		model.addAttribute("fullSeatlist",fullSeatlist);  //정원초과 칸번호 리스트
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
			@RequestParam Map<String,String> map,
			final RedirectAttributes reAttr
			) {
		service.reservation(rv, seat, map);
		
		reAttr.addFlashAttribute("rv",rv);
		reAttr.addFlashAttribute("seat",seat);
		reAttr.addFlashAttribute("map",map);
		
		return "redirect:/reservation/complete";
	}
	
	@RequestMapping("complete")
	public String complete(
			@ModelAttribute("rv") Reservation rv,
			@ModelAttribute("seat") ReservedSeat seat,
			@ModelAttribute("map") Map<String,String> map
			) {

		if(map==null) {
			return "redirect:/reservation/main";
		}
		
		String s = "";
		String st = "";
		String sp = "";
		Iterator<String> it=map.keySet().iterator();
		while(it.hasNext()) {
			String key=it.next();
			if(key.startsWith("seatNum")) {
				s+=map.get(key)+" ";
			}
			if(key.startsWith("seatType")) {
				st+=map.get(key)+" ";
			}
			if(key.startsWith("seatPay")) {
				sp+=map.get(key)+" ";
			}
		}
		
		map.put("seatNum", s);
		map.put("seatType", st);
		map.put("seatPay", sp);
		
		return ".reservation.complete";
	}
}
