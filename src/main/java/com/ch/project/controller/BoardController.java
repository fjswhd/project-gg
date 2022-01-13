package com.ch.project.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ch.project.model.Board;
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
	@RequestMapping("/detail")
	public String detail(Integer b_no, Model model) {
		
		Board board = bs.getBoard(b_no);
		
		String address = board.getAddress();
		String place = address.substring(0, address.lastIndexOf("("));
		address = address.substring(address.lastIndexOf("(") + 1, address.lastIndexOf(")"));
		
		model.addAttribute("board", board);
		model.addAttribute("place", place);
		model.addAttribute("address", address);
		return "board/detail";
	}
	@RequestMapping("/request")
	public String request() {
		return "board/fragment/request";
	}
	@RequestMapping("/parti")
	public String parti() {
		return "board/fragment/parti";
	}
	
	@RequestMapping("/insert")
	public String insert(Board board) {
		//현재 게시글 개수 구해서 다음 게시글의 글 번호 설정
		int boardCount = bs.getBoardCount();
		board.setB_no(boardCount + 1);
		
		//게시글 DB에 넣기
		int result = bs.insertBoard(board);
		System.out.println(result);
		return "redirect:/board/detail.do?b_no="+board.getB_no();
	}
	
	@RequestMapping("/search")
	public String search(Board board, String keyword, Model model) {
		System.out.println(board);
		System.out.println(keyword);
		return "board/searchList";
	}
}
