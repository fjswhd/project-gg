package com.ch.project.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.project.model.Reply;

@Repository
public class ReplyDaoImpl implements ReplyDao {
	@Autowired
	private SqlSessionTemplate sst;
	
	public List<Reply> getReplyList(int b_no) {
		return sst.selectList("replyns.selectReplyList", b_no);
	}
	//신규 댓글 입력
	public int insertReply(Reply reply) {
		return sst.insert("replyns.insertReply", reply);
	}
	//다음 댓글 번호 구하기
	public int selectReplyCount() {
		return sst.selectOne("replyns.selectReplyCount");
	}
	
	public int selectReStep(int re_ref) {
		return sst.selectOne("replyns.selectReStep", re_ref);
	}
	
	public String selectReplyMaster(int re_ref) {
		return sst.selectOne("replyns.selectReplyMaster", re_ref);
	}
	//댓글 삭제
	public int delete(int re_no) {
		return sst.delete("replyns.delete", re_no);
	}
}
