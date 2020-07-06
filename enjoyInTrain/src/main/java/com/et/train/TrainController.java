package com.et.train;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.et.common.MyUtil;

@Controller("train.trainController")
@RequestMapping("/admin/train/*")
public class TrainController {
	
	@Autowired
	private MyUtil myutil;
	
	@Autowired
	private TrainService service;
	
	@RequestMapping(value="list")
	public String list(
			Model model
			) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		
		List<Train> list = service.listTrain(map);
		
		model.addAttribute("list",list);


		return ".admin.train.list";
	}
	
	
	@RequestMapping(value="created", method=RequestMethod.POST)
	public String insert(
			Train dto
			) throws Exception {
		
		try {
			service.insertRoom(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/admin/train/list";
	}
	
}
