package com.ch.project.dao;

import java.util.List;

import com.ch.project.model.Reply;


public interface ReplyDao {

	List<Reply> rpList(int b_no);
	int insert(int b_no);

}