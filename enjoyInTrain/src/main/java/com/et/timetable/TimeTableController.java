package com.et.timetable;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.et.common.MyUtil;

@Controller("timetable.timeTableController")
public class TimeTableController {
	@Autowired
	private TimeTableService timeTableService;
	@Autowired
	private MyUtil myUtil;
	
	
	@RequestMapping(value="/admin/timetable/main")
	public String main() throws Exception {
		return ".admin.timetable.main";
	}
	
	@RequestMapping(value="/admin/timetable/list")
	@ResponseBody
	public Map<String, Object> list(
			@RequestParam(value="pageNo", defaultValue="1") int current_page
			) throws Exception {
		
		Map<String, Object> model=new HashMap<>();
		
		int rows=10;
		int dataCount;
		int total_page;
		
		dataCount=timeTableService.dataCount();
		total_page=myUtil.pageCount(rows, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
		Map<String, Object> map = new HashMap<>();
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        
        List<TimeTable> list = timeTableService.listTimeTable(map);
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.put("list", list);
		model.put("dataCount", dataCount);
		model.put("pageNo", current_page);
		model.put("total_page", total_page);
		model.put("paging", paging);
		
		return model;
	}
	
	@RequestMapping(value="/admin/timetable/insert", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insert(TimeTable dto) throws Exception {
		
		String state="true";
		try {
			timeTableService.insertTimeTable(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/admin/timetable/update", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> update(TimeTable dto) throws Exception{
		String state = "true";
		
		try {
			timeTableService.updateTimeTable(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value="/admin/timetable/delete", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(@RequestParam String scode) throws Exception {
		String state="true";
		try {
			timeTableService.deleteTimeTable(scode);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
}
