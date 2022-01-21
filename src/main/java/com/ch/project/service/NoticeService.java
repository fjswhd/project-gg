package com.ch.project.service;

import java.util.List;
import java.util.Map;

import com.ch.project.model.Notice;

public interface NoticeService {
	//총 공지 개수
	int selectTotalNotice();
	
	//공지리스트
	List<Notice> selectNotice(Map<String, Object> param);

}
