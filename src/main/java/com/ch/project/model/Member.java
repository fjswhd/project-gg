package com.ch.project.model;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Member {
	private String 	m_id;
	private String 	password;
	private Date	reg_date;
	private String	nickname;
	private Date	birthday;
	private String 	place;
	private String 	tag;
	private String	picture;
	private Float	rating;
	private String	admin;
	private String	del;
	
}
