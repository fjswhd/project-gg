package com.ch.project.dao;

import java.util.List;
import java.util.Map;

import com.ch.project.model.Parti;

public interface PartiDao {

	List<Parti> ptList(int b_no);
	List<Parti> ptCancelList(int b_no);
	int ban(Map<String, Object> ptOut);
	int ptCancel(Map<String, Object> ptCancel);
	int ptReCancel(Map<String, Object> ptReCancel);
	int pcAccess(Map<String, Object> pcAccess);
	int pcReject(Map<String, Object> pcReject);
	
	Parti banned(Map<String, Object> param);
	
	List<Parti> getMyParti(String m_id);

}
