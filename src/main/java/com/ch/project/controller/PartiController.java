package com.ch.project.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.ch.project.model.Parti;
import com.ch.project.service.PartiService;

@Controller
public class PartiController {
	@Autowired
	private PartiService ps;
	
	@RequestMapping ("partiList")
	public String partiList (int b_no, Model model) {
		List<Parti> ptList = ps.ptList(b_no);
		model.addAttribute("b_no",b_no);
		model.addAttribute("ptList",ptList);
		return "parti/partiList";
	}
}
