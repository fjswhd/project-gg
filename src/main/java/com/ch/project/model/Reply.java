package com.ch.project.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Reply {
	private int re_no;				// 댓글 번호
	private int b_no;				// 게시글 번호
	private String m_id;			// 작성자 아이디
	private String content;			// 댓글 내용
	private int re_ref;				// 댓글 참조번호
	private int re_step;			// 대댓글 순서
	private Date reg_date;			// 작성일
	private String secret;			// 비밀댓글 여부
	private String del;				// 삭제 여부
	private String nickname;		// 닉네임
	
	
	
	// paging용
    private int startRow;
    private int endRow;
}
