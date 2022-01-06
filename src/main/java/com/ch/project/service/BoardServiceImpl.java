package com.ch.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.project.dao.BoardDao;
import com.ch.project.model.Board;
import com.ch.project.model.Category;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDao bd;
	
	public List<Category> getCategories() {
		return bd.getCategories();
	}
	public int getBoardCount() {
		return bd.getBoardCount();
	}
	public int insertBoard(Board board) {
		return bd.insertBoard(board);
	}
	public Board getBoard(int b_no) {
		return bd.getBoard(b_no);
	}
}
