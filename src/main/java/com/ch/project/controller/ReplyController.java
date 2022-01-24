package com.ch.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ch.project.model.Reply;
import com.ch.project.service.ReplyService;

@Controller
@RequestMapping("/reply")
public class ReplyController {
	@Autowired
	private ReplyService rs;
	
	@RequestMapping("/list")
	public String reply(Integer b_no, Model model) {
		List<Reply> replyList = rs.getReplyList(b_no);
		
		for(Reply reply : replyList) {
			int re_ref = reply.getRe_ref();
			
			String m_id = rs.selectReplyMaster(re_ref);
			
			reply.setRe_master(m_id);
		}
		
		model.addAttribute("replyList", replyList);
		model.addAttribute("b_no", b_no);
		
		return "board/fragment/reply";
	}
	
	@RequestMapping("/insert")
	public String reply(Reply reply, Model model) {
		//댓글 번호 구하기
		int re_no = rs.selectReplyCount();
		reply.setRe_no(re_no);
		
		if (reply.getRe_ref() == 0) {
			reply.setRe_ref(re_no);
		} else {
			//대댓글인 경우 re_step구하기 
			int re_step = rs.selectReStep(reply.getRe_ref());
			reply.setRe_step(re_step);
		}
		
		//비밀댓글 여부 설정
		if (reply.getSecret() == null) {
			reply.setSecret("n");
		} else {
			reply.setSecret("y");
		}
		
		rs.insertReply(reply);
		
		return "redirect:/board/detail.do?b_no="+reply.getB_no();
	}
	
	@RequestMapping("/delete")
	public String delete(Reply reply, Model model) {
		//댓글 번호 구하기
		int re_no = reply.getRe_no();
		
		int result = 0;
		result = rs.delete(re_no);
		
		return "redirect:/board/detail.do?b_no="+reply.getB_no();
	}
}
