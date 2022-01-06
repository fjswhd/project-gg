package com.ch.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ch.project.dao.RequestDao;
import com.ch.project.model.Parti;
import com.ch.project.model.Request;

@Service
public class RequestServiceImpl implements RequestService{
	@Autowired
	private RequestDao rd;

	public List<Request> rqList(int b_no) {
		return rd.rqList(b_no);
	}
	public Request select(Map<String, Object> request) {
		return rd.select(request);
	}
	public int insert(Map<String, Object> request) {
		return rd.insert(request);
	}
	public int accept(Map<String, Object> accept) {
		return rd.accept(accept);
	}
	public void insertParti(Map<String, Object> accept) {
		rd.insertParti(accept);
	}
	public int reject(Map<String, Object> reject) {
		return rd.reject(reject);
	}
	public int cancel(Map<String, Object> cancel) {
		return rd.cancel(cancel);
	}
}
