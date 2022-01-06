package com.ch.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		List<Parti> ptCancelList = ps.ptCancelList(b_no);
		model.addAttribute("b_no",b_no);
		model.addAttribute("ptList",ptList);
		model.addAttribute("ptCancelList",ptCancelList);
		return "parti/partiList";
	}
	@RequestMapping ("partiOut")
	public String partiOut (int b_no, String m_id, Model model) {
		int result = 0; // 강퇴실패
		Map<String, Object> ptOut = new HashMap<String, Object>();
		ptOut.put("b_no",b_no);
		ptOut.put("m_id",m_id);
		result = ps.ban(ptOut);
		model.addAttribute("ptOut",ptOut);
		model.addAttribute("result",result);
		return "parti/partiOut";
	}
	@RequestMapping ("partiCancel")
	public String partiCancel (int b_no, String m_id, Model model) {
		int result = 0; // 탈퇴 신청 실패
		Map<String, Object> ptCancel = new HashMap<String, Object>();
		ptCancel.put("b_no",b_no);
		ptCancel.put("m_id",m_id);
		result = ps.ptCancel(ptCancel);
		model.addAttribute("ptCancel",ptCancel);
		model.addAttribute("result",result);
		return "parti/partiCancel";
	}
	@RequestMapping ("partiReCancel")
	public String partiReCancel (int b_no, String m_id, Model model) {
		int result = 0; // 탈퇴 신청 취소 실패
		Map<String, Object> ptReCancel = new HashMap<String, Object>();
		ptReCancel.put("b_no",b_no);
		ptReCancel.put("m_id",m_id);
		result = ps.ptReCancel(ptReCancel);
		model.addAttribute("ptReCancel",ptReCancel);
		model.addAttribute("result",result);
		return "parti/partiReCancel";
	}
	@RequestMapping ("partiCancelAccess")
	public String partiCancelAccess (int b_no, String m_id, Model model) {
		int result = 0; // 탈퇴 신청 수락 실패
		Map<String, Object> pcAccess = new HashMap<String, Object>();
		pcAccess.put("b_no",b_no);
		pcAccess.put("m_id",m_id);
		result = ps.pcAccess(pcAccess);
		model.addAttribute("pcAccess",pcAccess);
		model.addAttribute("result",result);
		return "parti/partiCancelAccess";
	}
	@RequestMapping ("partiCancelReject")
	public String partiCancelReject (int b_no, String m_id, Model model) {
		int result = 0; // 탈퇴 신청 수락 실패
		Map<String, Object> pcReject = new HashMap<String, Object>();
		pcReject.put("b_no",b_no);
		pcReject.put("m_id",m_id);
		result = ps.pcReject(pcReject);
		model.addAttribute("pcReject",pcReject);
		model.addAttribute("result",result);
		return "parti/partiCancelReject";
	}
	
}
