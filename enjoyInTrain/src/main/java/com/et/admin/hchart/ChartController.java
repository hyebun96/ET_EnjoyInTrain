package com.et.admin.hchart;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.et.travel.Chart;
import com.et.travel.TravelService;

@Controller("admin.hchart.chartController")
@RequestMapping("/admin/trainsales/*")
public class ChartController {
	
	@Autowired
	private TravelService service;
	
	@RequestMapping(value="/pmlist")
	public String main() throws Exception {
		return ".admin.trainsales.pmlist";
	}
	

	@RequestMapping(value="/semi", produces="application/json;charset=utf-8")	// 한글깨짐 방지
	@ResponseBody
	public String semi() throws Exception{
		JSONArray arr = new JSONArray();
		
		JSONObject job = new JSONObject();
		job.put("name", "지역별 매출");
		job.put("type", "pie");
		job.put("innerSize", "50%");
		
		List<Chart> list = service.areaChart();

		JSONArray ja = new JSONArray();
		ja.put(new JSONArray("['수도권',"+ list.get(0).getCount() +"]"));
		ja.put(new JSONArray("['강원권',"+ list.get(1).getCount() +"]"));
		ja.put(new JSONArray("['충청권',"+ list.get(2).getCount() +"]"));
		ja.put(new JSONArray("['경상권',"+ list.get(3).getCount() +"]"));
		ja.put(new JSONArray("['전라권',"+ list.get(4).getCount() +"]"));
		
		job.put("data",ja);
		
		arr.put(job);
		
		return arr.toString();
		
	}
	
	@RequestMapping(value="/semi2", produces="application/json;charset=utf-8")	// 한글깨짐 방지
	@ResponseBody
	public String semi2() throws Exception{
		JSONArray arr = new JSONArray();
		
		JSONObject job = new JSONObject();
		job.put("name", "프로모션 매출");
		job.put("colorByPoint", "true");
		
		List<Chart> list = service.promotionChart();

		JSONArray ja = new JSONArray();
		
		for(Chart vo:list) {
			ja.put(new JSONArray("['"+ vo.getPmCode() +"',"+ vo.getCount() + ",'" + vo.getProduct() + "']"));
		}
	
		job.put("data",ja);
		
		arr.put(job);
		
		return arr.toString();
	}

	
}
