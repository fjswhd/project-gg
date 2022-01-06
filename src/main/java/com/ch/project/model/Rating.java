package com.ch.project.model;

import lombok.Data;

@Data
public class Rating {
	private int r_no;				// 평점 번호
	private String m_id; 			// 아이디
	private int b_no;				// 활동한 게시글 번호
	private int r_score;			// 평점
}
