package com.ch.project.service;

import lombok.Data;

@Data
public class PagingBean {
	private int currentPage; 		// 현재페이지
	private int rowPerPage;			// 페이지당 게시글 갯수
	private int total;				// 전체 게시글 수
	private int totalPage;			// 전체 페이지 수
	private int pagePerBlock = 10;	// 한블럭당 들어가는 페이지 수
	private int startPage;			// 블럭 시작페이지
	private int endPage;			// 블럭 끝페이지
	
	public PagingBean(int currentPage, int rowPerPage, int total) {
		this.currentPage = currentPage;
		this.rowPerPage = rowPerPage;
		this.total = total;
		totalPage = (int)Math.ceil((double)(total) / rowPerPage);
		startPage = currentPage - (currentPage-1) % pagePerBlock;
		endPage = startPage + pagePerBlock - 1;
		if (endPage > totalPage) {
			endPage = totalPage;
		}
	}
}
