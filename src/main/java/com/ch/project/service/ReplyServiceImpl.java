package com.ch.project.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ch.project.dao.ReplyDao;
import com.ch.project.model.Board;
import com.ch.project.model.Reply;

@Service
public class ReplyServiceImpl implements ReplyService{
	@Autowired
	private ReplyDao rd;

	public List<Reply> rpList(Reply reply) {
		return rd.rpList(reply);
	} 
	public int getTotal(Reply reply) {
		return rd.getTotal(reply);
	}
	public int maxNo() {
		return rd.maxNo();
	}
	public int insert(Reply reply) {
		return rd.insert(reply);
	}
	public Reply select(int re_no) {
		return rd.select(re_no);
	}
	public int update(Reply reply) {
		return rd.update(reply);
	}
	public int delete(int re_no) {
		return rd.delete(re_no);
	}
	public void autoInsert(Reply reply) {
		rd.autoInsert(reply);
	}
	public int maxStep() {
		return rd.maxStep();
	}
	
	
}
