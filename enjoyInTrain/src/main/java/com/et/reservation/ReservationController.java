package com.et.reservation;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.et.crew.SessionInfo;

@Controller("reservation.reservationController")
@RequestMapping("/reservation/*")
public class ReservationController {
	@Autowired
	private ReservationService service;
	
	@RequestMapping("main")
	public String main(
			Condition dto,
			@RequestParam(defaultValue="false") String directRv,
			Model model) {
		//기본으로 text박스에 출력해줄 역 가져오기
		Map<String, String> map=service.defaultSt();
		
		//모든 역 가져오기
		List<Station> list=service.listStation();
		
		//날짜(오늘날짜부터 10일후까지)
		List<String> daylist=new ArrayList<String>();
		Calendar cal=Calendar.getInstance();  //오늘
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd(E)");
		String d="";
		for(int i=0; i<=10; i++) {
			d=sdf.format(cal.getTime());
			daylist.add(d);
			cal.set(Calendar.DATE, cal.get(Calendar.DATE)+1);
		}
		
		if(directRv.equals("true")) {  //바로예약일시
			String day[]=dto.getDay().split("-");
			cal.set(Calendar.YEAR, Integer.parseInt(day[0]));
			cal.set(Calendar.MONTH, Integer.parseInt(day[1])-1);
			cal.set(Calendar.DATE, Integer.parseInt(day[2]));
			d=sdf.format(cal.getTime());
			dto.setDay(d);
		}
		model.addAttribute("directRv",directRv);  //바로예약일시
		model.addAttribute("dto",dto);  //바로예약일시
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
		
		//선택한 사람수(total)보다 적은 좌석개수를 가지고 있는 기차코드를 가져옴
		//좌석부족 출력해줘야함
		
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
			HttpSession session,
			Model model
			) {
		if(map.get("directRv").equals("true")) {
			if(map.get("tCategory").equals("all")) {
				map.put("tCategory", "KTX");  //수정필요
			}else if(map.get("tCategory").equals("KTX")) {
				map.put("tCategory", "KTX");
			}else if(map.get("tCategory").equals("ITX")) {
				map.put("tCategory", "ITX");
			}else if(map.get("tCategory").equals("mugunghwa")) {
				map.put("tCategory", "mugunghwa");
			}
			
			//기차칸
			String roomNum=service.roomFirst(map);
			map.put("roomNum", roomNum);
			//좌석
			List<String> seatList=service.unReservedSeat(map);  
			int i=1;
			for(String seat:seatList) {
				map.put("seatNum"+i, seat);
				i++;
			}
		}
		
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
			int dc=(int)(rvSeat.getSeatPay()*service.readDisCount(rvSeat.getSeatType())*0.01);
			rvSeat.setDisCount(dc);
			seatList.add(rvSeat);
			totalPay+=rvSeat.getSeatPay()-dc;
		}
		map.put("totalPay", Integer.toString(totalPay));
		
		SessionInfo info=(SessionInfo)session.getAttribute("crew");
		if(info==null) {
			map.put("tel", map.get("tel1")+"-"+map.get("tel2")+"-"+map.get("tel3"));
		}
		
		//해당아이디의 현재 포인트 가져오기
		int totalPoint=0;
		if(info!=null) {
			totalPoint=service.totalPoint(info.getCrewId());
		}
		
		model.addAttribute("totalPoint",totalPoint);
		model.addAttribute("map",map);
		model.addAttribute("seatList",seatList);
		
