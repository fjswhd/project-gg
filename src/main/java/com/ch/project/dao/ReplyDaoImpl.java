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
	public int insert(int b_no) {
		return sst.insert("replyns.insert",b_no);
	}
		
}
