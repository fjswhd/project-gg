package com.ch.project.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ch.project.dao.ReplyDao;
import com.ch.project.model.Reply;

@Service
public class ReplyServiceImpl implements ReplyService{
	@Autowired
	private ReplyDao rd;

	public List<Reply> rpList(int b_no) {
		return rd.rpList(b_no);
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
	
	
}
