package com.ch.project.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.project.model.Board;
import com.ch.project.model.Reply;


@Repository
public class ReplyDaoImpl implements ReplyDao{
	@Autowired
	private SqlSessionTemplate sst;
	
	public List<Reply> rpList(Reply reply) {
		return sst.selectList("replyns.rpList",reply);
	}
	public int getTotal(Reply reply) {
		return sst.selectOne("replyns.getTotal",reply);
	}
	public int maxNo() {
		return sst.selectOne("replyns.maxNo");
	}
	public int insert(Reply reply) {
		return sst.insert("replyns.insert",reply);
	}
	public Reply select(int re_no) {
		return sst.selectOne("replyns.select",re_no);
	}
	public int update(Reply reply) {
		return sst.update("replyns.update",reply);
	}
	public int delete(int re_no) {
		return sst.update("replyns.delete",re_no);
	}
	public void autoInsert(Reply reply) {
		sst.insert("replyns.autoInsert",reply);
	}
		
}
