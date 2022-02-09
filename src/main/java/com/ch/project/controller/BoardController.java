package com.ch.project.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import com.ch.project.model.Member;
import com.ch.project.model.Parti;
import com.ch.project.model.Request;
import com.ch.project.service.BoardService;
import com.ch.project.service.PartiService;
import com.ch.project.service.RequestService;
import com.google.gson.Gson;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private BoardService bs;
	@Autowired
	private RequestService rs;
	@Autowired
	private PartiService ps;
	
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
		
		//글쓴이 포함 현재 참여자 구하기
		List<Parti> partiList = ps.ptList(b_no);
		int currentParti = partiList.size() + 1;

		model.addAttribute("categoryList", categoryList);
		model.addAttribute("board", board);
		model.addAttribute("currentParti", currentParti);
		
		return "board/updateForm";
	}
	@RequestMapping("/placeSearch")
	public String placeSearch() {
		return "board/placeSearch";
	}
	@RequestMapping("/detail")
	public String detail(Integer b_no, HttpSession session, Model model) {
		Board board = bs.getBoard(b_no);
		//신청자 현황 >> 현재 사용자가 신청자인지 판별하기 위해 사용
		
		//1. 로그인 하지 않은 사용자(session.getAttribute("member") == null) >> 신청버튼도 안나오니 만들어줄 이유가 없음
		//2. 로그인 한 사용자 	(session.getAttribute("member") != null) >> 현재 신청한 상태인지 (request 테이블에 값이 있고  accept = 'w', cancel = 'n') 
		if(session.getAttribute("member") != null) {
			Member member = (Member) session.getAttribute("member");
			
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("b_no", b_no);
			param.put("m_id", member.getM_id());
			
			Request request = rs.select(param);
			
			if (request == null) {
				model.addAttribute("requestPossible", true);
			} else {
				model.addAttribute("requestPossible", false);
			}
			//4. 사용자가 강퇴자인 경우
			Parti parti = ps.banned(param);
			
			if (parti == null) {
				model.addAttribute("banned", false);
			} else {
				model.addAttribute("banned", true);
			}
		}
		
		//3. 현재 참여자 명수가 게시글 참여자 명수 + 1(글쓴이 포함)과 같은 경우
		List<Parti> partiList = ps.ptList(b_no);
		if(board.getM_count() == partiList.size() + 1) {
			model.addAttribute("full", true);
		} else {
			model.addAttribute("full", false);
		}
		model.addAttribute("partiNum", partiList.size() + 1);
		
		String address = board.getAddress();
		String place = address.substring(0, address.lastIndexOf("("));
		address = address.substring(address.lastIndexOf("(") + 1, address.lastIndexOf(")"));
		
		model.addAttribute("board", board);
		model.addAttribute("place", place);
		model.addAttribute("address", address);
		
		return "board/detail";
	}
	
	
	@RequestMapping("/insert")
	public String insert(Board board) {
		//현재 게시글 개수 구해서 다음 게시글의 글 번호 설정
		int nextB_no = bs.getMaxB_no() + 1;
		board.setB_no(nextB_no);
		
		//게시글 DB에 넣기
		int result = bs.insertBoard(board);
		
		if (result == 1)
			return "redirect:/board/detail.do?b_no="+board.getB_no();
		else 
			return "redirect:/error";
	}
	
	@RequestMapping("/update")
	public String update(Board board) {
		//게시글 DB에 넣기
		int result = bs.updateBoard(board);
		
		if (result == 1)
			return "redirect:/board/detail.do?b_no="+board.getB_no();
		else 
			return "redirect:/error";
	}
	
	@RequestMapping("/recruitEnd")
	public String recruitEnd(int b_no) {
		int result = bs.updateBoardEndY(b_no);
		
		if (result == 1)
			return "redirect:/board/detail.do?b_no="+b_no;
		else
			return "redirect:/error";
	}
	@RequestMapping("/recruitStart")
	public String recruitStart(int b_no) {
		int result = bs.updateBoardEndN(b_no);
		
		if (result == 1)
			return "redirect:/board/detail.do?b_no="+b_no;
		else
			return "redirect:/error";
	}
	
	@RequestMapping("/searchList")
	public String searchListForm(@RequestParam Map<String, Object> param, Model model) throws ParseException {
		//param : s_date, e_date, address, c_no, keyword
		
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
		 * for(Category c : categoryList) { 
		 * 		JSONObject jCategory = new JSONObject();
		 * 		jCategory.put("c_no", c.getC_no()); 
		 * 		jCategory.put("c_name", c.getC_name());
		 * 
		 * 		jCategoryList.add(jCategory); 
		 * }
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
		/*
		 *  searchResult 
		 *  itemList 	: boardList (검색된 게시글 리스트)
		 *  firstPage 	: 페이징버튼 중 첫번째 버튼의 페이지 번호
		 *  lastPage 	: 페이징 버튼 중 마지막 버튼의 페이지 번호
		 *  pageNum 	: 현재 페이지 번호
		 *  
		 */
		Map<String, Object> searchResult = bs.searchBoard2(param);
		
		return searchResult;
	}
}
