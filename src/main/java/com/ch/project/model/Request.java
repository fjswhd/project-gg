package com.ch.project.model;

import java.sql.Date;
import lombok.Data;

@Data
public class Request {
	private int b_no;				// 신청한 게시글 번호
	private String m_id;			// 신청자 아이디
	private Date reg_date;			// 신청 요청 시각
	private String cancel;			// 취소 여부
	private String accept;			// 수락 여부
	private String nickname;		// 닉네임
}
