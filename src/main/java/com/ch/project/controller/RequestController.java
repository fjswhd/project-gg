package com.ch.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ch.project.model.Board;
import com.ch.project.model.Request;
import com.ch.project.service.RequestService;

@Controller
public class RequestController {

	@Autowired
	private RequestService rs;

	@RequestMapping("requestList")
	public String requestList ( int b_no, Model model ) {
		List<Request> rqList = rs.rqList(b_no);
		model.addAttribute("b_no",b_no);
		model.addAttribute("rqList",rqList);
		return "request/requestList";
	}
	@RequestMapping ("request") 
	// int b_no은 board의 b_no  / String m_id는 세션 아이디
	public String request (int b_no, String m_id, Model model) {
		int result = 0; // 신청실패
		Map<String, Object> request = new HashMap<String, Object>();
		request.put("b_no",b_no);
		request.put("m_id",m_id);
		Request rq = rs.select(request);
		if(rq.getM_id().equals(m_id)) {
			result = -1;
		}else result = rs.insert(request);
		model.addAttribute("result",result);
		model.addAttribute("request",request);
		return "request/request";
	}
	@RequestMapping ("requestAccept")
	public String requestAccept (int b_no,String m_id, Model model) {
		int result= 0; // 수락실패
		Map<String, Object> accept = new HashMap<String, Object>();
		accept.put("b_no",b_no);
		accept.put("m_id",m_id);
		result = rs.accept(accept);
		model.addAttribute("result",result);
		model.addAttribute("accept",accept);
		System.out.println( "result : " + result);
		return "request/requestAccept";
	}
	@RequestMapping ("requestReject")
	public String requestReject (int b_no,String m_id, Model model) {
		int result= 0; // 수락실패
		Map<String, Object> reject = new HashMap<String, Object>();
		reject.put("b_no",b_no);
		reject.put("m_id",m_id);
		result = rs.reject(reject);
		model.addAttribute("result",result);
		model.addAttribute("reject",reject);
		return "request/requestReject";
	}
}
