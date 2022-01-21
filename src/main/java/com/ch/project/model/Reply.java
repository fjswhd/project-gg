package com.ch.project.model;

import java.sql.Date;

import lombok.Data;

//re
@Data
public class Reply {
	private int 	re_no;
	private Integer b_no;
	private String 	m_id;
	private String 	content;
	private int 	re_ref;
	private int 	re_step;
	private Date 	reg_date;
	private String 	secret;
	private String 	del;
	
	private String	re_master;
	
	private Board 	board;
	private Member 	member;
}
