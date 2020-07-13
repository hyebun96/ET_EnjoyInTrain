package com.et.crew;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.et.booking.Booking;
import com.et.booking.BookingService;
import com.et.reservation.Reservation;
import com.et.reservation.ReservationService;

@Controller("crew.crewController")
@RequestMapping("/crew/*")
public class CrewController {
	
	
	@Autowired
	private CrewService service;
	
	@Autowired
	private ReservationService service2;
	
	@Autowired
	private BookingService bookingService;
	
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
	
	@RequestMapping(value="idfind")
	public String idfind(
			HttpSession session,
			Model model
			) throws Exception {
		

		return ".crew.idfind";
	}
	
	@RequestMapping(value="idfind2")
	public String idfind(
			HttpSession session,
			Model model,
			@RequestParam String crewName,
			@RequestParam String crewTel
			) throws Exception {
		
		Crew dto = new Crew();
		dto.setCrewName(crewName);
		dto.setCrewTel(crewTel);
		
		
		String crewId = service.readCrew2(dto);
		
		
   	    model.addAttribute("dto", dto);
   	    model.addAttribute("crewId", crewId);
		
        
		return "/crew/idfind2";
	}
	
	@RequestMapping(value="mypage")
	public String mypage(
			HttpSession session,
			Model model
			)throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("crew");
		
		Crew dto = service.readCrew(info.getCrewId());
		
		List<Reservation> list = service2.readDetail(info.getCrewId());
		List<Booking> list2 = bookingService.readDetail2(info.getCrewId());
		
		model.addAttribute("dto",dto);
		model.addAttribute("list",list);
		model.addAttribute("list2",list2);
		
		
		return ".crew.mypage";
	}
	
	
	@RequestMapping(value="emailfind", method=RequestMethod.POST)
	public String pwdfindSubmit(
			@RequestParam String pwdId,
			@RequestParam String pwdTel,
			final RedirectAttributes reAttr,
			Model model
			) throws Exception{

		Crew dto = service.readCrew(pwdId);
		if(dto==null || dto.getCrewEmail()==null || dto.getCrewTel()==null || ! dto.getCrewTel().equals(pwdTel)) {
			model.addAttribute("message","등록된 아이디가 아닙니다.");
			return ".crew.idfind";
		}
		
		try {
			service.generatePwd(dto);
		} catch (Exception e) {
			model.addAttribute("message","이메일 전송이 실패하였습니다.");
			return ".crew.idfind";
		}
		
		StringBuilder sb = new StringBuilder();
		sb.append("회원님의 이메일로 임시 패스워드가 전송 되었습니다.");
		sb.append("로그인후 패스워드를 변경하시기 바랍니다.<br>");
		
		reAttr.addFlashAttribute("title","패스워드찾기");
		reAttr.addFlashAttribute("message",sb.toString());
		
		return "redirect:/crew/complete";
	}
	
}
