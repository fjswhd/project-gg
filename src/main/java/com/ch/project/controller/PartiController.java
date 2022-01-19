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
import com.ch.project.service.BoardService;
import com.ch.project.service.MemberService;
import com.ch.project.service.PartiService;

@Controller
@RequestMapping("/parti")
public class PartiController {
	@Autowired
	private PartiService ps;
	@Autowired
	private BoardService bs;
	@Autowired
	private MemberService ms;
	
	@RequestMapping ("/list")
	public String partiList (int b_no, Model model) {
		List<Parti> partiList = ps.ptList(b_no);
		
		//게시글 주인인지 확인하기 위한 게시글 객체
		Board board = bs.getBoard(b_no);
		
		model.addAttribute("board", board);
		model.addAttribute("partiList", partiList);
		
		return "board/fragment/parti";
	}
	
	@RequestMapping ("/ban")
	public String partiOut (@RequestParam Map<String, Object> param, Model model) {
		int result = 0; // 강퇴실패

		result = ps.ban(param);
		
		String m_id = (String) param.get("m_id");
		Member member = ms.selectMember(m_id);
		
		model.addAttribute("result", result);
		model.addAttribute("b_no", param.get("b_no"));
		model.addAttribute("member", member);

		return "parti/partiBan";
//		return "redirect:/board/detail.do?b_no="+param.get("b_no");
	}
	
	@RequestMapping ("/cancel")
	public String partiCancel (@RequestParam Map<String, Object> param, Model model) {
		int result = 0;
		
		result = ps.ptCancel(param);
		
		model.addAttribute("result",result);
		model.addAttribute("b_no", param.get("b_no"));
		
//		return "redirect:/board/detail.do?b_no="+param.get("b_no");
		
		return "parti/partiCancel";
	}
	@RequestMapping ("/return")
	public String partiReCancel (@RequestParam Map<String, Object> param, Model model) {
		int result = 0; // 탈퇴 신청 취소 실패
		
		result = ps.ptReCancel(param);
		
		model.addAttribute("result",result);
		model.addAttribute("b_no", param.get("b_no"));
		
		return "parti/return";
	}
	@RequestMapping ("cancelAccept")
	public String partiCancelAccess (@RequestParam Map<String, Object> param, Model model) {
		int result = 0; // 탈퇴 신청 수락 실패
		
		result = ps.pcAccess(param);
		
		String m_id = (String) param.get("m_id");
		Member member = ms.selectMember(m_id);
		
		model.addAttribute("result",result);
		model.addAttribute("b_no", param.get("b_no"));
		model.addAttribute("member", member);
		
		return "parti/partiCancelAccept";
	}
	@RequestMapping ("cancelReject")
	public String partiCancelReject (@RequestParam Map<String, Object> param, Model model) {
		int result = 0; // 탈퇴 신청 수락 실패
		
		result = ps.pcReject(param);
		
		String m_id = (String) param.get("m_id");
		Member member = ms.selectMember(m_id);
		
		model.addAttribute("result",result);
		model.addAttribute("b_no", param.get("b_no"));
		model.addAttribute("member", member);

		return "parti/partiCancelReject";
	}
	
}
