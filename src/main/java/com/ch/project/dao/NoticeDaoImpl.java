package com.ch.project.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.project.model.Notice;

@Repository
public class NoticeDaoImpl implements NoticeDao {
	@Autowired
	private SqlSessionTemplate sst;
	
	//총 공지개수
	public int selectTotalNotice() {
		return sst.selectOne("noticens.selectTotalNotice");
	}
	//공지 리스트
	public List<Notice> selectNotice(Map<String, Object> param) {
		return sst.selectList("noticens.selectNotice", param);
	}
}
