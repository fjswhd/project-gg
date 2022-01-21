package com.ch.project.dao;

import java.util.List;
import java.util.Map;

import com.ch.project.model.Notice;

public interface NoticeDao {
	
	//총 공지 개수
	int selectTotalNotice();
	//공지 리스트
	List<Notice> selectNotice(Map<String, Object> param);

}
