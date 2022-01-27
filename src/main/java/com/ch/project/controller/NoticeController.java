package com.ch.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ch.project.model.Notice;
import com.ch.project.service.NoticeService;

@Controller
@RequestMapping("notice")
public class NoticeController {
	@Autowired
	private NoticeService ns;
	
	@RequestMapping("/list")
	public String list(Integer page, Model model) {
		//게시글 검색
		// 페이지당 열 개수
		final int ROW_PER_PAGE = 10;
	
		// 페이지 버튼 블럭당 페이지 개수
		final int PAGE_PER_BLOCK = 5;
		
		int totalNotice  = ns.selectTotalNotice();
		
		//마지막 페이지
		int endPage = (totalNotice - 1) / ROW_PER_PAGE + 1;
		
		// 현재 페이지 
		if (page == null) {
			page = 1;			
		}
		
		// 페이지 값이 1보다 작으면 페이지 값은 1
		// 페이지 값이 마지막 페이지보다 크면 페이지 값은 마지막 페이지
		page = page < 1 ? 1 : page;
		page = page > endPage ? endPage : page;
		
		// 꺼내올 첫번째 열 = (현재 페이지 - 1) * 페이지 당 열 개수 + 1;
		// 꺼내올 마지막 열 = 현재 페이지 * 페이지당 열 개수
		int startRow = (page - 1) * ROW_PER_PAGE + 1;
		int endRow = page * ROW_PER_PAGE;
		
		// pageButton에 넣을 변수 만들기
		int firstPage = PAGE_PER_BLOCK * ((page - 1) / PAGE_PER_BLOCK) + 1;
		int lastPage = PAGE_PER_BLOCK * ((page - 1) / PAGE_PER_BLOCK + 1);
		
		firstPage = firstPage < 1 ? 1 : firstPage;
		lastPage = lastPage > endPage ? endPage : lastPage;
		
		//매개변수에 topN을 위한 row 변수 넣고 전달
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		
		List<Notice> noticeList = ns.selectNoticeList(param);
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("firstPage", firstPage);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("page", page);
		
		return "notice/list";
	}
	@RequestMapping("/insertForm")
	public String insertForm() {
		return "notice/insertForm";
	}
	@RequestMapping("/insert")
	public String insert(Notice notice) {
		int no_no = ns.selectNoticeNum();
		notice.setNo_no(no_no);
		
		int result = 0;
		result = ns.insertNotice(notice);
		
		return "redirect:/notice/list";
	}
	@RequestMapping("/detail")
	public String detail(int no_no, Model model) {
		Notice notice = ns.selectNotice(no_no);
		
		model.addAttribute("notice", notice);
		
		return "notice/detail";
	}
	@RequestMapping("/updateForm")
	public String updateForm(int no_no, Model model) {
		Notice notice = ns.selectNotice(no_no);
		
		model.addAttribute("notice", notice);
		
		return "notice/updateForm";
	}
	@RequestMapping("/update")
	public String update(Notice notice) {
		int result = 0;
		result = ns.updateNotice(notice);
		
		return "redirect:/notice/detail.do?no_no="+notice.getNo_no();
	}
	@RequestMapping("/delete")
	public String delete(Notice notice, Model model) {
		int result = 0;
		notice.setDel("y");
		result = ns.updateNotice(notice);
		
		model.addAttribute("result", result);
		
		return "notice/delete";
	}
	
	@RequestMapping("/latest")
	public String latest(Model model) {
		//매개변수에 topN을 위한 row 변수 넣고 전달
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("startRow", 1);
		param.put("endRow", 10);
		
		List<Notice> noticeList = ns.selectNoticeList(param);
		
		int no_no = noticeList.get(1).getNo_no();
		
		return "redirect:/notice/detail.do?no_no="+no_no;
	}
	@RequestMapping("/latest2")
	public String latest2(Model model) {
		//매개변수에 topN을 위한 row 변수 넣고 전달
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("startRow", 1);
		param.put("endRow", 10);
		
		List<Notice> noticeList = ns.selectNoticeList(param);
		
		int no_no = noticeList.get(0).getNo_no();
		
		return "redirect:/notice/detail.do?no_no="+no_no;
	}
	
}
