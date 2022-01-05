package com.ch.project.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Board {
	private int 	b_no;
	private String	m_id;
	private int		c_no;
	private String 	subject;
	private Date	s_date;
	private Date	e_date;
	private String	address;
	private String 	content;
	private	int		m_count;
	private int		readcount;
	private Date	reg_date;
	private String	end;
	private String	del;
	
	private Category category;
}
