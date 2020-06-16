package com.et.faq;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.et.crew.SessionInfo;

@Controller("faq.FaQController")
@RequestMapping("/faq/*")
public class FaQController {

	@Autowired
	private FaQService service;
	
	@RequestMapping("list")
	public String list(
			@RequestParam(defaultValue="0") int group,
			Model model) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("group", group);
		
		List<FAQ> groupList = service.listCategory();
		
		List<FAQ> list = service.listQnA(map);
		
		for(FAQ dto : list) {
			dto.setFaqContent(dto.getFaqContent().replaceAll("\n", "<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"));
			
		}
		
		model.addAttribute("list",list);
		model.addAttribute("group", group);
		model.addAttribute("groupList", groupList);		
		
		return ".faq.list";
	}
	
	@RequestMapping(value="created", method = RequestMethod.GET)
	public String createdForm(
			Model model) throws Exception{
		
		List<FAQ> groupList = service.listCategory();
		
		model.addAttribute("mode","created");
		model.addAttribute("groupList",groupList);
		
		return ".faq.created";
	}
	
	@RequestMapping(value="created", method = RequestMethod.POST)
	public String createdSubmit(
			FAQ dto,
			@RequestParam(defaultValue="0") int group
			,HttpSession session) throws Exception{
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			dto.setEmCode(1);
			
			service.insertFAQ(dto);
		} catch (Exception e) {
			throw e;
		}
		return "redirect:/faq/list?group="+group;
	}
	
	@RequestMapping(value="update", method = RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam(defaultValue="0") int group,
			 HttpSession session,
			Model model) throws Exception{
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		FAQ dto = service.readFAQ(num);
		List<FAQ> groupList = service.listCategory();
		
		if(dto==null) {
			return "redirect:/faq/list?group="+group;
		}
		
		
		model.addAttribute("dto",dto);
		model.addAttribute("group",group);
		model.addAttribute("mode","update");
		model.addAttribute("groupList",groupList);
		
		return ".faq.created";
	}
	
	@RequestMapping(value="update", method = RequestMethod.POST)
	public String updateSubmit(
			FAQ dto,
			@RequestParam int group
			/*,HttpSession session*/) throws Exception{
		
		/*SessionInfo info=(SessionInfo)session.getAttribute("member");*/
		
		try {
			dto.setEmCode(1);
			service.updateFAQ(dto);
		} catch (Exception e) {
			throw e;
		}
		return "redirect:/faq/list?group="+group;
	}
	
	@RequestMapping(value="delete")
	public String delete(
			@RequestParam int num,
			@RequestParam(defaultValue="0") int group
			/*,HttpSession session*/) throws Exception{
		
		service.deleteFAQ(num);
		
		
		return "redirect:/faq/list?group="+group;
	}
	
}
