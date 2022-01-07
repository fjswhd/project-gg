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
	public int insert(int b_no) {
		return rd.insert(b_no);
	}

}
