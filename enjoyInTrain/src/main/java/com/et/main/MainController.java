package com.et.main;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.et.notice.Notice;
import com.et.notice.NoticeService;
import com.et.reservation.ReservationService;
import com.et.reservation.Station;
import com.et.travel.Travel;
import com.et.travel.TravelService;

@Controller("mainController")
public class MainController {
	
	@Autowired
	private NoticeService service;
	
	@Autowired
	private ReservationService rsservice;
	
	@Autowired
	private TravelService tService;
	
	@RequestMapping("/main")
	public String main(
			@RequestParam(value="page", defaultValue="1") int current_page,
			Model model, HttpServletRequest req) {
		
		// travel 
		List<Travel> travelList = null;
		try {
			travelList = tService.randomMain();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("travelList",travelList);

		// notice 페이징, list
		Map<String, Object> map = new HashMap<>();
        map.put("condition", "noticeTitle");
        map.put("keyword", "");
        map.put("offset", 0);
        map.put("rows", 4);
        
		List<Notice> list = service.listNotice(map);
		
		String cp=req.getContextPath();
        String articleUrl = cp+"/notice/article?page=" + current_page;
        
        //기차역 가져오기(모달창)
        List<Station> stationList=rsservice.listStation();
        
        //기본으로 text박스에 출력해줄 역 가져오기
      	Map<String, String> defaultst=rsservice.defaultSt();
      	
      	//오늘날짜
      	Calendar cal=Calendar.getInstance();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		String day=sdf.format(cal.getTime());
		cal.set(Calendar.DATE, cal.get(Calendar.DATE)+10);
		String maxday=sdf.format(cal.getTime());

		model.addAttribute("stationList",stationList);
		model.addAttribute("firstSt",defaultst.get("firstSt"));
		model.addAttribute("lastSt",defaultst.get("lastSt"));
		model.addAttribute("day",day);
		model.addAttribute("maxday",maxday);
		model.addAttribute("list",list);
		model.addAttribute("page", current_page);	
		model.addAttribute("articleUrl", articleUrl);
		
		return ".main.main";
	}
}
