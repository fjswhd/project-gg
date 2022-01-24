package com.ch.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ch.project.dao.RatingDao;
import com.ch.project.model.Rating;

@Service
public class RatingServiceImpl implements RatingService{
@Autowired
	public RatingDao rtd;

	public int selectRatingCount() {
		return rtd.selectRatingCount();
	}

	public void insertRscore(Rating rating) {
		rtd.insertRscore(rating);
	}
		
}
