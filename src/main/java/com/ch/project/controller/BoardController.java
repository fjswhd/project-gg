package com.ch.project.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ch.project.model.Category;
import com.ch.project.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private BoardService bs;
	
	@RequestMapping("/insertForm")
	public String insertForm(Model model) {
		List<Category> categoryList = bs.getCategories();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		String today = sdf.format(cal.getTime());
		
		cal.add(Calendar.MONTH, 3);
		String lastday = sdf.format(cal.getTime());
		
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("today", today);
		model.addAttribute("lastday", lastday);
		
		return "board/insertForm";
	}
	@RequestMapping("/placeSearch")
	public String placeSearch() {
		return "board/placeSearch";
	}
	@RequestMapping("/insert")
	public String insert(@RequestParam Map<String, String> param) {
		int result = 0;
		for(Map.Entry<String, String> entry : param.entrySet()) {
			System.out.println(entry.getKey() +" : "+ entry.getValue());
		}
		result = 1;
		
		return "home";
	}
}
