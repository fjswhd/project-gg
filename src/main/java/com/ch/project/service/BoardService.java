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

	int updateBoard(Board board);

	int getMaxB_no();

	int selectTotalMyBoard(String m_id);

	List<Board> selectMyBoard(Map<String, Object> param);


}
