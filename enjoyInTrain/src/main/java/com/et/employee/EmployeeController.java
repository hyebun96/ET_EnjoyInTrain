package com.et.employee;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.et.common.MyUtil;

@Controller("employee.employeeController")
@RequestMapping("/employee/*")
public class EmployeeController {
	
	@Autowired
	private EmployeeService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("list")
	public String list(
			@RequestParam(value="page",defaultValue ="1") int current_page,
			@RequestParam(defaultValue="1") int emcheck,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception{
		
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page=0;
		int dataCount = 0;
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword=URLDecoder.decode(keyword,"UTF-8");
		}
		
		//전체페이지수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("emcheck", emcheck);
		map.put("condition", condition);
		map.put("keyword", keyword);
		dataCount = service.dataCount(map);
		if(dataCount !=0) {
			total_page=myUtil.pageCount(rows, dataCount);
		}
		
		 // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if(total_page < current_page) {
			current_page = total_page;
		}
		
		int offset = (current_page-1) * rows;
		if(offset < 0) {
			offset=0;
		}
		map.put("offset", offset);
		map.put("rows", rows);
		
		//글리스트
		List<Employee> list = service.listEmployee(map);
		int listNum,n =0;
		for(Employee dto : list) {
			listNum = dataCount-(offset +n);
			dto.setListNum(listNum);
			n++;
		}
		
		String query = "";
        String listUrl = cp+"/employee/list?emcheck="+emcheck;
        String articleUrl = cp+"/employee/update?emcheck="+emcheck+"&page=" + current_page;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl += "&"+query;
        	articleUrl +="&"+query;
        }
        
        String paging = myUtil.paging(current_page, total_page, listUrl);
	        
		model.addAttribute("list", list);
		model.addAttribute("emcheck", emcheck);
        model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".employee.list";
	}
	

	@RequestMapping(value="create",  method=RequestMethod.GET)
	public String createdForm(
			@RequestParam(defaultValue="1") int emcheck,
			Model model
			) throws Exception{
		
		List<Employee> list = service.listPosition();

		model.addAttribute("mode","create");
		model.addAttribute("emcheck",emcheck);
		model.addAttribute("ptCodelist",list);
		
		return ".employee.created";
	}
	
	@RequestMapping(value="create", method=RequestMethod.POST)
	public String createdSubmit(
			Employee dto,
			@RequestParam(defaultValue="1") int emcheck
			) throws Exception{
		
		try {
			service.insertEmployee(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/employee/list?emcheck="+emcheck;
	}
	
	@RequestMapping(value="update",  method=RequestMethod.GET)
	public String updateForm(
			Model model,
			@RequestParam int emCode,
			@RequestParam(defaultValue="1") int emcheck,
			@RequestParam String page
			) throws Exception{
		
		Employee dto = service.readEmployee(emCode);
		List<Employee> list = service.listPosition();
		
		
		model.addAttribute("dto",dto);
		model.addAttribute("page",page);
		model.addAttribute("emcheck",emcheck);
		model.addAttribute("mode","update");
		model.addAttribute("ptCodelist",list);

		
		return ".employee.created";
	}
	
	@RequestMapping(value="update",method=RequestMethod.POST)
	public String updateSubmit(
			Employee dto,
			@RequestParam int emcheck
			)throws Exception{
		
		try {
			service.updateEmployee(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/employee/list?emcheck="+emcheck;
	}
	
	@RequestMapping(value="catecreate",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> categorycreatedSubmit(
			Employee dto
			)throws Exception{
		
		String state = "true";
		try {
			service.insertCategory(dto);
			
		} catch (Exception e) {
			state = "false";
			e.printStackTrace();
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
}
