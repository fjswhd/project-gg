package com.ch.project.service;

import java.util.List;
import java.util.Map;

import com.ch.project.model.Notice;

public interface NoticeService {
	//총 공지 개수
	int selectTotalNotice();
	
	//공지리스트
	List<Notice> selectNoticeList(Map<String, Object> param);
	
	//공지 번호 구하기
	int selectNoticeNum();
	
	//공지사항 입력
	int insertNotice(Notice notice);
	
	//공지 상세
	Notice selectNotice(int no_no);
	
	//공지 수정
	int updateNotice(Notice notice);
	
}
