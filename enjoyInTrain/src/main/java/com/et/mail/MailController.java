package com.et.mail;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller("mail.mailController")
public class MailController {
	@Autowired
	private MailSender mailSender;
	
	@RequestMapping(value="/mail/send", method=RequestMethod.GET)
	public String sendForm() throws Exception {
		return ".mail.send";
	}

	@RequestMapping(value="/mail/send", method=RequestMethod.POST)
	public String sendSubmit(Mail dto, 
			final RedirectAttributes reAttr) throws Exception {

		boolean b=mailSender.mailSend(dto);
		
		String msg="<span style='color:blue;'>"+dto.getReceiverEmail()+"</span> 님에게<br>";
		if(b) {
			msg+="메일을 성공적으로 전송 했습니다.";
		} else {
			msg+="메일을 전송하는데 실패했습니다.";
		}
		
		reAttr.addFlashAttribute("message", msg);
		
		return "redirect:/mail/complete";
	}
	
	@RequestMapping(value="/mail/complete")
	public String complete(@ModelAttribute("message") String message) throws Exception{
		
		if(message==null || message.length()==0) // F5를 누른 경우
			return "redirect:/";
		
		return ".mail.complete";
	}
	
}
