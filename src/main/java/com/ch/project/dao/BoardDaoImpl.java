package com.ch.project.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.project.model.Board;
import com.ch.project.model.Category;

@Repository
public class BoardDaoImpl implements BoardDao {
	@Autowired
	private SqlSessionTemplate sst;
	
	public List<Category> getCategories() {
		return sst.selectList("boardns.selectCategories");
	}
	public int getBoardCount() {
		return sst.selectOne("boardns.selectBoardCount");
	}
	public int insertBoard(Board board) {
		return sst.insert("boardns.insertBoard", board);
	}
	public Board getBoard(int b_no) {
		return sst.selectOne("boardns.selectBoard", b_no);
	}
}
