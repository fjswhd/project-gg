package com.ch.project.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.project.model.Notice;

@Repository
public class NoticeDaoImpl implements NoticeDao {
	@Autowired
	private SqlSessionTemplate sst;
	
	//총 공지개수
	public int selectTotalNotice() {
		return sst.selectOne("noticens.selectTotalNotice");
	}
	//공지 리스트
	public List<Notice> selectNoticeList(Map<String, Object> param) {
		return sst.selectList("noticens.selectNoticeList", param);
	}
	//공지 번호 구하기
	public int selectNoticeNum() {
		return sst.selectOne("noticens.selectNoticeNum");
	}
	//공지사항 입력
	public int insertNotice(Notice notice) {
		return sst.insert("noticens.insertNotice", notice);
	}
	//공지 상세
	public Notice selectNotice(int no_no) {
		return sst.selectOne("noticens.selectNotice", no_no);
	}
	//공지 수정
	public int updateNotice(Notice notice) {
		return sst.update("noticens.updateNotice", notice);
	}
}
