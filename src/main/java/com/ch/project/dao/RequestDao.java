package com.ch.project.dao;

import java.util.List;
import java.util.Map;

import com.ch.project.model.Parti;
import com.ch.project.model.Request;

public interface RequestDao {

	List<Request> rqList(int b_no);
	
	Request select(Map<String, Object> request);
	
	int insert(Map<String, Object> request);
	
	int update(Map<String, Object> request);
	
	int accept(Map<String, Object> accept);
	
	int insertParti(Map<String, Object> accept);
	
	int reject(Map<String, Object> reject);
	
	int cancel(Map<String, Object> cancel);

	Request selectRequest(Map<String, Object> request);
	
	void rejectAll(int b_no);

	List<Request> selectMyRequest(Map<String, Object> param);

	int selectTotalMyRequest(String m_id);
	
}
