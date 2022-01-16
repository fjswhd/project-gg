package com.ch.project.service;

import java.util.List;

import com.ch.project.model.Board;
import com.ch.project.model.Reply;


public interface ReplyService {

	List<Reply> rpList(Reply reply);		// 댓글 불러오기
	int getTotal(Reply reply);				// 총 댓글 갯수
	int maxNo();							// 새 댓글 번호
	int insert(Reply reply);				// 댓글 게시
	Reply select(int re_no);				// 댓글 수정 폼
	int update(Reply reply);				// 댓글 수정
	int delete(int re_no);					// 댓글 삭제
	void autoInsert(Reply reply);			// 댓글 삽입
	
	
	
	

}
