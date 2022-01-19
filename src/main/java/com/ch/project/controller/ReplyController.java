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

		model.addAttribute("replyList", replyList);
		model.addAttribute("b_no", b_no);
		
		return "board/fragment/reply";
	}
	
	@RequestMapping("/insert")
	public String reply(Reply reply, Model model) {
		System.out.println(reply);
		//비밀댓글 여부 설정
		if (reply.getSecret() == null) {
			reply.setSecret("n");
		} else {
			reply.setSecret("y");
		}
		
		//rs.insertReply(reply);
		
		return "redirect:/board/detail.do?b_no="+reply.getB_no();
	}
}
