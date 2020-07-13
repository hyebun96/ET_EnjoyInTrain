package com.et.crew;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.et.common.MyUtil;

@Controller("crew.crewController")
@RequestMapping("/crew/*")
public class CrewController {
	
	@Autowired
	private CrewService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String loginForm() {
		return ".crew.login";
	}
	 
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String loginSubmit(
			@RequestParam String crewId,
			@RequestParam String crewPwd,
			Model model,
			HttpSession session
			) {
		Crew dto=service.readCrew(crewId);
		if(dto==null||!dto.getCrewPwd().equals(crewPwd)) {
			model.addAttribute("message","아이디 또는 패스워드가 일치하지 않습니다.");
			return ".crew.login";
		}
		
		SessionInfo info=new SessionInfo();
		info.setCrewId(dto.getCrewId());
		info.setCrewName(dto.getCrewName());
		session.setMaxInactiveInterval(30*60);  //세션유지시간 30분
		session.setAttribute("crew", info);
		
		String uri=(String)session.getAttribute("preLoginURI");
		session.removeAttribute("preLoginURI");
		if(uri==null) {
			uri="redirect:/";
		}else {
			uri="redirect:"+uri;
		}
		
		return uri;
	}
	
	@RequestMapping(value="logout")
	public String logout(HttpSession session) {
		session.removeAttribute("crew");
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value="crew", method=RequestMethod.GET)
	public String crewForm(Model model) {
		model.addAttribute("mode","crew");
		return ".crew.crew";
	}
	
	@RequestMapping(value="crew", method=RequestMethod.POST)
	public String crewSubmit(
			Crew dto,
			final RedirectAttributes reAttr,
			Model model
			) {
		try {
			service.insertCrew(dto);
		} catch (Exception e) {
			model.addAttribute("mode","crew");
			model.addAttribute("message","아이디 중복으로 회원가입이 실패했습니다.");
			
			return ".crew.crew";
		}
		
		StringBuilder sb=new StringBuilder();
		sb.append(dto.getCrewName()+ "님의 회원 가입이 정상적으로 처리되었습니다.<br>");
		sb.append("메인화면으로 이동하여 로그인 하시기 바랍니다.<br>");
		
		reAttr.addFlashAttribute("title","회원 가입");
		reAttr.addFlashAttribute("message",sb.toString());
		
		return "redirect:/crew/complete";
	}
	
	@RequestMapping(value="crewIdCheck", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> idCheck(
			@RequestParam String crewId
			) throws Exception{
		
		String p="true";
		Crew dto=service.readCrew(crewId);
		if(dto!=null) {
			p="false";
		}
		Map<String, Object> model=new HashMap<>();
		model.put("passed", p);
		return model;
	}
	
	@RequestMapping(value="complete")
	public String complete(
			@ModelAttribute("message") String message
			)throws Exception{
		if(message==null||message.length()==0) {
			return "redirect:/";
		}
		return ".crew.complete";
	}
	
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			Model model, 
			HttpSession session,
			Crew dto
		) {
		SessionInfo info=(SessionInfo)session.getAttribute("crew");
		
		dto=service.readCrew(info.getCrewId());

		model.addAttribute("dto",dto);
		model.addAttribute("mode","update");
		
		return ".crew.crew2";
	}
	
	@RequestMapping(value="update",method = RequestMethod.POST)
	public String updateSubmit(
			Crew dto,
			final RedirectAttributes reAttr,
			Model model
			)throws Exception{
		
		try {
			service.updateCrew(dto);
		} catch (Exception e) {
			model.addAttribute("mode","update");
			model.addAttribute("message","회원수정이 실패했습니다.");
			
			return ".crew.crew2";
		}
		
		StringBuilder sb = new StringBuilder();
		sb.append(dto.getCrewName() + "님의 회원정보가 정상적으로 변경되었습니다.<br>");
		sb.append("메인화면으로 이동하시기 바랍니다.<br>");
		
		reAttr.addFlashAttribute("title","회원정보수정");
		reAttr.addFlashAttribute("dto",dto);
		reAttr.addFlashAttribute("message",sb.toString());
		
		return "redirect:/crew/complete";
	}
	
	@RequestMapping(value="/crew/idfind")
	public String idfind(@RequestParam(value="page", defaultValue="1") int current_page,
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

        dataCount = service.dataCount(map);
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
        List<Crew> list = service.listCrew(map);

        // 리스트의 번호
        int listNum, n = 0;
        for(Crew dto:list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
        
        String query = "";
        String listUrl = cp+"/crew/idfind";
        
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
        
		return ".crew.idfind";
	}
	
	@RequestMapping(value="mypage", method=RequestMethod.GET)
	public String mypage(
			HttpSession session,
			Model model
			)throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("crew");
		
		Crew dto = service.readCrew(info.getCrewId());
		
		
		
		model.addAttribute("dto",dto);
		
		
		return ".crew.mypage";
	}
	
	
	
}
