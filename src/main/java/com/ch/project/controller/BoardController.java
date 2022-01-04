package com.ch.project.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ch.project.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private BoardService bs;
	
	@RequestMapping("/insertForm")
	public String insertForm() {
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