		return ".reservation.confirm";
	}
	
	@RequestMapping("reservation")
	public String reservation(
			Reservation rv,
			ReservedSeat seat,
			@RequestParam Map<String,String> map,
			HttpSession session,
			final RedirectAttributes reAttr
			) {
		//회원이면 아이디 저장. (회원아니면 null)
		SessionInfo info=(SessionInfo)session.getAttribute("crew");
		UnCrew unCrew=new UnCrew();
		if(info!=null) {
			rv.setCrewId(info.getCrewId());
		}else {
			unCrew.setName(map.get("name"));
			unCrew.setPassword(map.get("password"));
			unCrew.setEmail(map.get("email"));
			unCrew.setTel(map.get("tel"));
		}
		service.reservation(rv, seat, map, unCrew);
		
		reAttr.addFlashAttribute("rv",rv);
		reAttr.addFlashAttribute("seat",seat);
		reAttr.addFlashAttribute("map",map);
		
		return "redirect:/reservation/complete";
	}
	
	@RequestMapping("complete")
	public String complete(
			@ModelAttribute("rv") Reservation rv,
			@ModelAttribute("seat") ReservedSeat seat,
			@ModelAttribute("map") Map<String,String> map,
			Model model
			) {
		
		if(map==null) {
			return "redirect:/reservation/main";
		}

		String seatNum = "";
		String seatType = "";
		String seatPay = "";
		String disCount = "";


		Iterator<String> it=map.keySet().iterator();
		
		while(it.hasNext()) {
	
			String key=it.next();
			if(key.startsWith("seatNum")) {
				seatNum+=map.get(key)+" ";
			}
			if(key.startsWith("seatType")) {
				seatType+=map.get(key)+" ";
			}
			if(key.startsWith("seatPay")) {
				seatPay+=map.get(key)+" ";
			}
			if(key.startsWith("disCount")) {
				disCount+=map.get(key)+" ";
			}

		}
		
		seatNum = seatNum.trim();
		seatType = seatType.trim();
		seatPay = seatPay.trim();
		disCount = disCount.trim();

		
		List<Ticket> list = new ArrayList<>();
		
		try {
			String[]ss1=seatNum.split(" ");
			String[]ss2=seatType.split(" ");
			String[]ss3=seatPay.split(" ");
			String[]ss4=disCount.split(" ");
			
			for(int i=0; i<ss1.length; i++) {
				Ticket ticket = new Ticket();
				
				ticket.setSeatNum(ss1[i]);
				ticket.setSeatType(ss2[i]);
				ticket.setSeatPay(Integer.parseInt(ss3[i]));
				ticket.setDisCount(Integer.parseInt(ss4[i]));

				list.add(ticket);
			}
			
		} catch (Exception e) {
		}
		
		map.put("seatNum", seatNum);
		map.put("seatType", seatType);
		map.put("seatPay", seatPay);
		map.put("disCount", disCount);

		model.addAttribute("map",map);
		model.addAttribute("list",list);
		
		return ".reservation.complete";
	}
	
	@RequestMapping("uncrew")
	public String uncrew(
			@RequestParam Map<String, String> map,
			Model model
			) {
		model.addAttribute("map",map);
		return ".reservation.uncrew";
	}
	
	@RequestMapping("detail")
	public String detail(
			HttpSession session,
			Model model
			) {
		
		SessionInfo info=(SessionInfo)session.getAttribute("crew");
		
		List<Reservation> list=service.readDetail(info.getCrewId());
		
		model.addAttribute("list",list);
		return ".reservation.detail";
	}
	
	@RequestMapping("uncrew2")
	public String uncrewdetail(
			) {
		return ".reservation.uncrew2";
	}
	
	@RequestMapping("refundForm")
	public String refundForm(
			@RequestParam int trCode,
			Model model
			) {
		List<Reservation> list=service.listReservationDetail(trCode);
		
		model.addAttribute("list",list);
		model.addAttribute("trCode",trCode);
		return ".reservation.refund";
	}
	
	@RequestMapping("requestrefund")
	public String requestRefund(
			@RequestParam List<Integer> rsseatCode,
			@RequestParam int trCode,
			Model model
			) {
		List<Reservation> list=service.listSeatDetail(rsseatCode);
		
		Reservation rv=new Reservation();
		for(Reservation dto:list) {
			rv.setTrDate(dto.getTrDate());
			rv.setTrCategory(dto.getTrCategory());
			rv.setTrainCode(dto.getTrainCode());
			rv.setStartCode(dto.getStartCode());
			rv.setEndCode(dto.getEndCode());
			rv.setStTime(dto.getStTime());
			rv.setEndTime(dto.getEndTime());
			rv.setTrPrice(dto.getTrPrice());
		}
		
		model.addAttribute("trCode",trCode);
		model.addAttribute("rv",rv);
		model.addAttribute("list",list);
		return ".reservation.requestrefund";
	}
	
	@RequestMapping("refund")
	public String refund(
			@RequestParam List<Integer> rsseatCode,
			@RequestParam int trCode
			) {
		service.refund(rsseatCode, trCode);
		return "redirect:/reservation/refundcomplete";
	}
	
	@RequestMapping("refundcomplete")
	public String refundcomplete() {
		return ".reservation.refundcomplete";
	}
	
	@RequestMapping("unCrewSubmit")
	public String unCrewSubmit(
			UnCrew unCrew,
			Model model
			) {
		int trCode=service.readUnCrew(unCrew);
		
		List<Reservation> list=service.listReservationDetail(trCode);
		
		model.addAttribute("list",list);
		model.addAttribute("trCode",trCode);
		return ".reservation.refund";
	}
}
