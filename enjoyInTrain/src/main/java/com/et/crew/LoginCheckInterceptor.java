package com.et.crew;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	private final Logger logger = LoggerFactory.getLogger(LoginCheckInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler)
			throws Exception {
		boolean result= true;
		
		try {
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("crew");
			String cp = req.getContextPath();
			String uri = req.getRequestURI();
			String queryString = req.getQueryString();
			
			if(info==null) {
				result = false;
				
				if(isAjaxRequest(req)) {
					resp.sendError(403);
				} else {
					if(uri.indexOf(cp)==0) {
						uri=uri.substring(req.getContextPath().length());
					}
					if(queryString!=null) {
						uri+="?"+queryString;
					}

					session.setAttribute("preLoginURI", uri);
					
					resp.sendRedirect(cp+"/crew/login");
				}
			}
		} catch (Exception e) {
			logger.info("pre: "+e.toString());
		}
		
		return result;
	}

	@Override
	public void postHandle(HttpServletRequest req, HttpServletResponse resp, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest req, HttpServletResponse resp, Object handler, Exception ex)
			throws Exception {
	}
	
	private boolean isAjaxRequest(HttpServletRequest req) {
		String header = req.getHeader("AJAX");
		return header!=null && header.equals("ture");
	}
	
}
