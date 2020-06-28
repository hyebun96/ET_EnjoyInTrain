package com.et.admin.crewManage;

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
import com.et.crew.Crew;
import com.et.crew.CrewService;

@Controller("crewManage.crewManageController")
public class CrewManageController {
	@Autowired
	private CrewService crewService;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/admin/crewManage/list")
	public String crewManage(@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="crewId") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		String cp = req.getContextPath();
   	    
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
   	    
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		// 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("condition", condition);
        map.put("keyword", keyword);

        dataCount = crewService.dataCount(map);
        if(dataCount != 0)
            total_page = myUtil.pageCount(rows, dataCount) ;

        // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
            current_page = total_page;

        // 리스트에 출력할 데이터를 가져오기
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);

        // 멤버 리스트
        List<Crew> list = crewService.listCrew(map);

        // 리스트의 번호
        int listNum, n = 0;
        for(Crew dto:list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
        
        String query = "";
        String listUrl = cp+"/admin/crewManage/list";
        
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = listUrl + "?" + query;
        }
        
        String paging = myUtil.paging(current_page, total_page, listUrl);        
		
        model.addAttribute("list", list);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        model.addAttribute("condition", condition);
        model.addAttribute("keyword", keyword);
        
		return ".admin.crewManage.listCrew";
	}
	
	// AJAX-Text
	@RequestMapping(value="/admin/crewManage/detaile")
	public String detailedCrew(
			@RequestParam String crewId,
			Model model) throws Exception {
		
		Crew dto=crewService.readCrew(crewId);
		Crew crewState = crewService.readCrewState(crewId);
		List<Crew> listState = crewService.listCrewState(crewId);

		model.addAttribute("dto", dto);
		model.addAttribute("crewState",crewState);
		model.addAttribute("listState", listState);
		
		return "admin/crewManage/detailedCrew";
	}
	
	@RequestMapping(value="/admin/crewManage/updateCrewState",method=RequestMethod.POST)
	@ResponseBody
	public Map<String , Object> updateCrewState(
			Crew dto
			) throws Exception{
		
		String state = "true";
		
		try {
			crewService.insertCrewState(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String , Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
}
