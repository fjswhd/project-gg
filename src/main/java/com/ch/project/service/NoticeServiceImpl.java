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
	public List<Notice> selectNoticeList(Map<String, Object> param) {
		return nd.selectNoticeList(param);
	}
	//공지 번호 구하기
	public int selectNoticeNum() {
		return nd.selectNoticeNum();
	}
	//공지사항 입력
	public int insertNotice(Notice notice) {
		return nd.insertNotice(notice);
	}
	//공지 상세
	public Notice selectNotice(int no_no) {
		return nd.selectNotice(no_no);
	}
	//공지 수정
	public int updateNotice(Notice notice) {
		return nd.updateNotice(notice);
	}
}
