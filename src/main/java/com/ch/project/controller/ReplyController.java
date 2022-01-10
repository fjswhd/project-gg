package com.ch.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.ch.project.model.Reply;
import com.ch.project.service.ReplyService;


@Controller
public class ReplyController {
	@Autowired
	private ReplyService rs;
	@RequestMapping("replyList")
	public String replyList (int b_no, Model model) {
		List<Reply> rpList = rs.rpList(b_no);
		model.addAttribute("b_no",b_no);
		model.addAttribute("rpList",rpList);
		return "reply/replyList";
	}
	@RequestMapping("replyInsert")
	public String replyInsert (Reply reply, String pageNum, Model model) {
		int result = 0; //댓글 게시 실패
		int re_no = rs.maxNo();
		reply.setRe_no(re_no);
		result = rs.insert(reply);
		model.addAttribute("reply", reply);
		model.addAttribute("result",result);
		return "reply/replyInsert";
	}

}
