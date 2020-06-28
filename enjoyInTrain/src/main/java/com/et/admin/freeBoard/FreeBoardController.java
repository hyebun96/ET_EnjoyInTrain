package com.et.admin.freeBoard;

import java.io.File;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.et.common.MyUtil;
import com.et.crew.SessionInfo;
import com.et.freeBoard.FreeBoard;
import com.et.freeBoard.FreeBoardService;
import com.et.freeBoard.Reply;

@Controller("admin.freeBoard.freeBoardController")
public class FreeBoardController {

	@Autowired
	private FreeBoardService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping("/admin/freeBoard/list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
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
        dataCount = service.dataCount(map);
        if(dataCount != 0) {
            total_page = myUtil.pageCount(rows, dataCount) ;
        }	
        // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
            current_page = total_page;

        // 리스트에 출력할 데이터를 가져오기
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        
        // 글 리스트
        List<FreeBoard> list = service.listBoard(map);

        // 리스트의 번호
        int listNum, n = 0;
        for(FreeBoard dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
        
        Date endDate = new Date();
        long gap;
    
        for(FreeBoard dto : list) {
            
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date beginDate = formatter.parse(dto.getFbCreated());

            gap=(endDate.getTime() - beginDate.getTime()) / (60*60* 1000);
            dto.setGap(gap);
            
            dto.setFbCreated(dto.getFbCreated().substring(0, 10));
        }
        
        String query = "";
        String listUrl = cp+"/admin/freeBoard/list";
        String articleUrl = cp+"/admin/freeBoard/article?page=" + current_page;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/admin/freeBoard/list?" + query;
        	articleUrl = cp+"/admin/freeBoard/article?page=" + current_page + "&"+ query;
        }
        
        String paging = myUtil.paging(current_page, total_page, listUrl);

        model.addAttribute("list", list);
        model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".admin.freeBoard.list";
	}
	
	@RequestMapping("/admin/freeBoard/article")
	public String article(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model
			)throws Exception{
		
		keyword = URLDecoder.decode(keyword,"utf-8");
		
		String query = "page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword,"utf-8");
		}
		
		service.updateHitCount(num);
		
		FreeBoard dto = service.readBoard(num);
		if(dto==null) {
			return "redirect:/admin/freeBoard/list?"+query;
		}
		
		dto.setFbContent(myUtil.htmlSymbols(dto.getFbContent()));
		
		//이전글.다음글
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("condition",condition);
		map.put("keyword", keyword);
		map.put("num", num);
		
		FreeBoard preReadDto = service.preReadBoard(map);
		FreeBoard nextReadDto = service.nextReadBoard(map);
		
		//파일
		List<FreeBoard> listFile =service.listFile(num);
		
		model.addAttribute("dto",dto);
		model.addAttribute("preReadDto",preReadDto);
		model.addAttribute("nextReadDto",nextReadDto);
		model.addAttribute("listFile",listFile);
		model.addAttribute("page",page);
		model.addAttribute("query",query);
		
