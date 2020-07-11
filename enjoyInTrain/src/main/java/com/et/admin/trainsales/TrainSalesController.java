package com.et.admin.trainsales;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("admin.trainsales.TrainSalesController")
public class TrainSalesController {
	
	@RequestMapping(value="/admin/trainsales/list")
	public String main() throws Exception {
		return ".admin.trainsales.list";
	}
}
