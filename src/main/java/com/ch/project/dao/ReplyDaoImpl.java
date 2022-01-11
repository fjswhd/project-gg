package com.ch.project.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.ch.project.model.Reply;


@Repository
public class ReplyDaoImpl implements ReplyDao{
	@Autowired
	private SqlSessionTemplate sst;
	
	public List<Reply> rpList(int b_no) {
		return sst.selectList("replyns.rpList",b_no);
	}
	public int maxNo() {
		return sst.selectOne("replyns.maxNo");
	}
	public int insert(Reply reply) {
		return sst.insert("replyns.insert",reply);
	}
	public int update(Reply reply) {
		return sst.update("replyns.update",reply);
	}

		
}
