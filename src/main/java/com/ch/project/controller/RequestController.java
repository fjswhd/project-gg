package com.ch.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ch.project.model.Board;
import com.ch.project.model.Member;
import com.ch.project.model.Parti;
import com.ch.project.model.Request;
import com.ch.project.service.BoardService;
import com.ch.project.service.MemberService;
import com.ch.project.service.PartiService;
import com.ch.project.service.RequestService;

@Controller
@RequestMapping("/request")
public class RequestController {
	@Autowired
	private RequestService rs;
	@Autowired
	private BoardService bs;
	@Autowired
	private MemberService ms;
	@Autowired
	private PartiService ps;

	@RequestMapping("/list")
	public String requestList (int b_no, Model model) {
		List<Request> requestList = rs.rqList(b_no);
		Board board = bs.getBoard(b_no);
		
		model.addAttribute("board", board);
		model.addAttribute("requestList", requestList);
		
		return "board/fragment/request";
	}
	@RequestMapping ("requestInsert") 
	// int b_no은 board의 b_no  / String m_id는 세션 아이디
	public String requestInsert (int b_no, String m_id, Model model) {
		int result = 0; // 신청실패
		
		//현재 모집 종료된 게시글인 경우
		Board board = bs.getBoard(b_no);
		
		if(board.getEnd().equals("y")) {
			result = -2;
			model.addAttribute("result", result);
			return "request/request";
		}
		
		
		
		Map<String, Object> request = new HashMap<String, Object>();
		request.put("b_no",b_no);
		request.put("m_id",m_id);
		
		Request rq = rs.selectRequest(request);
		
		if (rq == null) {	//첫 신청자인 경우
			result = rs.insert(request);
		} else if (rq.getAccept().equals("n") || rq.getCancel().equals("y")) {	//신청 거절자, 신청 취소자인 경우	
			result = rs.update(request);
		} else {
			result = -1;			
		}
		
		model.addAttribute("result", result);
		model.addAttribute("b_no", b_no);
		
		return "request/request";
//		return "redirect:/board/detail.do?b_no="+b_no;
	}
	@RequestMapping ("/requestAccept")
	public String requestAccept (int b_no,String m_id, Model model) {
		int result = 0; // 수락실패
		
		//수락하기 전에 현재 인원이 다 찬건지 확인해야함
		//최대 인원 구하기
		Board board = bs.getBoard(b_no);
		int max = board.getM_count();
		
		//현재 인원 구하기
		List<Parti> partiList = ps.ptList(b_no);
		int current = partiList.size() + 1;
		
		//현재 인원이 최대인원보다 작으면 참여자로 전환
		if(current < max) {
			Map<String, Object> accept = new HashMap<String, Object>();
			accept.put("b_no",b_no);
			accept.put("m_id",m_id);
			
			result = rs.accept(accept);
		}
		
		//만약 참가인원이 마지막 참여자였다면 게시글을 자동으로 end로 전환
		if(max - current == 1) {
			board.setEnd("y");
			bs.updateBoard(board);
			
			//request.accept = 'y' 아닌 사람들 자동 거절
			rs.rejectAll(b_no);
		}
		
		Member member = ms.selectMember(m_id);
		
		model.addAttribute("result",result);
		model.addAttribute("b_no", b_no);
		model.addAttribute("member", member);
		
		return "request/requestAccept";
	}
	@RequestMapping ("/requestReject")
	public String requestReject (@RequestParam Map<String, Object> param, Model model) {
		int result= 0; // 수락실패
		
		result = rs.reject(param);
		
		String m_id = (String) param.get("m_id");
		Member member = ms.selectMember(m_id);
		
		model.addAttribute("result",result);
		model.addAttribute("b_no", param.get("b_no"));
		model.addAttribute("member", member);
		
		//return "redirect:/board/detail.do?b_no="+param.get("b_no");
		return "request/requestReject";
	}
	@RequestMapping("requestCancel")
	public String requestCancel (@RequestParam Map<String, Object> param, Model model) {
		int result = 0; //  신청 취소 실패
		
		result = rs.cancel(param);
		
		model.addAttribute("result", result);
		model.addAttribute("b_no", param.get("b_no"));
		
		return "request/requestCancel";
	}
}
