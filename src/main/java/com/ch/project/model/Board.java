package com.ch.project.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Board {
	private int b_no;				// 게시글 번호
	private String m_id;			// 작성자 아이디
	private int c_no;				// 카테고리 번호
	private String subject;			// 제목
	private Date s_date;			// 활동 시작일
	private Date e_date;			// 활동 종료일
	private String address;			// 모집 주소
	private String content;			// 활동 내용
	private int member_cnt;			// 모집 인원
	private int readcount;			// 조회수
	private Date reg_date;			// 작성일
	private String end;				// 모집 종료 여부
	private String del;				// 삭제 여부
}
