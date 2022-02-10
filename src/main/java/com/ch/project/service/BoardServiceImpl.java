package com.ch.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		//나중에 json 객체로 만들때 오류나지 않게 "앞에 \넣어주기
		String content = board.getContent().replace("\"", "\\\"");
		board.setContent(content);
		
		return bd.insertBoard(board);
	}
	public Board getBoard(int b_no) {
		return bd.getBoard(b_no);
	}
	public List<Board> searchBoard(Map<String, Object> param) {
		return bd.searchBoard(param);
	}
	public int getSearchBoardCount(Map<String, Object> param) {
		return bd.getSearchBoardCount(param);
	}
	public int updateBoard(Board board) {
		//나중에 json 객체로 만들때 오류나지 않게 "앞에 \넣어주기
		String content = board.getContent().replace("\"", "\\\"");
		board.setContent(content);
		
		return bd.updateBoard(board);
	}
	public int getMaxB_no() {
		return bd.getMaxB_no();
	}
	public int selectTotalMyBoard(String m_id) {
		return bd.selectTotalMyBoard(m_id);
	}
	public List<Board> selectMyBoard(Map<String, Object> param) {
		return bd.selectMyBoard(param);
	}
	public int updateBoardEndY(int b_no) {
		Board board = bd.getBoard(b_no);
		
		board.setEnd("y");
		
		return bd.updateBoard(board);
	}
	public int updateBoardEndN(int b_no) {
		Board board = bd.getBoard(b_no);
		
		board.setEnd("n");
		
		return bd.updateBoard(board);
	}
	public Map<String, Object> searchBoard2(Map<String, Object> param) {
		//param : s_date, e_date, address, c_no, keyword
		
		//게시글 검색
		// 페이지당 열 개수
		final int ROW_PER_PAGE = 15;
	
		// 페이지 버튼 블럭당 페이지 개수
		final int PAGE_PER_BLOCK = 5;
		
		int totalBoard  = bd.getSearchBoardCount(param);
		
		//마지막 페이지
		int endPage = (totalBoard - 1) / ROW_PER_PAGE + 1;
		
		// 현재 페이지 
		int pageNum = 1;
		
		if(param.containsKey("pageNum")) {
			String str = param.get("pageNum").toString();			
			
			//pageNum이 숫자면
			if(str.matches("^[0-9]+$")) {
				pageNum = Integer.parseInt(str);
			}
		}
		
		// 페이지 값이 1보다 작으면 페이지 값은 1
		// 페이지 값이 마지막 페이지보다 크면 페이지 값은 마지막 페이지
		pageNum = pageNum < 1 ? 1 : pageNum;
		pageNum = pageNum > endPage ? endPage : pageNum;
		
		// 꺼내올 첫번째 열 = (현재 페이지 - 1) * 페이지 당 열 개수 + 1;
		// 꺼내올 마지막 열 = 현재 페이지 * 페이지당 열 개수
		int startRow = (pageNum - 1) * ROW_PER_PAGE + 1;
		int endRow = pageNum * ROW_PER_PAGE;
		
		// pageButton에 넣을 변수 만들기
		int firstPage = PAGE_PER_BLOCK * ((pageNum - 1) / PAGE_PER_BLOCK) + 1;
		int lastPage = PAGE_PER_BLOCK * ((pageNum - 1) / PAGE_PER_BLOCK + 1);
		
		firstPage = firstPage < 1 ? 1 : firstPage;
		lastPage = lastPage > endPage ? endPage : lastPage;
		
		//매개변수에 topN 변수 넣고 전달
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		
		List<Board> boardList = bd.searchBoard(param);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("itemList", boardList);
		resultMap.put("firstPage", firstPage);
		resultMap.put("lastPage", lastPage);
		resultMap.put("pageNum", pageNum);
		resultMap.put("endPage", endPage);

		return resultMap;
	}
}
