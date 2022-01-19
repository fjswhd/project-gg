package com.ch.project.service;

import java.util.List;
import java.util.Map;

import com.ch.project.model.Board;
import com.ch.project.model.Category;

public interface BoardService {

	List<Category> getCategories();

	int getBoardCount();

	int insertBoard(Board board);

	Board getBoard(int b_no);

	List<Board> searchBoard(Map<String, Object> param);

	int getSearchBoardCount(Map<String, Object> param);

	List<Board> getMyBoard(String m_id);

	int updateBoard(Board board);

}