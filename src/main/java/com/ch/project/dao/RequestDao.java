package com.ch.project.dao;

import java.util.List;
import java.util.Map;

import com.ch.project.model.Request;

public interface RequestDao {

	List<Request> rqList(int b_no);
	Request select(Map<String, Object> request);
	int insert(Map<String, Object> request);
	int accept(Map<String, Object> accept);
	int reject(Map<String, Object> reject);

}
