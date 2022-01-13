package com.ch.project.dao;

import java.util.List;

import com.ch.project.model.Reply;

public interface ReplyDao {

	List<Reply> getReplyList(int b_no);

}
