package com.ch.project.model;

import java.sql.Date;
import lombok.Data;

@Data
public class Notice {
	private String 	no_no; 			// 공지 번호
	private String 	m_id; 			// 관리자 아이디
	private String 	subject; 		// 공지 제목
	private String 	content; 		// 공지 내용
	private int 	readcount; 			// 조회수 
	private Date 	reg_date; 			// 작성일(시각)
	private String	del; 			// 삭제 여부
}
