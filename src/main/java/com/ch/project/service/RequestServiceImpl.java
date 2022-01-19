package com.ch.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.project.dao.PartiDao;
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
	public int update(Map<String, Object> request) {
		return rd.update(request);
	}
	public int accept(Map<String, Object> accept) {
		int result = 0;
		
		result += rd.accept(accept);
		result += rd.insertParti(accept);
		
		return result;
	}
	public int reject(Map<String, Object> reject) {
		return rd.reject(reject);
	}
	public int cancel(Map<String, Object> cancel) {
		return rd.cancel(cancel);
	}
	
	//내가 신청한 게시글 리스트
	public List<Request> getMyRequest(String m_id) {
		return rd.getMyRequest(m_id);
	}
	//신청 이력 확인(신청이 존재하는가)
	public Request selectRequest(Map<String, Object> request) {
		return rd.selectRequest(request);
	}
}
