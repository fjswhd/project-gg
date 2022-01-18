package com.ch.project.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ch.project.model.Board;
import com.ch.project.model.Category;
import com.ch.project.service.BoardService;
import com.google.gson.Gson;

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
	@RequestMapping("/updateForm")
	public String updateForm(int b_no, Model model) {
		List<Category> categoryList = bs.getCategories();
		
		Board board = bs.getBoard(b_no);

		model.addAttribute("categoryList", categoryList);
		model.addAttribute("board", board);
		
		return "board/updateForm";
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
		
		//나중에 json 객체로 만들때 오류나지 않게 "앞에 \넣어주기
		String content = board.getContent().replace("\"", "\\\"");
		board.setContent(content);
		
		//게시글 DB에 넣기
		int result = bs.insertBoard(board);
		
//		for(int i = 0; i < 100; i++) {
//			Board b = new Board();
//			int boardCount = bs.getBoardCount();
//			b.setB_no(boardCount + 1);
//			b.setC_no(board.getC_no());
//			b.setM_id(board.getM_id());
//			b.setAddress(board.getAddress());
//			b.setContent(board.getContent());
//			b.setS_date(board.getS_date());
//			b.setE_date(board.getE_date());
//			b.setM_count(board.getM_count());
//			b.setReadcount(board.getReadcount());
//			b.setSubject(board.getSubject());
//			
//			int result = bs.insertBoard(b);
//		}
		
		
		return "redirect:/board/detail.do?b_no="+board.getB_no();
	}
	
	@RequestMapping("/update")
	public String update(Board board) {
		//나중에 json 객체로 만들때 오류나지 않게 "앞에 \넣어주기
		String content = board.getContent().replace("\"", "\\\"");
		board.setContent(content);
		
		System.out.println(board);
		
		//게시글 DB에 넣기
		int result = bs.updateBoard(board);
		
		return "redirect:/board/detail.do?b_no="+board.getB_no();
	}
	
	@RequestMapping("/searchList")
	public String searchListForm(@RequestParam Map<String, Object> param, Model model) throws ParseException {
		//카테고리 리스트
		List<Category> categoryList = bs.getCategories();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		String today = sdf.format(cal.getTime());
		
		cal.add(Calendar.MONTH, 3);
		String lastday = sdf.format(cal.getTime());
		
		//map(뿐 아니라 자바 객체)를 json 객체로..
		Gson gson = new Gson();
		String json = gson.toJson(param);
		
		/*
		 * JSONArray jCategoryList = new JSONArray();
		 * 
		 * for(Category c : categoryList) { JSONObject jCategory = new JSONObject();
		 * jCategory.put("c_no", c.getC_no()); jCategory.put("c_name", c.getC_name());
		 * 
		 * jCategoryList.add(jCategory); }
		 * model.addAttribute("jCategoryList", jCategoryList);
		 */
		
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("today", today);
		model.addAttribute("lastday", lastday);
		model.addAttribute("json", json);
		
		return "board/searchList";
	}
	
	@RequestMapping(value = "/search", produces = "application/json;charset=utf-8")
	@ResponseBody
	public Map<String, Object> searchList(@RequestBody Map<String, Object> param) {
		//게시글 검색
		// 페이지당 열 개수
		final int ROW_PER_PAGE = 15;
	
		// 페이지 버튼 블럭당 페이지 개수
		final int PAGE_PER_BLOCK = 5;
		
		int totalBoard  = bs.getSearchBoardCount(param);
		
		//마지막 페이지
		int endPage = (totalBoard - 1) / ROW_PER_PAGE + 1;
		
		// 현재 페이지 
		int pageNum = 1;
		
		if(param.containsKey("pageNum")) {
			String str = param.get("pageNum").toString();			
			
			//pageNum이 숫자면
			if(str.matches("^[0-9]+$")) {
				pageNum = Integer.parseInt(str);
			}
		}
		
		// 페이지 값이 1보다 작으면 페이지 값은 1
		// 페이지 값이 마지막 페이지보다 크면 페이지 값은 마지막 페이지
		pageNum = pageNum < 1 ? 1 : pageNum;
		pageNum = pageNum > endPage ? endPage : pageNum;
		
		// 꺼내올 첫번째 열 = (현재 페이지 - 1) * 페이지 당 열 개수 + 1;
		// 꺼내올 마지막 열 = 현재 페이지 * 페이지당 열 개수
		int startRow = (pageNum - 1) * ROW_PER_PAGE + 1;
		int endRow = pageNum * ROW_PER_PAGE;
		
		// pageButton에 넣을 변수 만들기
		int firstPage = PAGE_PER_BLOCK * ((pageNum - 1) / PAGE_PER_BLOCK) + 1;
		int lastPage = PAGE_PER_BLOCK * ((pageNum - 1) / PAGE_PER_BLOCK + 1);
		
		firstPage = firstPage < 1 ? 1 : firstPage;
		lastPage = lastPage > endPage ? endPage : lastPage;
		
		//매개변수에 topN 변수 넣고 전달
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		
		List<Board> boardList = bs.searchBoard(param);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("itemList", boardList);
		resultMap.put("firstPage", firstPage);
		resultMap.put("lastPage", lastPage);
		resultMap.put("pageNum", pageNum);
		resultMap.put("endPage", endPage);
		
		return resultMap;
	}
}
