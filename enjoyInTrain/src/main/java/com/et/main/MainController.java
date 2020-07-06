package com.et.main;

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
import com.et.travel.Travel;
import com.et.travel.TravelService;

@Controller("mainController")
public class MainController {
	
	@Autowired
	private NoticeService service;
	
	@Autowired
	private TravelService tService;
	
	@RequestMapping("/main")
	public String main(
			@RequestParam(value="page", defaultValue="1") int current_page,
			Model model, HttpServletRequest req) {
		
		// notice 페이징, list
		Map<String, Object> map = new HashMap<>();
        map.put("condition", "noticeTitle");
        map.put("keyword", "");
        map.put("offset", 0);
        map.put("rows", 3);
        
		List<Notice> list = service.listNotice(map);
		
		String cp=req.getContextPath();
        String articleUrl = cp+"/notice/article?page=" + current_page;
		
		model.addAttribute("list",list);
		model.addAttribute("page", current_page);	
		model.addAttribute("articleUrl", articleUrl);
		
		
		// travel 
		List<Travel> travelList = null;
		try {
			travelList = tService.randomMain();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("travelList",travelList);
		
		return ".main.main";
	}
	
	
	
	
	
	
	
	
}
