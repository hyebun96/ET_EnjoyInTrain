package com.et.lostboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.et.common.MyUtil;

@Controller("lostBoardController")
@RequestMapping("/lostBoard/*")
public class LostBoardController {
	
	@Autowired
	MyUtil myutil = new MyUtil();
	
	@Autowired
	LostBoardService service;
	
	@RequestMapping(value="list")
	public String list() {
		
		try {
			service.listLostBoard();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@RequestMapping(value="insert", method=RequestMethod.GET)
	public String insertForm() throws Exception {
		
		
		return "";
	}
	
	@RequestMapping(value="insert", method=RequestMethod.POST)
	public String insert() throws Exception {
		
		return "";
	}
	
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm() throws Exception {
		
		return "";
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String update() throws Exception {
		
		return "";
	}
	
	@RequestMapping(value="delete")
	public String delete() throws Exception {
		
		return "";
	}
}
