package com.ch.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.project.dao.RatingDao;
import com.ch.project.model.Rating;

@Service
public class RatingServiceImpl implements RatingService{
	@Autowired
	private RatingDao rd;
	
	//내가 평가한 내역이 있는지 확인
	public List<Rating> selectMyRatings(Map<String, Object> param) {
		return rd.selectMyRatings(param);
	}
	
	public int selectMaxR_no() {
		return rd.selectMaxR_no();
	}
	public int insertRating(Rating rating) {
		return rd.insertRating(rating);
	}
	public int updateRating(Rating rating) {
		return rd.updateRating(rating);
	}
	public float selectAvgScore(String m_id) {
		return rd.selectAvgScore(m_id);
	}
}
