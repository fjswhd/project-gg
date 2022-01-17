package com.ch.project.model;

import java.sql.Date;

import lombok.Data;

@Data
public class SearchOption {
	private int c_no;
	private Date s_date;
	private Date e_date;
	private String address;
	private String keyword;
}
