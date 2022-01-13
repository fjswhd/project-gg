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
	@Override
	public List<Reply> getReplyList(int b_no) {
		return rd.getReplyList(b_no);
	}
}
