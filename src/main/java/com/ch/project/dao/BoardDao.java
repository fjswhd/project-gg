package com.ch.project.dao;

import java.util.List;

import com.ch.project.model.Board;
import com.ch.project.model.Category;

public interface BoardDao {

	List<Category> getCategories();

	int getBoardCount();

	int insertBoard(Board board);

	Board getBoard(int b_no);

}
