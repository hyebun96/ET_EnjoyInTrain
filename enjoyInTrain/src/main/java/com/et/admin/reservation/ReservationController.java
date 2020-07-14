package com.et.admin.reservation;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.et.common.MyUtil;
import com.et.crew.SessionInfo;
import com.et.reservation.Reservation;
import com.et.reservation.ReservationService;

@Controller("admin.reservation.reservationController")
@RequestMapping("/admin/reservation/*")
public class ReservationController {
	@Autowired
	private ReservationService service;
	
	@Autowired
	private MyUtil util;
	
	@RequestMapping("list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="20") int rows,
			HttpServletRequest req,
			Model model) {
		//페이징
		int total_page;
		int dataCount;
		
		dataCount=service.dataCount();
		total_page=util.pageCount(rows, dataCount);
		
		if(total_page<current_page) {
			current_page=total_page;
		}
		
		//
		Map<String, Object> map=new HashMap<String, Object>();
		int offset=(current_page-1)*rows;
		if(offset<0) offset=0;
		map.put("offset",offset);
		map.put("rows",rows);
		
		List<Reservation> list=service.listAll(map);
		List<Reservation> seatList=service.listAllSeat();
		
		for(Reservation dto:list) {
			int cnt=0;
			int refundCnt=0;
			for(Reservation seat:seatList) {
				//trCode에 해당하는 좌석개수
				if(dto.getTrCode()==seat.getTrCode()) {
					if(seat.getRefund()==1) {
						refundCnt++;
					}
					cnt++;
				}
			}
			if(cnt==refundCnt) {
				dto.setRefund(1);
			}
		}
		
		//페이징
		String cp=req.getContextPath();
		String query="rows="+rows;
		String listUrl=cp+"/admin/reservation/list";
		listUrl+="?"+query;
		String paging=util.paging(current_page, total_page, listUrl);
		
		model.addAttribute("seatList",seatList);
		model.addAttribute("list",list);
		//페이징
		model.addAttribute("rows",rows);
		model.addAttribute("paging",paging);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("page",current_page);
		model.addAttribute("query",query);
		return ".admin.reservation.list";
	}
	
	@RequestMapping("refund")
	public String refund(
			@RequestParam int rsseatCode,
			@RequestParam int trCode,
			@RequestParam(defaultValue="1") int page,
			@RequestParam(defaultValue="20") int rows,
			HttpSession session
			) {
		List<Integer> list=new ArrayList<Integer>();
		list.add(rsseatCode);
		
		SessionInfo info=(SessionInfo)session.getAttribute("crew");
		String crewId="";
		if(info!=null) {
			crewId=info.getCrewId();
		}
		service.refund(list, trCode, crewId);
		return "redirect:/admin/reservation/list?page="+page+"&rows="+rows;
	}
}
