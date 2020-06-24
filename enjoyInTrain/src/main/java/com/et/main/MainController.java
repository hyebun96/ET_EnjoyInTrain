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

@Controller("mainController")
public class MainController {
	
	@Autowired
	private NoticeService service;
	
	@RequestMapping("/main")
	public String main(
			@RequestParam(value="page", defaultValue="1") int current_page,
			Model model, HttpServletRequest req) {
		
		Map<String, Object> map = new HashMap<>();
        map.put("condition", "noticeTitle");
        map.put("keyword", "");
        map.put("offset", 0);
        map.put("rows", 5);
        
		List<Notice> list = service.listNotice(map);
		
		String cp=req.getContextPath();
        String listUrl = cp+"/notice/list";
        String articleUrl = cp+"/notice/article?page=" + current_page;
		
		model.addAttribute("list",list);
		model.addAttribute("page", current_page);	
		model.addAttribute("articleUrl", articleUrl);
		
		return ".main.main";
	}
	
	
	
	
	
	
	
	
}
