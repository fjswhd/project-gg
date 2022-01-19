package com.ch.project.service;

import java.util.List;

import com.ch.project.model.Reply;

public interface ReplyService {

	List<Reply> getReplyList(int b_no);
	
	//신규 댓글 입력
	int insertReply(Reply reply);

}
