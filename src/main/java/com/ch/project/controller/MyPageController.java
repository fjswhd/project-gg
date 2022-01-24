package com.ch.project.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ch.project.model.Board;
import com.ch.project.model.Member;
import com.ch.project.model.Parti;
import com.ch.project.model.Rating;
import com.ch.project.model.Request;
import com.ch.project.service.BoardService;
import com.ch.project.service.MemberService;
import com.ch.project.service.PartiService;
import com.ch.project.service.RatingService;
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
	private PartiService ps;
	@Autowired
	private RatingService rts;
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
		
		//내가 참여한 활동 리스트 구하기
		List<Parti> myPartiList = ps.getMyParti(m_id);
		
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String todayStr = sdf.format(today.getTime());
		
		model.addAttribute("level", level);
		model.addAttribute("myBoardList", myBoardList);
		model.addAttribute("myRequestList", myRequestList);
		model.addAttribute("myPartiList", myPartiList);
		model.addAttribute("today", todayStr);
		
		return "myPage/myMain";
	}
	@RequestMapping ("/partiList")
	public String partiList (int b_no, Model model) {
		//작성자 id 구하기
		Board board = bs.getBoard(b_no);
		// 내가 쓴 글의 참여자 목록
		List<Parti> partiList = ps.ptList(b_no);
		model.addAttribute("partiList", partiList);
		
		return "myPage/partiList";
	}
	@RequestMapping (value="/insertRscore", produces="application/json;charset=utf-8")
	@ResponseBody
	public String insertRscore(@RequestBody List<Rating> partiList  ) {
		int result= 0;
		
		for(Rating rating : partiList) {
			
			  int r_no = rts.selectRatingCount(); rating.setR_no(r_no);
			  rts.insertRscore(rating);
			 
		  result += 1;
		}  
		  
		  return result+"";  
	}
}
	