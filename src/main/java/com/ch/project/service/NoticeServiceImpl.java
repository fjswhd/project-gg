package com.ch.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.project.dao.NoticeDao;
import com.ch.project.model.Notice;

@Service
public class NoticeServiceImpl implements NoticeService{
	@Autowired
	private NoticeDao nd;
	
	//총 공지 개수
	public int selectTotalNotice() {
		return nd.selectTotalNotice();
	}
	//공지 리스트
	public List<Notice> selectNotice(Map<String, Object> param) {
		return nd.selectNotice(param);
	}
}
