package com.ch.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.project.dao.PartiDao;
import com.ch.project.model.Parti;

@Service
public class PartiServiceImpl implements PartiService {
	@Autowired
	private PartiDao pd;

	public List<Parti> ptList(int b_no) {
		return pd.ptList(b_no);
	}
}
