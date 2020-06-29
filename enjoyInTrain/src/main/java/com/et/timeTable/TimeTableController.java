package com.et.timeTable;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.et.common.MyUtil;

@Controller("timeTable.timeTableController")
@RequestMapping("/admin/timeTable/*")
public class TimeTableController {
	@Autowired
	private MyUtil myutil;
	
	@Autowired
	private TimeTableService service;
	
	@RequestMapping(value="list")
	public String list(@RequestParam(value="page", defaultValue="1") int page,
			Model model) {
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		

		Map<String, Object> map = new HashMap<String, Object>();
		
		dataCount = service.timetableCount();
		if(dataCount!=0) {
			total_page = myutil.pageCount(rows, dataCount);
		}
		

		if(total_page<page) {
			page=total_page;
		}
		

		
		int offset = (page-1)*rows;
		if(offset<0) offset=0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		
		String paging = myutil.paging(page, total_page);
		
        model.addAttribute("page", page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
		
		return ".admin.timetable.list";
	}
	
	@RequestMapping(value="created", method=RequestMethod.POST)
	public String createdForm(
			TimeTable dto
			) throws Exception{
		
		try {
			service.insertTimeTable(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:admin/timetable/list";
	}
	
	
}
