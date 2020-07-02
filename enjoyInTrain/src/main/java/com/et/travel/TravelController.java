package com.et.travel;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.et.common.MyUtil;

@Controller("travel.TravelController")
@RequestMapping("/travel/*")
public class TravelController {
	
	@Autowired
	private TravelService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("main")
	public String main(@RequestParam(defaultValue="") String pmCode,
			Model model) throws Exception{
		
		List<Category> categoryList = service.listCategory();
		model.addAttribute("categoryList", categoryList);
		
		List<Travel> travelRankList = service.travelRankList();
		
		int i=1;
		for(Travel dto : travelRankList) {
			model.addAttribute("dto"+i ,dto);
			i++;
		}
		
		model.addAttribute("pmCode", pmCode);
		return ".travel.main";
	}
	
	@RequestMapping("travel")
	public String travel(
			String pmCode,
			@RequestParam(name="year", defaultValue="0") int year,
			@RequestParam(name="month", defaultValue="0")  int month,
			Model model) throws Exception {
		
		List<Category> categoryList = service.listCategory();
		model.addAttribute("categoryList", categoryList);
		
		// 캘린더
		Calendar cal = Calendar.getInstance();
		int y = cal.get(Calendar.YEAR);
		int m = cal.get(Calendar.MONTH)+1;
		
		if(year==0) year=y;
		if(month==0) month=m;

		model.addAttribute("pmCode", pmCode);
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		
		return ".travel.travel";
	}
	
	
	@RequestMapping("list")
	public String list(
			int group, 
			@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			Model model) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("group", group);
		
		// 페이징
		String cp = req.getContextPath();
		
		int rows = 5;
		int total_page = 0;
		int dataCount = 0;
		
		dataCount = service.dataCount(map);
		
		if(dataCount != 0) total_page = myUtil.pageCount(rows, dataCount) ;
		
		if(total_page < current_page) current_page = total_page;
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        
		// 리스트
		List<Category> categoryList = service.listCategory();
		
		List<Travel> list = service.listTravel(map);
		
