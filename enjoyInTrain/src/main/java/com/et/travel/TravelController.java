package com.et.travel;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.et.common.FileManager;
import com.et.crew.SessionInfo;

@Controller("travel.TravelController")
@RequestMapping("/travel/*")
public class TravelController {
	
	@Autowired
	private TravelService service;
	
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping("main")
	public String main(@RequestParam(defaultValue="") String pmCode,
			Model model) throws Exception{
		
		List<Category> categoryList = service.listCategory();
		List<Travel> travelRankList = service.travelRankList();
		
		int i=1;
		for(Travel dto : travelRankList) {
			model.addAttribute("dto"+i ,dto);
			i++;
		}
		
		List<Travel> deadLineList = service.deadLine();
		
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("pmCode", pmCode);
		model.addAttribute("deadLineList", deadLineList);
		
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
			HttpServletRequest req,
			Model model) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("group", group);
		
		// 리스트
		List<Category> categoryList = service.listCategory();
		
		List<Travel> list = service.listTravel(map);
		
		model.addAttribute("list",list);
		model.addAttribute("group",group);
		model.addAttribute("categoryList", categoryList);
		
		return "/travel/list";
	}
	
	@RequestMapping("list2")
	public String list2(
			int group, 
			HttpServletRequest req,
			Model model) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("group", group);
        
		// 리스트
		List<Category> categoryList = service.listCategory();
		
		List<Travel> list = service.listTravel(map);
	
		model.addAttribute("list",list);
		model.addAttribute("group",group);
		model.addAttribute("categoryList", categoryList);
		
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
		
		// 협력업체
		List<Partner> partnerList = service.listPartner();
		
		// 경로 디테일
		List<Station> stationList = service.listStation();
		
		Random rd = new Random();
		String pmCode = "p";
		for(int i=0; i<10; i++) {
			pmCode +=  Integer.toString(rd.nextInt(10));
		}
		
		model.addAttribute("pmCode", pmCode);
		model.addAttribute("mode","created");
		model.addAttribute("categoryList",categoryList);
		model.addAttribute("partnerList",partnerList);
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
		
		// 성공여부
		String state = "true";
		
		try {
			service.insertPromotionDetail(dto, path);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		model.put("pmCode", dto.getPmCode());

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

		List<Photo> photoList = null;
		List<Photo> photoContentList = null;
		List<Promotion> startList = null;
		List<Promotion> endList = null;
		
		try {
			
			dto = service.readTravel(pmCode);
			
			startList = service.startList(dto);
			endList = service.endList(dto);

			photoList = service.listPhoto(pmCode);
			photoContentList = service.listPhoto2(pmCode);
			
			startList.size();
			
			service.pmCount(startList);
			service.pmCount(endList);
			
			
		} catch (Exception e) {
			throw e;
		}

		model.addAttribute("startList", startList);
		model.addAttribute("endList", endList);
		model.addAttribute("startLength",startList.size());
		model.addAttribute("endLength", endList.size());
		model.addAttribute("pmCode",dto.getPmCode());
		model.addAttribute("dto", dto);
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
		
		// 마지막 주의 year년도 month월 말일주의 토요일 날짜
		Calendar last = (Calendar)cal.clone();
		// year년도 month월 말일
		last.add(Calendar.DATE, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		// year년도 month월 말일주의 토요일
		last.add(Calendar.DATE, 7-last.get(Calendar.DAY_OF_WEEK));
		int lastYear = last.get(Calendar.YEAR);
		int lastMonth = last.get(Calendar.MONTH)+1;
		
		
		int col = 0;
		String result = "<tr>";
		
		 //1일 앞 처리
	    for(int i=1;i<week;i++){
	    	result += "<td>&nbsp;</td>";
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
	     
	    while(col>0&&col<7){
	    	result += "<td>&nbsp;</td>";
	       col++;
	    }
	    result += "</tr>";

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
				
			// 협력업체
			List<Partner> partnerList = service.listPartner();
				
				// 경로 디테일
				List<Station> stationList = service.listStation();
				
				//  promotion, promotionfile 선택 가져오기
				Travel dto = service.readTravel(pmCode);

				List<Promotion> startList = null;
				List<Promotion> endList = null;
				
				// 시작역 리스트 , 끝역 리스트
				startList = service.startList(dto);
				endList = service.endList(dto);
				
				List<Photo> photoList = null;
				photoList = service.listPhoto(dto.getPmCode());
				
				List<Photo> photoList2 = null;
				photoList2 = service.listPhoto2(dto.getPmCode());
				
				model.addAttribute("mode", "update");
				model.addAttribute("categoryList",categoryList);
				model.addAttribute("partnerList",partnerList);
				model.addAttribute("stationList",stationList);
				model.addAttribute("startList", startList);
				model.addAttribute("endList", endList);
				model.addAttribute("photoList", photoList);
				model.addAttribute("photoList2", photoList2);
				model.addAttribute("dto", dto);
				model.addAttribute("pmCode", pmCode);
				
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
			
			SessionInfo info = (SessionInfo) session.getAttribute("crew");
			String state = "false";
			
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "travel";
			
			if(info.getCrewId().equals("a")) {
				try {
					
					service.updatePromotionDetail(dto, pathname);
					
					// 성공여부
					 state = "true";
				
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			Map<String, Object> model = new HashMap<>();
			model.put("state", state);

			return model;
		}
		
		@RequestMapping(value="deleteFile", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> deleteFile(
				@RequestParam int fileNum,
				HttpServletResponse resp,
				HttpSession session) throws Exception{
			
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "travel";
			
			Photo dto = service.readFile(fileNum);
			if(dto!=null) {
				fileManager.doFileDelete(dto.getSaveFileName(), pathname);
			}

			Map<String, Object> model = new HashMap<>();
			
			try {
				Map<String, Object> map = new HashMap<>();
				map.put("fileNum", fileNum);
				service.deleteFile(map);
				
				model.put("state", "true");
			} catch (Exception e) {
				model.put("state", "false");
			}
			
			return model;
		}
		
		@RequestMapping(value="deleteContentFile", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> deleteContentFile(
				@RequestParam int fileNum,
				HttpServletResponse resp,
				HttpSession session) throws Exception{
			
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "travel";
			
			Photo dto = service.readFile(fileNum);
			if(dto!=null) {
				fileManager.doFileDelete(dto.getSaveFileName(), pathname);
			}
			
			Map<String, Object> model = new HashMap<>();
			
			try {
				Map<String, Object> map = new HashMap<>();
				map.put("fileNum", fileNum);
				service.deleteContentFile(map);
				
				model.put("state", "true");
			} catch (Exception e) {
				model.put("state", "false");
			}
			
			return model;
		}
		
		@RequestMapping(value="deleteTrain", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> deleteTrain(
				@RequestParam int trainCode) throws Exception{
			
			Map<String, Object> model = new HashMap<>();
			
			try {
				service.deleteTrain(trainCode);
				
				model.put("state", "true");
			} catch (Exception e) {
				model.put("state", "false");
			}
			
			return model;
		}
		
		@RequestMapping(value="createdTrain", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> createdTrain(
				Promotion dto
				) throws Exception{
			
			Map<String, Object> model = new HashMap<>();
			String result = "";
			
			try {
				if(dto.getPmCode()=="") {
					model.put("state", "false");
					return model;
				}
				
			// 서비스  추가하는것 갔다오기
				service.insertPromotionAdd(dto);
				
				result += "<td><a href='javascript:deleteTrain("+ dto.getTrainCode() +");'><i class='fas fa-trash-alt'></i></a></td>";
				result += "<td></td>";
				result += "<td>"+ dto.getTrainCode() +"</td>";
				result += "<td>${vo.startTime}</td>";
				result += "<td>${vo.endTime}</td>";
				
				model.put("state", "true");
				model.put("pmCode", dto.getPmCode());
				model.put("trainDto", dto);
				model.put("result", result);
				
			} catch (Exception e) {
				model.put("state", "false");
			}
			
			return model;
		}
		

}
