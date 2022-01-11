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
		int result = 0; // 댓글 게시 실패
		int re_no = rs.maxNo();		 							// 새 댓글 번호 구하기
		reply.setRe_no(re_no); 
		if(reply.getSecret() !=null) reply.setSecret("y") ;		// 비밀댓글 눌렀을 때 secret 칼럼이 'y'으로 설정
		else reply.setSecret("n");								// 안눌렀을 때는 null -> secret칼럼이 'n'으로 설정
		System.out.println("reply.setSecret : " +reply.getSecret());
		result = rs.insert(reply);
		model.addAttribute("reply", reply);
		model.addAttribute("result",result);
		return "reply/replyInsert";
	}
	@RequestMapping ("replyUpdate")
	public String replyUpdate (Reply reply, String pageNum, Model model) {
		int result=0; // 댓글 수정 실패
		result = rs.update(reply);
		model.addAttribute("result",result);
		return "reply/replyInsert";
	}

}
