package com.ch.project.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ch.project.model.Reply;
import com.ch.project.service.PagingBean;
import com.ch.project.service.ReplyService;


@Controller
public class ReplyController {
	@Autowired
	private ReplyService rs;

	@RequestMapping("replyList")
	public String replyList(Reply reply, String pageNum, Model model) {
		//String seM_id = (String) session.getAttribute("m_id");
		// reply.setSeM_id(seM_id);
		// reply.setBoM_id(board.getM_id());
		//System.out.println(" reply : " + reply);
		
		// 페이징
			if (pageNum == null || pageNum.equals("")) {
				pageNum = "1";
			}
			int currentPage = Integer.parseInt(pageNum);
			int rowPerPage = 10; // 한 화면에 보이는 게시글 수
			int total = rs.getTotal(reply);
			int startRow = (currentPage - 1) * rowPerPage + 1;
			int endRow = startRow + rowPerPage - 1;
			reply.setStartRow(startRow);
			reply.setEndRow(endRow);
			// 댓글리스트
			List<Reply> rpList = rs.rpList(reply);
		PagingBean pb = new PagingBean(currentPage, rowPerPage, total);
		
		model.addAttribute("pb", pb);
		model.addAttribute("reply", reply);
		model.addAttribute("rpList", rpList);
		return "reply/replyList";
	}
	@RequestMapping ("replyInsertForm")
	@ResponseBody
	public String replyInsertForm () {
		return "reply/replyInsertForm";
	}

	@RequestMapping("replyInsert")
	public String replyInsert(Reply reply, String pageNum, Model model) {
		int result = 0; // 댓글 게시 실패
		int re_no = rs.maxNo(); // 새 댓글 번호 구하기
		reply.setRe_no(re_no);
		if (reply.getSecret() == null || reply.getSecret().equals("null"))
			reply.setSecret("n"); // 체크하지 않으면 secret 칼럼이 'n'으로 설정
		else
			reply.setSecret("y"); // 비밀댓글 눌렀을 때 secret 칼럼이 'y'으로 설정
		result = rs.insert(reply);
		model.addAttribute("reply", reply);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "reply/replyInsert";
	}
	@RequestMapping("autoInsert")
	@ResponseBody
	public void autoInsert(HttpServletRequest request) {
	String ip = request.getRemoteAddr();
	for (int i =100; i < 150; i++) {
		Reply reply = new Reply();
		reply.setRe_no(20+i);
		reply.setContent("댓글"+i);
		rs.autoInsert(reply);
	}
}
	@RequestMapping("replyUpdateForm")
	@ResponseBody
	public String replyUpdateForm(int re_no, String pageNum, Model model) {
		Reply reply = rs.select(re_no);
		model.addAttribute("reply", reply);
		model.addAttribute("pageNum", pageNum);
		return "reply/replyUpdateForm";
	}

	@RequestMapping ("replyUpdate")
	public String replyUpdate (Reply reply, String pageNum, Model model) {
		int result=0; // 댓글 수정 실패			
		/*
		 * if (reply.getSecret() == null || reply.getSecret().equals("null"))
		 * reply.setSecret("n"); // 체크하지 않으면 secret 칼럼이 'n'으로 설정 else
		 * reply.setSecret("y"); // 비밀댓글 눌렀을 때 secret 칼럼이 'y'으로 설정
		 */		
		result = rs.update(reply);
		model.addAttribute("reply",reply);
		model.addAttribute("result",result);
		model.addAttribute("pageNum", pageNum);
		return "reply/replyUpdate";
	}

	@RequestMapping("replyDelete")
	public String replyDelete(int re_no, String pageNum, Model model) {
		int result = 0;
		result = rs.delete(re_no);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "reply/replyDelete";
	}

}
