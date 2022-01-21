package com.ch.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.project.dao.ReplyDao;
import com.ch.project.model.Reply;

@Service
public class ReplyServiceImpl implements ReplyService {
	@Autowired
	private ReplyDao rd;
	
	public List<Reply> getReplyList(int b_no) {
		return rd.getReplyList(b_no);
	}
	
	//신규 댓글 입력
	public int insertReply(Reply reply) {
		return rd.insertReply(reply);
	}
	//다음 댓글 번호 구하기
	public int selectReplyCount() {
		return rd.selectReplyCount();
	}
	//re_step구하기
	public int selectReStep(int re_ref) {
		return rd.selectReStep(re_ref);
	}
	//댓글 원주인 구하기
	public String selectReplyMaster(int re_ref) {
		return rd.selectReplyMaster(re_ref);
	}
	//댓글 삭제
	public int delete(int re_no) {
		return rd.delete(re_no);
	}
}
