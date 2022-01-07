package com.ch.project.service;

import java.util.List;
import com.ch.project.model.Reply;


public interface ReplyService {

	List<Reply> rpList(int b_no);			// 댓글 불러오기
	int insert(int b_no);					// 댓글 게시
	

}
