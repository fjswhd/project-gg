package com.ch.project.model;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class Parti {
	private int 	b_no;			// 참여 게시글 번호
	private String 	m_id;			// 참여자 아이디
	private Date 	reg_date;		// 참여신청 수락 시각
	private String 	cancel;			// 참여 취소 여부
	private String 	ban;			// 강퇴 여부 
	private String 	nickname;		// 닉네임
	
	private Board board;
	private double rating;
}
