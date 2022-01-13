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
		
		return "board/fragment/reply";
	}
	
	@RequestMapping("/insert")
	public String reply(String content, String secret, Model model) {
		System.out.println(content);
		System.out.println(secret);
		
		return "board/fragment/reply";
	}
}
