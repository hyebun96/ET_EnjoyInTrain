package com.et.admin.trainsales;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("admin.trainsales.trainSalesController")
@RequestMapping("/admin/trainsales/*")
public class TrainSalesController {
	
	@Autowired
	private TrainSalesService service;
	
	@RequestMapping("list")
	public String list(Model model) throws Exception {
		String tab="listDay";
		Calendar cal = Calendar.getInstance();
		String year=String.format("%d", cal.get(Calendar.YEAR));
		String month=String.format("%d", cal.get(Calendar.MONTH)+1);
		
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("tab", tab);
		
		return ".admin.trainsales.main";
	}
	
	@RequestMapping("listDay")
	public String listDay(
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception{
		
			if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
				keyword = URLDecoder.decode(keyword, "utf-8");
			}
	
			if(keyword.length()==0) {
				Calendar cal = Calendar.getInstance();
				keyword=String.format("%04d%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH)+1);
			}
	        Map<String, Object> map = new HashMap<String, Object>();
	        map.put("keyword", keyword);

	        // 글 리스트
	        List<TrainSales> list = service.listDay(map);
	        
			model.addAttribute("list", list);
			
			return "admin/trainsales/list";
	}
	
	@RequestMapping("listMonth")
	public String listMonth(
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception{
		
			if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
				keyword = URLDecoder.decode(keyword, "utf-8");
			}
	
			if(keyword.length()==0) {
				Calendar cal = Calendar.getInstance();
				keyword=String.format("%04d", cal.get(Calendar.YEAR));
			}
			
	        Map<String, Object> map = new HashMap<String, Object>();
	        map.put("keyword", keyword);

	        // 글 리스트
	        List<TrainSales> list = service.listMonth(map);
	        
			model.addAttribute("list", list);
			
			return "admin/trainsales/list";
	}
	
	@RequestMapping("listYear")
	public String listYear(
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception{
		
			if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
				keyword = URLDecoder.decode(keyword, "utf-8");
			}
	
	        Map<String, Object> map = new HashMap<String, Object>();
	        map.put("keyword", keyword);

	        // 글 리스트
	        List<TrainSales> list = service.listYear(map);
	        
			model.addAttribute("list", list);
			model.addAttribute("keyword", keyword);
			
			return "admin/trainsales/list";
	}	
	
	@RequestMapping("chatDay")
	@ResponseBody
	public Map<String, Object> chatDay(
			@RequestParam(defaultValue="") String keyword
			) throws Exception{
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		if(keyword.length()==0) {
				Calendar cal = Calendar.getInstance();
				keyword=String.format("%04d%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH)+1);
		}
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("keyword", keyword);

	    // 글 리스트
	    List<TrainSales> list = service.listDay(map);
	    
	    if(list.size()>=1) {
	    	String [] categories=new String[list.size()];
	    	double[] data = new double[list.size()];
	    	
	    	for(int i=0; i<list.size(); i++) {
	    		categories[i]=list.get(i).getTrPayDate();
	    		data[i]=list.get(i).getSeatPay();
	    	}
	    	
	    	model.put("categories", categories);
	    	model.put("series", data);
	    }
	    			
		return model;
	}
	
	
	@RequestMapping("chatMonth")
	@ResponseBody
	public Map<String, Object> chatMonth(
			@RequestParam(defaultValue="") String keyword
			) throws Exception{
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		if(keyword.length()==0) {
			Calendar cal = Calendar.getInstance();
			keyword=String.format("%04d", cal.get(Calendar.YEAR));
		}
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("keyword", keyword);

	    // 글 리스트
	    List<TrainSales> list = service.listMonth(map);
	    
    	List<Map<String, Object>> list2 = new ArrayList<>();
		Map<String, Object> map2;
		
		for(TrainSales vo : list) {
			map2=new HashMap<>();
			map2.put("name", vo.getTrPayDate());
			map2.put("y", vo.getSeatPay());
			
			list2.add(map2);
		}
			
	    model.put("series", list2);
	    
		return model;
	}
	
	@RequestMapping("chatYear")
	@ResponseBody
	public Map<String, Object> chatYear(
			@RequestParam(defaultValue="") String keyword
			) throws Exception{
		
		Map<String, Object> model = new HashMap<String, Object>();


	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("keyword", keyword);

	    // 글 리스트
	    List<TrainSales> list = service.listYear(map);
	    
    	List<Map<String, Object>> list2 = new ArrayList<>();
		Map<String, Object> map2;
		
		for(TrainSales vo : list) {
			map2=new HashMap<>();
			map2.put("name", vo.getTrPayDate());
			map2.put("y", vo.getSeatPay());
			
			list2.add(map2);
		}
			
	    model.put("series", list2);
	    
		return model;
	}		
	
	@RequestMapping(value="person" , produces="application/json;charset=utf-8")
	@ResponseBody
	public String person(
			) throws Exception{
		
		
		TrainpersonType dto = null;
		
		JSONArray arr = new JSONArray();
		
		JSONObject job = new JSONObject();
		job.put("minPointSize", 10);
		job.put("innerSize", "30%");
		job.put("zMin", 0);
		job.put("name", "countries");
		
		JSONArray ja = new JSONArray();
		dto = service.listType();
		
		float sum = 100/(dto.getAdult()+dto.getChild()+dto.getOld()+dto.getMd()+dto.getSd());

		JSONObject oo;
		oo=new JSONObject();
		oo.put("name", "성인");
		oo.put("y", dto.getAdult());
		oo.put("z", dto.getAdult() * sum);
		ja.put(oo);
		
		oo=new JSONObject();
		oo.put("name", "어린이");
		oo.put("y", dto.getChild());
		oo.put("z", dto.getChild() * sum);
		ja.put(oo);
		
		oo=new JSONObject();
		oo.put("name", "노인");
		oo.put("y", dto.getOld());
		oo.put("z", dto.getOld() * sum);
		ja.put(oo);
		
		oo=new JSONObject();
		oo.put("name", "중증장애인");
		oo.put("y", dto.getMd());
		oo.put("z", dto.getMd() * sum);
		ja.put(oo);
		
		oo=new JSONObject();
		oo.put("name", "경증장애인");
		oo.put("y", dto.getSd());
		oo.put("z", dto.getSd() * sum);
		ja.put(oo);
				
		job.put("data",ja);
		
		arr.put(job);
		
		return arr.toString();
	}			
}