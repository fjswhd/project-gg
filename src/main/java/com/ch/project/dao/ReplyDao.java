package com.ch.project.dao;

import java.util.List;

import com.ch.project.model.Reply;

public interface ReplyDao {

	List<Reply> getReplyList(int b_no);
	
	//신규 댓글 입력
	int insertReply(Reply reply);
	
	//다음 댓글 번호 구하기
	int selectReplyCount();
	
	//re_step구하기
	int selectReStep(int re_ref);
	
	//댓글 원주인 구하기
	String selectReplyMaster(int re_ref);
	
	//댓글 삭제
	int delete(int re_no);

}
