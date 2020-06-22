package com.et.lostBoard;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import com.et.common.FileManager;
import com.et.common.MyUtil;
import com.et.crew.SessionInfo;

@Controller("lostBoardController")
@RequestMapping("/lostBoard/*")
public class LostBoardController {
	
	@Autowired
	private LostBoardService service;
	
	@Autowired
	private MyUtil myutil = new MyUtil();
	
	@Autowired
	private FileManager fileManager;
	
	// 게시글 리스트
	@RequestMapping(value="list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int page,
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
		
		dataCount = service.dataCount(map);
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
		List<LostBoard> list = service.listLostBoard(map);
		
		// 리스트의 번호
		Date endDate = new Date();
		int listNum, n=0;
		long gap;
		for(LostBoard dto : list) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date beginDate = formatter.parse(dto.getLostCreated());
			
			gap = (endDate.getTime()-beginDate.getTime())/(24*60*60*1000);
			dto.setGap(gap);
			
			dto.setLostCreated(dto.getLostCreated().substring(0,10));
			n++;
		}
		
		String query = "";
		String listUrl = cp+"/lostBoard/list";
		String articleUrl = cp+"/lostBoard/article?page="+page;
		if(keyword.length()!=0) {
			query = "condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		if(query.length()!=0) {
			listUrl = cp+"/lostBoard/list?"+query;
			articleUrl = cp+"/lostBoard/article?page="+page+"&"+query;
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
		
		return ".lostBoard.list";
	}
	
	// 게시글 작성 폼
	@RequestMapping(value="created", method=RequestMethod.GET)
	public String insertForm(
			Model model
			) throws Exception {
		
		model.addAttribute("mode", "created");
		
		return ".lostBoard.created";
	}
	
	// 게시글 작성
	@RequestMapping(value="created", method=RequestMethod.POST)
	public String insert(
			LostBoard dto,
			HttpSession session
			) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("crew");
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"lostBoard";
		
		try {
			dto.setCrewId(info.getCrewId());
			service.insertLostBoard(dto, pathname);
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/lostBoard/list";
	}
	
	// 게시글 보기
	@RequestMapping(value="article")
	public String article(
			@RequestParam int lostNum,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model
			) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query = "page="+page;
		
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		service.updateHitCount(lostNum);
		
		LostBoard dto = service.readLostBoard(lostNum);
		if(dto==null) {
			return "redirect:/lostBoard/list?"+query;
		}
		
		dto.setLostContent(myutil.htmlSymbols(dto.getLostContent()));
		dto.setLostCreated(dto.getLostCreated().substring(0,10));
		
		// 이전 글, 다음 글
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("lostNum", lostNum);
		
		LostBoard preReadDto = service.preReadLostBoard(map);
		LostBoard nextReadDto = service.nextReadLostBoard(map);
		
		// 파일
		List<LostBoard> listFile = service.listFile(lostNum);
		
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".lostBoard.article";				
	}
	
	// 게시글 수정폼
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int lostNum,
			@RequestParam String page,
			HttpSession session,
			Model model
			) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("crew");
		
		LostBoard dto = service.readLostBoard(lostNum);
		if(dto==null) {
			return "redirect:/lostBoard/list?page="+page;
		}
		
		if(! info.getCrewId().equals(dto.getCrewId())) {
			return "redirect:/lostBoard/list?page="+page;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		
		return ".lostBoard.created";
	}
	
	// 게시글 수정
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String update(
			LostBoard dto,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"lostBoard";
		
		try {
			
			service.updateLostBoard(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/lostBoard/list?page="+page;
	}
	
	// 파일 삭제
	@RequestMapping(value="deleteFile")
	@ResponseBody
	public Map<String, Object> deleteFile(
			@RequestParam int num,
			HttpSession session
			) throws Exception {
		
		String state="true";
		
		SessionInfo info = (SessionInfo)session.getAttribute("crew");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"lostBoard";
		
		try {
			
			LostBoard dto = service.readFile(num);
			if(dto!=null) {
				fileManager.doFileDelete(dto.getSaveFileName(), pathname);
			}
			
			Map<String, Object> map = new HashMap<>();
			map.put("field", "num");
			map.put("num", num);
			service.deleteFile(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	// 게시글 삭제
	@RequestMapping(value="delete")
	public String delete(
			@RequestParam int lostNum,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session
			) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("crew");
		
		keyword = URLDecoder.decode(keyword, "UTF-8");
		String query = "page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword,"UTF-8");
		}
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"lostBoard";
		
		service.deleteLostBoard(lostNum, pathname, info.getCrewId());
		
		
		return "redirect:/lostBoard/list?"+query;
	}
	
	// 댓글 리스트
	@RequestMapping(value="listReply")
	public String listReply(
			@RequestParam int lostNum,
			@RequestParam(value="pageNo", defaultValue="1") int page,
			Model model
			) throws Exception {
		
		int rows = 5;
		int total_page = 0;
		int dataCount = 0;
		
		Map<String, Object> map = new HashMap<>();
		map.put("lostNum", lostNum);
		
		dataCount = service.replyCount(map);
		total_page = myutil.pageCount(rows, dataCount);
		if(page>total_page) {
			page=total_page;
		}
		int offset = (page-1)*rows;
		if(offset<0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		List<Reply> listReply = service.listReply(map);
		
		for(Reply dto : listReply) {
			dto.setContent(myutil.htmlSymbols(dto.getContent()));
			dto.setCreated(dto.getCreated().substring(0,10));
		}
		
		// AJAX 용 페이징
		String paging = myutil.pagingMethod(page, total_page, "listPage");
		
		// 포워딩할 jsp로 넘길 데이터
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		
		
		return "lostBoard/listReply";
				
	}
	
	// 댓글 및 댓글의 답글 등록 
	@RequestMapping(value="insertReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(
				Reply dto,
				HttpSession session
			) {
		SessionInfo info = (SessionInfo)session.getAttribute("crew");
		String state = "true";
		
		try {
			dto.setCrewId(info.getCrewId());
			service.insertReply(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	// 댓글 및 댓글의 답글 삭제
	@RequestMapping(value="deleteReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(
				@RequestParam Map<String, Object> paramMap
			) {
		
		String state="true";
		
		try {
			service.deleteReply(paramMap);
		} catch (Exception e) {
			state="fasle";
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("state", state);
		return map;
		
	}
	
	// 댓글의 답글 리스트
	@RequestMapping(value="listReplyAnswer")
	public String listReplyAnswer(
			@RequestParam int answer,
			Model model
			) throws Exception {
		
		List<Reply> listReplyAnswer = service.listReplyAnswer(answer);
		for(Reply dto : listReplyAnswer) {
			dto.setContent(myutil.htmlSymbols(dto.getContent()));
		}
		
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		return "lostBoard/listReplyAnswer";
	}
	
	// 댓글의 답글 개수 
	@RequestMapping(value="countReplyAnswer")
	@ResponseBody
	public Map<String, Object> countReplyAnswer(
				@RequestParam(value="answer") int answer
			) {
		
		int count = service.replyAnswerCount(answer);
		
		Map<String, Object> model = new HashMap<>();
		model.put("count", count);
		return model;
	}
}
