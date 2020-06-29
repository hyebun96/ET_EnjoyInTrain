package com.et.admin.suggest;

import java.io.File;
import java.io.PrintWriter;
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
import com.et.suggest.Comment;
import com.et.suggest.Suggest;
import com.et.suggest.SuggestService;

@Controller("admin.suggest.suggestController")
@RequestMapping("/admin/suggest/*")
public class SuggestController {
	@Autowired
	private SuggestService service;
	
	@Autowired
	private MyUtil util;
	
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping("/admin/suggest/list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="10") int rows,
			HttpServletRequest req,
			Model model
			) {
		
		int total_page;
		int dataCount;
		
		dataCount=service.dataCount();
		total_page=util.pageCount(rows, dataCount);
		
		if(total_page<current_page) {
			current_page=total_page;
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		int offset=(current_page-1)*rows;
		if(offset<0) offset=0;
		map.put("offset",offset);
		map.put("rows",rows);
		
		List<Suggest> list=service.listSuggest(map);
		
		int listNum, n=0;
		for(Suggest dto:list) {
			listNum=dataCount-(offset+n);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp=req.getContextPath();
		String query="rows="+rows;
		String listUrl=cp+"/admin/suggest/list";
		String articleUrl=cp+"/admin/suggest/article?page="+current_page;
		
		listUrl+="?"+query;
		articleUrl+="&"+query;
		String paging=util.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list",list);
		model.addAttribute("rows",rows);
		model.addAttribute("paging",paging);
		model.addAttribute("articleUrl",articleUrl);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("page",current_page);
		model.addAttribute("query",query);
		return ".admin.suggest.list";
	}
	
	@RequestMapping("/admin/suggest/article")
	public String article(
			@RequestParam String page,
			@RequestParam int sgCode,
			@RequestParam int rows,
			Model model
			) throws Exception {
		
		String query="page="+page+"&rows="+rows;
		
		service.updateHitCount(sgCode);
		Suggest dto=service.readSuggest(sgCode);
		
		List<Suggest> listFile=service.listFile(sgCode);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sgCode", sgCode);
		
		Suggest preReadDto = service.preReadSuggest(map);
		Suggest nextReadDto = service.nextReadSuggest(map);
		
		model.addAttribute("query",query);
		model.addAttribute("dto",dto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		return ".admin.suggest.article";
	}
	
	@RequestMapping("/admin/suggest/reply")
	public String replyForm(
			@RequestParam int sgCode,
			Model model
			) {
		Suggest dto=service.readSuggest(sgCode);
		model.addAttribute("dto",dto);
		model.addAttribute("mode","reply");
		return ".admin.suggest.created";
	}
	
	@RequestMapping("/admin/suggest/delete")
	public String delete(
			@RequestParam int sgCode,
			@RequestParam String page,
			@RequestParam int rows,
			HttpSession session
			) throws Exception{
		String query="page="+page+"&rows="+rows;
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "suggest";
		
		service.deleteSuggest(sgCode,pathname );
		
		return "redirect:/admin/suggest/list?"+query;
	}

	//------------------댓글
	//댓글달기
	@RequestMapping("/admin/suggest/createdComment")
	@ResponseBody
	public Map<String, Object> createdComment(
			Comment dto,
			HttpSession session
			) {
		SessionInfo info=(SessionInfo)session.getAttribute("crew");
		String state="true";
		try {
			dto.setCrewId(info.getCrewId());
			service.insertComment(dto);
		} catch (Exception e) {
			state="false";
		}
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping("/admin/suggest/listComment")
	public String listComment(
			@RequestParam int sgCode,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model
			) throws Exception{
		int rows=5;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("sgCode", sgCode);
		dataCount=service.commentCount(map);
		total_page=util.pageCount(rows, dataCount);
		
		if(total_page<current_page) {
			current_page=total_page;
		}
		
		int offset=(current_page-1)*rows;
		if(offset<0) offset=0;
		map.put("offset",offset);
		map.put("rows",rows);
		
		List<Comment> listComment=service.listComment(map);
		
		for(Comment dto : listComment) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		String paging=util.pagingMethod(current_page, total_page, "listPage");
		model.addAttribute("listComment",listComment);
		model.addAttribute("paging",paging);
		model.addAttribute("replyCount",dataCount);
		model.addAttribute("pageNo",current_page);
		model.addAttribute("total_page", total_page);
		return "/admin/suggest/listComment";
	}
	
	@RequestMapping("/admin/suggest/deleteComment")
	@ResponseBody
	public Map<String, Object> deleteComment(
			@RequestParam Map<String, Object> paramMap
			) throws Exception{
		
		String state="true";
		try {
			service.deleteComment(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("state", state);
		return map;
	}
	
	// 댓글 및 댓글의 답글 등록 : AJAX-JSON
		@RequestMapping(value="/admin/suggest/insertReply", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> insertReply(
				Comment dto,
				HttpSession session
				)throws Exception {
			SessionInfo info = (SessionInfo) session.getAttribute("crew");
			String state = "true";
			
			try {
				dto.setCrewId(info.getCrewId());
				service.insertComment(dto);
			} catch (Exception e) {
				state = "false";
			}
			
			Map<String, Object> model = new HashMap<>();
			model.put("state", state);
			
			return model;
		}
		
		 // 댓글의 답글 리스트 : AJAX-TEXT
		@RequestMapping("/admin/suggest/listReplyAnswer")
		public String listReplyAnswer(
				@RequestParam int answer,
				Model model
				)throws Exception{
			List<Comment> listReplyAnswer = service.listReplyAnswer(answer);
			for(Comment dto : listReplyAnswer) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}
			
			model.addAttribute("listReplyAnswer",listReplyAnswer);
			
			return "/admin/suggest/listCommentAnswer";
		}
		
		//댓글의 답글 개수 :  AJAX-JSON
		@RequestMapping("/admin/suggest/countReplyAnswer")
		@ResponseBody
		public Map<String , Object> countReplyAnswer (@RequestParam("answer")int answer){
			int count = service.replyAnswerCount(answer);
			Map<String, Object> model = new HashMap<>();
			model.put("count", count);
			
			return model;
		}
		
		
		@RequestMapping(value="/admin/suggest/download")
		public void download(
				@RequestParam int fileNum,
				HttpServletResponse resp,
				HttpSession session) throws Exception {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "notice";

			boolean b = false;
			
			Suggest dto = service.readFile(fileNum);
			if(dto!=null) {
				String saveFilename = dto.getSaveFilename();
				String originalFilename = dto.getOriginalFilename();
				
				b = fileManager.doFileDownload(saveFilename, originalFilename, pathname, resp);
			}
			
			if (!b) {
				try {
					resp.setContentType("text/html; charset=utf-8");
					PrintWriter out = resp.getWriter();
					out.println("<script>alert('파일 다운로드가 불가능 합니다 !!!');history.back();</script>");
				} catch (Exception e) {
				}
			}
		}
		
		@RequestMapping(value="/admin/suggest/deleteFile", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> deleteFile(
				@RequestParam int fileNum,
				HttpSession session) throws Exception {
			
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "notice";
			
			Suggest dto=service.readFile(fileNum);
			if(dto!=null) {
				fileManager.doFileDelete(dto.getSaveFilename(), pathname);
			}
			
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("field", "num");  //
			map.put("num", fileNum);  //
			service.deleteFile(map);
			
	   	    // 작업 결과를 json으로 전송
			Map<String, Object> model = new HashMap<>(); 
			model.put("state", "true");
			return model;
		}

		@RequestMapping(value="/admin/suggest/answer",method=RequestMethod.GET)
		public String answerForm(
				@RequestParam int sgCode,
				@RequestParam int page,
				@RequestParam int rows,
				Model model
				) {
			Suggest dto=service.readSuggest(sgCode);
			
			List<Suggest> listFile=service.listFile(sgCode);
			
			model.addAttribute("page",page);
			model.addAttribute("rows",rows);
			model.addAttribute("mode","update");
			model.addAttribute("dto",dto);
			model.addAttribute("listFile", listFile);
			return ".admin.suggest.answer";
		}
		
		
		@RequestMapping(value="/admin/suggest/answer", method=RequestMethod.POST)
		public String answerSubmit(
				Suggest dto,
				@RequestParam int page,
				@RequestParam int rows,
				HttpSession session
				)throws Exception {

			Map<String, Object> map=new HashMap<>();
			map.put("sgCode", dto.getSgCode());
			map.put("anContent", dto.getAnContent());
			String query="sgCode="+dto.getSgCode()+"&page="+page+"&rows="+rows;
			service.insertAn(map);
			return "redirect:/admin/suggest/article?"+query;
			//page, row 넘겨주기
		}
}
