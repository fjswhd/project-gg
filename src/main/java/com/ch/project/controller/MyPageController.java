package com.ch.project.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import com.ch.project.model.Notice;
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
	private RatingService ras;
	@Autowired
	private BCryptPasswordEncoder bpPass;        	// 비밀번호를 암호화 (60개의 문자 랜덤으로)
	
	// 마이페이지 화면으로 이동
	@RequestMapping("/main")
	public String myPage(Model model, HttpSession session, RedirectAttributes ra) {
		if (session.getAttribute("member") == null) {
			ra.addFlashAttribute("result", -1);
			return "redirect:/error.do";
		}
		
		Member member = (Member) session.getAttribute("member");
		
		//level 구하기
		Calendar today = Calendar.getInstance();
		
		Calendar birthday = Calendar.getInstance();
		birthday.setTime(member.getBirthday());
		
		int level = today.get(Calendar.YEAR) - birthday.get(Calendar.YEAR) + 1;
		
		//내가 쓴 글 구하기
		String m_id = member.getM_id();
		
		//내 정보 구하기
		Member selectedMember = ms.selectMember(m_id);
		
		//매개변수에 topN을 위한 row 변수 넣고 전달
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("m_id", m_id);
		param.put("startRow", 1);
		param.put("endRow", 10);
		
		List<Board> myBoardList = bs.selectMyBoard(param); 
		
		//종료일 1주일 후 구하기 
		for(Board board : myBoardList) {
			Calendar e_date = Calendar.getInstance(); 
			e_date.setTime(board.getE_date());
			
			e_date.add(Calendar.DATE, 7);
		
			board.setE_date_after(new Date(e_date.getTimeInMillis()));
		}
		
		//내가 신청한 글 구하기
		List<Request> myRequestList = rs.selectMyRequest(param);
		
		//내가 참여한 활동 리스트 구하기
		List<Parti> myPartiList = ps.selectMyParti(param);
		
		for(Parti parti : myPartiList) {
			Calendar e_date = Calendar.getInstance(); 
			e_date.setTime(parti.getBoard().getE_date());
			
			e_date.add(Calendar.DATE, 7);
		
			parti.getBoard().setE_date_after(new Date(e_date.getTimeInMillis()));
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String todayStr = sdf.format(today.getTime());
		
		model.addAttribute("member", selectedMember);
		model.addAttribute("level", level);
		model.addAttribute("myBoardList", myBoardList);
		model.addAttribute("myRequestList", myRequestList);
		model.addAttribute("myPartiList", myPartiList);
		model.addAttribute("today", todayStr);
		
		return "myPage/myMain";
	}
	
	//비밀번호 확인 모달
	@RequestMapping("/pwChkForm")
	public String pwChkForm(String next, Model model) {
		model.addAttribute("next", next);
		return "myPage/fragment/pwChkForm";
	}
	//비밀번호 확인
	@RequestMapping(value = "/pwChk", produces = "html/text;charset=utf-8")
	@ResponseBody
	public String pwChk(String password, HttpSession session, HttpServletRequest request) {
		String result = "0";
		
		if (request.getHeader("referer") == null || session.getAttribute("member") == null) {
			result = "-1";
			return result;
		} 
		
		//세션에 저장 되어있던 유저 아이디 이용해서 비밀번호 비교..?
		Member member = (Member) session.getAttribute("member");
		
		if (bpPass.matches(password, member.getPassword())) {
			result = "1";
		} else {
			result = "0";
		}
		
		return result;
	}
	
	//비밀번호 변경 폼
	@RequestMapping("/pwUpdateForm")
	public String pwUpdateForm(HttpSession session, HttpServletRequest request) {
		if (request.getHeader("referer") == null || session.getAttribute("member") == null) {
			return "redirect:/error.do";
		} 
		return "myPage/fragment/pwUpdateForm";
	}
	
	
	@RequestMapping("/pwUpdate")
	public String pwUpdate(String password, Model model, HttpSession session, HttpServletRequest request) {
		if (request.getHeader("referer") == null || session.getAttribute("member") == null || password == null) {
			return "redirect:/error.do";
		} 
		
		Member member = (Member) session.getAttribute("member");
		member.setPassword(bpPass.encode(password));
		
		int result = 0;
		result = ms.updateMember(member);
		
		session.invalidate();
		
		model.addAttribute("result", result);
		
		return "myPage/fragment/pwUpdate";
	}
	
	//비밀번호 변경 폼
	@RequestMapping("/profileUpdateForm")
	public String profileUpdateForm(Model model, HttpSession session, HttpServletRequest request) {
		if (request.getHeader("referer") == null || session.getAttribute("member") == null) {
			return "redirect:/error.do";
		} 
		
		String m_id = ((Member) session.getAttribute("member")).getM_id();
		
		Member member = ms.selectMember(m_id);
		
		model.addAttribute("member", member);
		
		return "myPage/fragment/profileUpdateForm";
	}
		
	
	//상호평가모달
	@RequestMapping("/evalForm")
	public String evalForm(Integer b_no, Model model, HttpSession session, HttpServletRequest request) {
		if (request.getHeader("referer") == null || session.getAttribute("member") == null || b_no == null) {
			return "redirect:/error.do";
		} 
		
		//활동 작성자 + 참여자 리스트
		Board board = bs.getBoard(b_no);
		List<Parti> partiList = ps.ptList(b_no);
		
		model.addAttribute("board", board);
		model.addAttribute("partiList", partiList);
		
		return "myPage/fragment/evalForm";
	}
	
	@RequestMapping(value = "/eval", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String evalForm(@RequestBody List<Rating> ratings, Model model, HttpSession session, HttpServletRequest request) {
		if (request.getHeader("referer") == null || session.getAttribute("member") == null || ratings == null || ratings.size() == 0) {
			return "redirect:/error.do";
		} 
		
		//1. 해당 rating 내역이 있는지 확인
		//있는지 검사할 때는 해당 글에 나의 평가 내역이 있는지 확인
		int b_no = ratings.get(0).getB_no();
		String m_id = ((Member) session.getAttribute("member")).getM_id();
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("b_no", b_no);
		param.put("m_id", m_id);
		
		List<Rating> ratingList = ras.selectMyRatings(param);
		
		int result = 0;
		
		//2. 없으면 insert, 있으면 update
		if (ratingList.size() == 0) {
			//rating no 가져오기
			int r_no = ras.selectMaxR_no();
			
			for (Rating rating : ratings) {
				r_no++;
				rating.setR_no(r_no);
				result += ras.insertRating(rating);
				
				//특정인의 평균 점수 구하기
				float avg = ras.selectAvgScore(rating.getM_id());
				
				//특정인의 평균 점수 업데이트
				Member member = new Member();
				member.setM_id(rating.getM_id());
				member.setRating(avg);
				int updateResult = ms.updateRating(member);
				
				//result++;
			}
			
		} else {
			
			for (int i = 0; i < ratings.size(); i++) {
				Rating rating = ratings.get(i);
				int r_no = ratingList.get(i).getR_no();
				
				rating.setR_no(r_no);
				
				result += ras.updateRating(rating);
				//result++;
				
				//특정인의 평균 점수 구하기
				float avg = ras.selectAvgScore(rating.getM_id());
				
				//특정인의 평균 점수 업데이트
				Member member = new Member();
				member.setM_id(rating.getM_id());
				member.setRating(avg);
				int updateResult = ms.updateRating(member);
			}
		}
		
		//3. result로 결과를 받아서 
		return result+"";
	}
	
	
	
	@RequestMapping("/myBoard")
	public String myBoard(Integer page, Model model, HttpSession session, HttpServletRequest request) {
		if (request.getHeader("referer") == null || session.getAttribute("member") == null) {
			return "redirect:/error.do";
		} 
		
		String m_id = ((Member)session.getAttribute("member")).getM_id();
		
		//게시글 검색
		// 페이지당 열 개수
		final int ROW_PER_PAGE = 10;
	
		// 페이지 버튼 블럭당 페이지 개수
		final int PAGE_PER_BLOCK = 5;
		
		int totalMyBoard  = bs.selectTotalMyBoard(m_id);
		
		//마지막 페이지
		int endPage = (totalMyBoard - 1) / ROW_PER_PAGE + 1;
		
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
		param.put("m_id", m_id);
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		
		List<Board> myBoardList = bs.selectMyBoard(param);
		
		//종료일 1주일 후 구하기 
		for(Board board : myBoardList) {
			Calendar e_date = Calendar.getInstance(); 
			e_date.setTime(board.getE_date());
			
			e_date.add(Calendar.DATE, 7);
		
			board.setE_date_after(new Date(e_date.getTimeInMillis()));
		}
		
		//level 구하기
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String todayStr = sdf.format(today.getTime());
		
		model.addAttribute("myBoardList", myBoardList);
		model.addAttribute("firstPage", firstPage);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("page", page);
		model.addAttribute("today", todayStr);
		
		return "myPage/myBoard";
	}
	
	@RequestMapping("/myRequest")
	public String myRequest(Integer page, Model model, HttpSession session, HttpServletRequest request) {
		if (request.getHeader("referer") == null || session.getAttribute("member") == null) {
			return "redirect:/error.do";
		} 
		
		String m_id = ((Member)session.getAttribute("member")).getM_id();
		
		//게시글 검색
		// 페이지당 열 개수
		final int ROW_PER_PAGE = 10;
	
		// 페이지 버튼 블럭당 페이지 개수
		final int PAGE_PER_BLOCK = 5;
		
		int totalMyRequest  = rs.selectTotalMyRequest(m_id);
		
		//마지막 페이지
		int endPage = (totalMyRequest - 1) / ROW_PER_PAGE + 1;
		
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
		param.put("m_id", m_id);
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		
		List<Request> myRequestList = rs.selectMyRequest(param);
		
		model.addAttribute("myRequestList", myRequestList);
		model.addAttribute("firstPage", firstPage);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("page", page);
		
		return "myPage/myRequest";
	}
	
	
	@RequestMapping("/myParti")
	public String myParti(Integer page, Model model, HttpSession session, HttpServletRequest request) {
		if (request.getHeader("referer") == null || session.getAttribute("member") == null) {
			return "redirect:/error.do";
		} 
		
		String m_id = ((Member)session.getAttribute("member")).getM_id();
		
		//게시글 검색
		// 페이지당 열 개수
		final int ROW_PER_PAGE = 10;
	
		// 페이지 버튼 블럭당 페이지 개수
		final int PAGE_PER_BLOCK = 5;
		
		int totalMyParti  = ps.selectTotalMyParti(m_id);
		
		//마지막 페이지
		int endPage = (totalMyParti - 1) / ROW_PER_PAGE + 1;
		
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
		param.put("m_id", m_id);
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		
		List<Parti> myPartiList = ps.selectMyParti(param);
		
		for(Parti parti : myPartiList) {
			Calendar e_date = Calendar.getInstance(); 
			e_date.setTime(parti.getBoard().getE_date());
			
			e_date.add(Calendar.DATE, 7);
		
			parti.getBoard().setE_date_after(new Date(e_date.getTimeInMillis()));
		}
		
		//level 구하기
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String todayStr = sdf.format(today.getTime());
		
		model.addAttribute("myPartiList", myPartiList);
		model.addAttribute("firstPage", firstPage);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("page", page);
		model.addAttribute("today", todayStr);
		
		return "myPage/myParti";
	}
}
	