		return ".admin.freeBoard.article";
	}
	
	@RequestMapping(value="/admin/freeBoard/deleteFile",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> deleteFile(
			@RequestParam int fbFileNum,
			HttpSession session
			) throws Exception{
		SessionInfo info = (SessionInfo) session.getAttribute("crew");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname= root+"uploads"+File.separator+"freeBoard";
		
		FreeBoard dto = service.readFile(fbFileNum);
		if(dto==null) {
			fileManager.doFileDelete(dto.getSaveFileName(), pathname);

		}
		
		if(! info.getCrewId().equals(dto.getCrewId())) {
			fileManager.doFileDelete(dto.getSaveFileName(), pathname);
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("field", "fbFileNum");
		map.put("num", fbFileNum);
		service.deleteFile(map);
		
		
		 // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", "true");
		return model;

		
	}
	
	@RequestMapping("/admin/freeBoard/delete")
	public String delete(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session
			)throws Exception{
		SessionInfo info =(SessionInfo)session.getAttribute("crew");
		
		keyword = URLDecoder.decode(keyword,"utf-8");
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword,"utf-8");
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"freeBoard";
		
		service.deleteBoard(num, pathname, info.getCrewId());
		
		return "redirect:/admin/freeBoard/list?"+query;
	}
	
	@RequestMapping("/admin/freeBoard/download")
	public void downlowad(
			@RequestParam int fbFileNum,
			HttpServletResponse resp,
			HttpSession session
			) throws Exception{
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"freeBoard";
		
		boolean b = false;
		FreeBoard dto = service.readFile(fbFileNum);
		
		if(dto != null) {
			String saveFilename = dto.getSaveFileName();
			String originalFilename = dto.getOriginalFileName();
			
			b= fileManager.doFileDownload(saveFilename, originalFilename, pathname, resp);
		}	
		
		if(!b) {
			try {
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능합니다.');histroy.back();</script>");
			} catch (Exception e) {
			}
		}
		
		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter out = resp.getWriter();
		out.print("<script>alert('파일 다운로드가 실패했습니다.');history.back();</script>");
	}
	
	@RequestMapping("/admin/freeBoard/zipdownload")
	public void zipdownload(
			@RequestParam int num,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "freeBoard";

		boolean b = false;
		
		List<FreeBoard> listFile = service.listFile(num);
		if(listFile.size()>0) {
			String []sources = new String[listFile.size()];
			String []originals = new String[listFile.size()];
			String zipFilename = num+".zip";
			
			for(int idx = 0; idx<listFile.size(); idx++) {
				sources[idx] = pathname+File.separator+listFile.get(idx).getSaveFileName();//원본파일
				originals[idx] = File.separator+listFile.get(idx).getOriginalFileName();  //압축할 파일
			}
			
			b = fileManager.doZipFileDownload(sources, originals, zipFilename, resp);
		}
		
		if (!b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능 합니다.');history.back();</script>");
			} catch (Exception e) {
			}
		}
	}
	
	//게시글 좋아요 추가 :  AJAX-JSON
		@RequestMapping(value="/admin/freeBoard/insertBoardLike",method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> insertBoardLike(
				@RequestParam int num,
				HttpSession session
				) throws Exception {
			
			String state="true";
			int boardLikeCount=0;
			SessionInfo info = (SessionInfo)session.getAttribute("crew");
			
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("fbNum", num);
			paramMap.put("crewId", info.getCrewId());
			
			try {
				service.insertBoardLike(paramMap);
			} catch (Exception e) {
				state="false";
			}
			
			boardLikeCount =service.boardLikeCount(num);
			
			Map<String, Object> model=new HashMap<>();
			model.put("state", state);
			model.put("boardLikeCount", boardLikeCount);
			
			return model;
		}
		
		// 댓글 리스트 : AJAX-TEXT
		@RequestMapping("/admin/freeBoard/listReply")
		public String listReply(
				@RequestParam int fbNum,
				@RequestParam(value="pageNo", defaultValue="1")int current_page,
				Model model
				)throws Exception{
			
			int rows=5;
			int total_page = 0;
			int dataCount = 0;
			
			Map<String, Object> map = new HashMap<>();
			map.put("fbNum", fbNum);
			
			dataCount = service.replyCount(map);
			total_page = myUtil.pageCount(rows, dataCount);
			if(current_page>total_page) {
				current_page=total_page;
			}
			
			int offset = (current_page-1) * rows;
			if(offset<0) {
				offset = 0;
			}
			
			map.put("offset", offset);
			map.put("rows", rows);
			
			List<Reply> listReply = service.listReply(map);
			
			for(Reply dto : listReply) {
				dto.setContent(myUtil.htmlSymbols(dto.getContent()));
				dto.setCreated(dto.getCreated().substring(0,10));
			}
			
			// AJAX 용 페이징
			String paging =myUtil.pagingMethod(current_page, total_page, "listPage");
			
			// 포워딩할 jsp로 넘길 데이터
			model.addAttribute("listReply",listReply);
			model.addAttribute("pageNo",current_page);
			model.addAttribute("replyCount",dataCount);
			model.addAttribute("total_page",total_page);
			model.addAttribute("paging",paging);
			
			return "/admin/freeBoard/listReply";
		}
		
		// 댓글 및 댓글의 답글 등록 : AJAX-JSON
		@RequestMapping(value="/admin/freeBoard/insertReply", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> insertReply(
				Reply dto,
				HttpSession session
				) {
			SessionInfo info = (SessionInfo) session.getAttribute("crew");
			String state = "true";
			
			try {
				dto.setCrewId(info.getCrewId());
				service.insertReply(dto);
			} catch (Exception e) {
				state = "false";
			}
			
			Map<String, Object> model = new HashMap<>();
			model.put("state", state);
			
			return model;
		}

		// 댓글 및 댓글의 답글 삭제 : AJAX-JSON
		@RequestMapping(value="/admin/freeBoard/deleteReply",method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> deleteReply(
				@RequestParam Map<String,Object> paramMap
				){
			String state="true";
			try {
				service.deleteReply(paramMap);
			} catch (Exception e) {
				state="false";
			}
			
			Map<String, Object> map = new HashMap<>();
			map.put("state", state);
			
			return map;
		}
		
		//댓글 좋아요 추가
		@RequestMapping(value="/admin/freeBoard/insertReplyLike", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> insertReplyLike(
				@RequestParam Map<String, Object> paramMap,
				HttpSession session
				)throws Exception{
			String state = "true";
			
			SessionInfo info = (SessionInfo) session.getAttribute("crew");
			Map<String, Object> model = new HashMap<>();
			
			
			
			try {
				paramMap.put("crewId", info.getCrewId());
				service.insertReplyLike(paramMap);
			} catch (Exception e) {
				state="false";
			}
			Map<String, Object> countMap = service.replyLikeCount(paramMap);
			
			int likeCount = ((BigDecimal)countMap.get("LIKECOUNT")).intValue();
			
			model.put("likeCount", likeCount);
			model.put("state", state);
			
			return model;
		}
		
		//댓글 좋아요 갯수 : AJAX-JSON
		@RequestMapping(value="/admin/freeBoard/countReplyLike", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> countReplyLike(
				@RequestParam Map<String, Object> paramMap,
				HttpSession session
				)throws Exception {
		
			Map<String, Object> countMap =service.replyLikeCount(paramMap);
			
			int likeCount = ((BigDecimal)countMap.get("LIKECOUNT")).intValue();
			Map<String, Object>model=new HashMap<>();
			model.put("likeCount", likeCount);
			
			return model;
		}
		
		 // 댓글의 답글 리스트 : AJAX-TEXT
		@RequestMapping("/admin/freeBoard/listReplyAnswer")
		public String listReplyAnswer(
				@RequestParam int answer,
				Model model
				)throws Exception{
			
			List<Reply> listReplyAnswer = service.listReplyAnswer(answer);
			for(Reply dto : listReplyAnswer) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}
			
			model.addAttribute("listReplyAnswer",listReplyAnswer);
			
			return "/admin/freeBoard/listReplyAnswer";
		}
		
		//댓글의 답글 개수 :  AJAX-JSON
		@RequestMapping("/admin/freeBoard/countReplyAnswer")
		@ResponseBody
		public Map<String , Object> countReplyAnswer (@RequestParam("answer")int answer){
			int count = service.replyAnswerCount(answer);
			Map<String, Object> model = new HashMap<>();
			model.put("count", count);
			
			return model;
		}
}
