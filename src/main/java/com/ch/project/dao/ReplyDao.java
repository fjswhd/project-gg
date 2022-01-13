package com.ch.project.dao;

import java.util.List;

import com.ch.project.model.Board;
import com.ch.project.model.Reply;


public interface ReplyDao {

	List<Reply> rpList(Reply reply);
	int getTotal(Reply reply);
	int maxNo();
	int insert(Reply reply);
	Reply select(int re_no);
	int update(Reply reply);
	int delete(int re_no);
	

}
