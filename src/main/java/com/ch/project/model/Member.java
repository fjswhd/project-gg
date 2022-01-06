package com.ch.project.model;

import java.sql.Date;
import lombok.Data;

@Data
public class Member {
	private String m_id;			// 아이디(이메일)
	private String password;		// 비밀번호(암호화)
	private Date reg_date;			// 가입일
	private String nickname;		// 닉네임
	private Date birthday;			// 생년월일
	private String place;			// 출몰지 (활동지역)
	private String tag;				// 태그 (나의 관심사 등)
	private String picture;			// 프로필사진
	private int rating;				// 평균 평점
	private String admin;			// 관리자 여부
	private String del;				// 삭제 여부
}
