package com.ch.project.dao;

import java.util.List;

import com.ch.project.model.Reply;


public interface ReplyDao {

	List<Reply> rpList(int b_no);
	int maxNo();
	int insert(Reply reply);
	Reply select(int re_no);
	int update(Reply reply);
	int delete(int re_no);
	

}
