package com.et.train;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.et.common.MyUtil;

@Controller("train.trainController")
@RequestMapping("/train/*")
public class trainController {
	
	@Autowired
	private MyUtil myutil;
	
	@Autowired
	private TrainService service;
	
	@RequestMapping(value="list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int page,
			Model model
			) throws Exception {
		
		int rows = 10;
		int total_page = 0;
		int trainCount = 0;
		
		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		
		trainCount = service.trainCount();
		if(trainCount!=0) {
			total_page = myutil.pageCount(rows, trainCount);
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
		List<Train> list = service.listTrain(map);
		
		// 리스트의 번호
		int listNum, n=0;
		for(Train dto : list) {
			listNum = trainCount - (offset + n);
			dto.setTrainCount(listNum);
			n++;
		}
		
		String paging = myutil.paging(page, total_page);
		
		model.addAttribute("list",list);
        model.addAttribute("page", page);
        model.addAttribute("trainCount", trainCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
		
		return ".train.list";
	}
	
	@RequestMapping(value="created", method=RequestMethod.GET)
	public String insertForm() throws Exception {
		
		return ".train.created";
	}
	
	// 게시글 작성
	@RequestMapping(value="created", method=RequestMethod.POST)
	public String insert(
			Train dto
			) throws Exception {
		
		try {
			service.insertTrain(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/train/list";
	}
	
}
