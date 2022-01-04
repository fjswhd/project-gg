package com.ch.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ch.project.dao.RequestDao;
import com.ch.project.model.Request;

@Service
public class RequestServiceImpl implements RequestService{
	@Autowired
	private RequestDao rd;

	public List<Request> rqList(int b_no) {
		return rd.rqList(b_no);
	}
}
