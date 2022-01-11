package com.ch.project.service;

import java.util.List;

import com.ch.project.model.Board;
import com.ch.project.model.Category;

public interface BoardService {

	List<Category> getCategories();

	int getBoardCount();

	int insertBoard(Board board);

	Board getBoard(int b_no);

}
