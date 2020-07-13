package com.et.faq;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
}
