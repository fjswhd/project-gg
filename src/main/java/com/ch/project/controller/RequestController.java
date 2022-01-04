package com.ch.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
}
