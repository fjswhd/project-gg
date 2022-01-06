package com.ch.project.model;

import java.sql.Date;
import lombok.Data;

@Data
public class Notification {
	private int n_no;				// 알림 번호
	private String m_id;			// 알림 받는 유저 아이디
	private String content;			// 알림 내용
	private Date reg_date;			// 알림 발생 시각
	private Date last_date;			// 마지막 확인 시각
}
