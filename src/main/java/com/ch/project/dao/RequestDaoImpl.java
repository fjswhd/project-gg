package com.ch.project.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.project.model.Parti;
import com.ch.project.model.Request;


@Repository
public class RequestDaoImpl implements RequestDao{
	@Autowired
	private SqlSessionTemplate sst;

	public List<Request> rqList(int b_no) {
		return sst.selectList("requestns.rqList",b_no);
	}
	public Request select(Map<String, Object> request) {
		return sst.selectOne("requestns.select", request);
	}
	public int insert(Map<String, Object> request) {
		return sst.insert("requestns.insert", request);
	}
	public int update(Map<String, Object> request) {
		return sst.update("requestns.update", request);
	}
	public int accept(Map<String, Object> accept) {
		return sst.update("requestns.accept", accept);
	}
	public int insertParti(Map<String, Object> accept) {
		return sst.insert("requestns.insertParti", accept);
	}
	public int reject(Map<String, Object> reject) {
		return sst.update("requestns.reject", reject);
	}
	public int cancel(Map<String, Object> cancel) {
		return sst.update("requestns.cancel", cancel);
	}
	public List<Request> getMyRequest(String m_id) {
		return sst.selectList("requestns.selectMyRequest", m_id);
	}
	public Request selectRequest(Map<String, Object> request) {
		return sst.selectOne("requestns.selectRequest", request);
	}
	public void rejectAll(int b_no) {
		sst.update("requestns.rejectAll", b_no);
	}
}