		String listUrl = cp+"/travel/list?group="+group;
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list",list);
		model.addAttribute("group",group);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		
		return "/travel/list";
	}
	
	@RequestMapping("list2")
	public String list2(
			int group, 
			@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			Model model) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("group", group);
		
		// 페이징
		String cp = req.getContextPath();
		
		int rows = 5;
		int total_page = 0;
		int dataCount = 0;
		
		dataCount = service.dataCount(map);
		
		if(dataCount != 0) total_page = myUtil.pageCount(rows, dataCount) ;
		
		if(total_page < current_page) current_page = total_page;
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        
		// 리스트
		List<Category> categoryList = service.listCategory();
		
		List<Travel> list = service.listTravel(map);
		
		String listUrl = cp+"/travel/list?group="+group;
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list",list);
		model.addAttribute("group",group);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		
		return "/travel/list2";
	}
	
	
	// 하행선
	@RequestMapping(value="stationLine1", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> stationLineList(
			String startStation,
			String endStation) throws Exception{
		
		Map<String, Object> map = new HashMap<>();
		map.put("startStation", startStation);
		map.put("endStation", endStation);
		
		
		List<StationLine> stationLineList = service.listStationLine(map);
		
		map.put("stationLineList", stationLineList);

		return map;
	}
	
	// 상행선
	@RequestMapping(value="stationLine2", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> stationLineList2(
			String startStation2,
			String endStation2) throws Exception{
		
		Map<String, Object> map = new HashMap<>();
		map.put("startStation", startStation2);
		map.put("endStation", endStation2);
		
		List<StationLine> stationLineList = service.listStationLine2(map);
		
		map.put("stationLineList", stationLineList);
		
		return map;
	}
	
	// 생성폼
	@RequestMapping(value="created", method=RequestMethod.GET)
	public String createdForm(Model model) throws Exception{
		
		// 카테고리
		List<Category> categoryList = service.listCategory();
		
		model.addAttribute("mode","created");
		model.addAttribute("categoryList",categoryList);
		
		// 협력업체
		List<Partner> partnerList = service.listPartner();
		
		model.addAttribute("partnerList",partnerList);
		
		// 경로 디테일
		List<Station> stationList = service.listStation();
		
		model.addAttribute("stationList",stationList);
		model.addAttribute("mode", "created");
		
		
		return "travel/created";
	}
	
	
	@RequestMapping(value="created", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createdSubmit(
			Travel dto,
			HttpSession session) throws Exception{
		
		// 여행지 사진
		String root=session.getServletContext().getRealPath("/");
		String path=root+"uploads"+File.separator+"travel";
		
		// 프로모션 코드 랜덤생성
		Random rd = new Random();
		String pmCode = "p";
		for(int i=0; i<10; i++) {
			pmCode +=  Integer.toString(rd.nextInt(10));
		}
		
		dto.setPmCode(pmCode);
		
		// 성공여부
		String state = "true";
		
		try {
			service.insertPromotionDetail(dto, path);
			service.insertPromotion(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);

		return model;
	}
	
	// article
	@RequestMapping(value="article", method=RequestMethod.GET)
	public String articleForm(
			@RequestParam("") String pmCode,
			@RequestParam(name="year", defaultValue="0") int year,
			@RequestParam(name="month", defaultValue="0")  int month,
			Model model) throws Exception{
		
		Travel dto = null;
		List<Promotion> startList = null;
		List<Promotion> endList = null;
		List<Photo> photoList = null;
		List<Photo> photoContentList = null;
		
		try {
			
			dto = service.readTravel(pmCode);
			
			startList = service.startList(dto);
			endList = service.endList(dto);
			
			photoList = service.listPhoto(pmCode);
			
			photoContentList = service.listPhoto2(pmCode);
			
		} catch (Exception e) {
			throw e;
		}
		
		startList.size();

		model.addAttribute("dto", dto);
		model.addAttribute("startList", startList);
		model.addAttribute("endList", endList);
		model.addAttribute("startLength",startList.size());
		model.addAttribute("endLength", endList.size());
		model.addAttribute("photoList", photoList);
		model.addAttribute("photoContentList", photoContentList);
		
		
		// 캘린더
		Calendar cal = Calendar.getInstance();
		int y = cal.get(Calendar.YEAR);
		int m = cal.get(Calendar.MONTH)+1;
		
		if(year==0) year=y;
		if(month==0) month=m;
		
		// year년 month월 1일의 요일
		cal.set(year, month-1, 1);
		year = cal.get(Calendar.YEAR);
		month = cal.get(Calendar.MONTH)+1;
		int week = cal.get(Calendar.DAY_OF_WEEK);			
		int lastDate = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		// 첫주의 year년 month월 1일 이전 날짜
		Calendar preCal = (Calendar)cal.clone();
		preCal.add(Calendar.DATE, -(week-1));
		int preYear=preCal.get(Calendar.YEAR);
		int preMonth=preCal.get(Calendar.MONTH)+1;
		int preDate=preCal.get(Calendar.DATE);
		
		// 마지막 주의 year년도 month월 말일주의 토요일 날짜
		Calendar last = (Calendar)cal.clone();
		// year년도 month월 말일
		last.add(Calendar.DATE, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		// year년도 month월 말일주의 토요일
		last.add(Calendar.DATE, 7-last.get(Calendar.DAY_OF_WEEK));
		int lastYear = last.get(Calendar.YEAR);
		int lastMonth = last.get(Calendar.MONTH)+1;
		
		
		int col = 0;
		String result = "";
		
		 //1일 앞 처리
	    for(int i=1;i<week;i++){
	    	result += "<td class='preday' data-tab='"+ preDate +"'>"+(preDate++)+"</td>";
	    	col++;
	    }
	    
	    for(int i=1;i<=lastDate;i++){
	    	result += "<td class='day' data-tab='"+ i +"'>"+i+"</td>";
	       col++;
	       if(col==7&&i!=lastDate){
	    	   result += "</tr><tr>";
	          col=0;
	       }
	    }
	    
	  //마지막 주 마지막 일자 다음 처리
	     int n=1;
	     
	    while(col>0&&col<7){
	    	result += "<td class='nextday' data-tab='"+ n +"'>"+(n++)+"</td>";
	       col++;
	    }

	    model.addAttribute("preYear", preYear);
	    model.addAttribute("preMonth", preMonth);
	    model.addAttribute("lastYear", lastYear);
	    model.addAttribute("lastMonth", lastMonth);
	    model.addAttribute("result", result);
	    model.addAttribute("year", year);
	    model.addAttribute("month", month);
		
		return "travel/article";
	}
	
	
	// 생성폼
		@RequestMapping(value="update", method=RequestMethod.GET)
		public String updateForm(
				@RequestParam String pmCode,
				Model model) throws Exception{
			
			try {
				// 카테고리
				List<Category> categoryList = service.listCategory();
				
				model.addAttribute("mode","created");
				model.addAttribute("categoryList",categoryList);
				
				// 협력업체
				List<Partner> partnerList = service.listPartner();
				
				model.addAttribute("partnerList",partnerList);
				
				// 경로 디테일
				List<Station> stationList = service.listStation();
				
				model.addAttribute("stationList",stationList);
				model.addAttribute("mode", "update");
			
				Travel dto = service.readTravel(pmCode);
				model.addAttribute("dto", dto);
				
				List<Promotion> startList = null;
				List<Promotion> endList = null;
				
				startList = service.startList(dto);
				endList = service.endList(dto);
				
				model.addAttribute("startList", startList);
				model.addAttribute("endList", endList);
				
				List<Photo> photoList = null;
				photoList = service.listPhoto(dto.getPmCode());
				
				model.addAttribute("photoList", photoList);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		
			
			return "travel/created";
		}
		
		
		@RequestMapping(value="update", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> updateSubmit(
				Travel dto,
				HttpSession session) throws Exception{
			
			// 여행지 사진
			String root=session.getServletContext().getRealPath("/");
			String path=root+"uploads"+File.separator+"travel";
			
			// 프로모션 코드 랜덤생성
			Random rd = new Random();
			String pmCode = "p";
			for(int i=0; i<10; i++) {
				pmCode +=  Integer.toString(rd.nextInt(10));
			}
			
			dto.setPmCode(pmCode);
			
			// 성공여부
			String state = "true";
			
			try {
				service.insertPromotionDetail(dto, path);
				service.insertPromotion(dto);
			} catch (Exception e) {
				state="false";
			}
			
			Map<String, Object> model = new HashMap<>();
			model.put("state", state);

			return model;
		}
		

	
}
