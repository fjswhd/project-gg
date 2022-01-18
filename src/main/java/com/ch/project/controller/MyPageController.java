package com.ch.project.controller;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ch.project.model.Board;
import com.ch.project.model.Member;
import com.ch.project.model.Request;
import com.ch.project.service.BoardService;
import com.ch.project.service.MemberService;
import com.ch.project.service.RequestService;

@Controller
@RequestMapping("myPage")
public class MyPageController {
	@Autowired
	private MemberService ms;
	@Autowired
	private BoardService bs;
	@Autowired
	private RequestService rs;
	@Autowired
	private BCryptPasswordEncoder bpPass;        	// 비밀번호를 암호화 (60개의 문자 랜덤으로)
	
	// 마이페이지 화면으로 이동
	@RequestMapping("/main")
	public String myPage(Model model, HttpSession session, RedirectAttributes ra) {
		if (session.getAttribute("member") == null) {
			ra.addFlashAttribute("result", 0);
			return "redirect:error";
		}
		
		Member member = (Member) session.getAttribute("member");
		
		//level 구하기
		Calendar today = Calendar.getInstance();
		
		Calendar birthday = Calendar.getInstance();
		birthday.setTime(member.getBirthday());
		
		int level = today.get(Calendar.YEAR) - birthday.get(Calendar.YEAR) + 1;
		
		//내가 쓴 글 구하기
		String m_id = member.getM_id();
		List<Board> myBoardList = bs.getMyBoard(m_id); 
		
		//내가 신청한 글 구하기
		List<Request> myRequestList = rs.getMyRequest(m_id);
		
		
		model.addAttribute("level", level);
		model.addAttribute("myBoardList", myBoardList);
		model.addAttribute("myRequestList", myRequestList);
		
		
		return "myPage/myMain";
	}
	
}
	