package com.et.admin.promotion;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.et.booking.Booking;
import com.et.booking.BookingService;
import com.et.common.MyUtil;
import com.et.crew.SessionInfo;

@Controller("admin.promotion.promotionController")
public class PromotionController {
	
	@Autowired
	private BookingService bookingService;
	
	@Autowired
	private MyUtil myutil;
	
	@RequestMapping("/admin/promotion/list")
	public String list(@RequestParam(value="page", defaultValue="1") int page,
			@RequestParam(defaultValue="all")String condition,
			@RequestParam(defaultValue="")String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = bookingService.reservationCount(map);
		if(dataCount!=0) {
			total_page = myutil.pageCount(rows, dataCount);
		}
		
		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if(total_page<page) {
			page=total_page;
		}
		
		// 리스트에 출력할 데이터 가져오기
		int offset = (page-1)*rows;
		if(offset<0) offset=0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		// 글리스트
		List<Booking> list = bookingService.listReservation(map);
		
		// 리스트의 번호
		int listNum, n=0;
		for(Booking dto : list) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			n++;
		}
		
		String query = "";
		String listUrl = cp+"/admin/promotion/list";
		String articleUrl = cp+"/promotion/article?page="+page;
		if(keyword.length()!=0) {
			query = "condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		if(query.length()!=0) {
			listUrl = cp+"/admin/promotion/list?"+query;
			articleUrl = cp+"/admin/promotion/article?page="+page+"&"+query;
		}
		
		String paging = myutil.paging(page, total_page, listUrl);
		
		model.addAttribute("list",list);
		model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("page", page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		
		return ".admin.promotion.list";
		}
	
	@RequestMapping("/admin/promotion/delete")
	public String cancleReservation(@RequestParam int prSeq, 
				@RequestParam String page,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("crew");
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("crewId", info.getCrewId());
			map.put("prSeq", prSeq);
			bookingService.deleteAdmin(prSeq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/admin/promotion/list?page="+page;
	}
}
