package com.ch.project.dao;

import java.util.List;
import java.util.Map;

import com.ch.project.model.Board;
import com.ch.project.model.Category;

public interface BoardDao {

	List<Category> getCategories();

	int getBoardCount();

	int insertBoard(Board board);

	Board getBoard(int b_no);

	List<Board> searchBoard(Map<String, Object> param);

	int getSearchBoardCount(Map<String, Object> param);
	
}
