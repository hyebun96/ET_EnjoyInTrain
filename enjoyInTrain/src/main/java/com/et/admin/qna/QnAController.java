package com.et.admin.qna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.et.crew.SessionInfo;
import com.et.faq.FAQ;
import com.et.qna.QnA;
import com.et.qna.QnAService;

@Controller(".admin.qna.QnAController")
@RequestMapping("/admin/qna/*")
public class QnAController {
	
	@Autowired
	private QnAService service;
	
	@RequestMapping("/admin/qna/main")
	public String main(
			Model model) throws Exception {
		
		List<QnA> groupList = service.listCategory();
		
		model.addAttribute("groupList",groupList);
		
		return ".admin.qna.main";
	}
	
	
	@RequestMapping("/admin/qna/list")
	public String list(
			int group,
			Model model) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("group", group);
		
		List<QnA> list = service.listAdminQnA(map);
		
		model.addAttribute("list",list);
		model.addAttribute("group", group);
		
		return "/admin/qna/list";
	}
	
	@RequestMapping(value="/admin/qna/created", method = RequestMethod.GET)
	public String createdForm(
			@RequestParam(defaultValue="0") int group,
			Model model,
			HttpSession session) throws Exception{
		
		SessionInfo info=(SessionInfo)session.getAttribute("crew");
		
		List<QnA> groupList = service.listCategory();
		
		model.addAttribute("mode","created");
		model.addAttribute("groupList",groupList);
		
		List<FAQ> faqList = service.readFAQ(group);
		
		model.addAttribute("faqList", faqList);
		model.addAttribute("crewName",info.getClass());
		// model.addAttribute("group",group);
		
		return "/admin/qna/created";
	}
	
	@RequestMapping(value="/admin/qna/created", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createdSubmit(
			QnA dto,
			@RequestParam(defaultValue="0") int group
			,HttpSession session) throws Exception{
	
		SessionInfo info=(SessionInfo)session.getAttribute("crew");
		String state = "true";
		
		try {
			dto.setCrewId(info.getCrewId());
			service.insertQnA(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value="/admin/qna/update", method = RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam(defaultValue="0") int group,
			HttpSession session,
			Model model) throws Exception{
		
		//SessionInfo info=(SessionInfo)session.getAttribute("crew");
		
		QnA dto = service.readQnA(num);
		
		if(dto==null) {
			return "/admin/faq/list?group="+group;
		}

		List<QnA> groupList = service.listCategory();
		
		/*if(! info.getCrewId().equals(dto.getCrewId())) {
			return "redirect:/faq/list?group="+group;
		}*/
		
		model.addAttribute("dto",dto);
		model.addAttribute("group",group);
		model.addAttribute("mode","update");
		model.addAttribute("groupList",groupList);
		
		return "/admin/qna/created";
	}
	
	@RequestMapping(value="/admin/qna/update", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateSubmit(
			QnA dto,
			@RequestParam(defaultValue="0") int group
			,HttpSession session) throws Exception{
		
		String state = "true";
		
		try {
			SessionInfo info=(SessionInfo)session.getAttribute("crew");
			dto.setCrewId(info.getCrewId());
			service.updateQnA(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value="/admin/qna/article")
	public String article(
			@RequestParam int num,
			@RequestParam(defaultValue="0") String group,
			Model model,
			HttpSession session,
			HttpServletRequest req) throws Exception{
		
		//SessionInfo info = (SessionInfo)session.getAttribute("crew");
		
		String query = "group="+group;
		
		service.updateHitCount(num);
		
		QnA dto = service.readQnA(num);
		if(dto==null) {
			return "/admin/qna/list?"+query;
		}
		
		
		if(dto.getQnaContent()!=null) {
			dto.setQnaContent(dto.getQnaContent().replaceAll("\n", "<br>"));
		}
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("group", group);
		map.put("num", num);
		
		QnA preReadDto = service.preReadQnA(map);
		QnA nextReadDto = service.nextReadQnA(map);
        
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);

		model.addAttribute("group", group);
		model.addAttribute("query", query);
		
		return "/admin/qna/article";
	}
	
	@RequestMapping(value="/admin/qna/delete", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(
			@RequestParam int num,
			HttpSession session
			) throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("crew");
		String state="false";
		
		QnA dto = service.readQnA(num);
		if(dto!=null) {
			if(info.getCrewId().equals(dto.getCrewId()) || info.getCrewId().equals("a")) {
				try {
					Map<String, Object> map = new HashMap<>();
					map.put("num", num);
					map.put("crewId", info.getCrewId());
					service.deleteQnA(map);
				} catch (Exception e) {
				}
			}
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value="/admin/qna/faqList",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> faqList(
			@RequestParam(defaultValue="0") int group
			) throws Exception{
		Map<String, Object> map = new HashMap<>();
		map.put("group", group);
		
		List<FAQ> faqList = service.readFAQ(group);
		map.put("faqList", faqList);		
		
		return map;
	}
}
