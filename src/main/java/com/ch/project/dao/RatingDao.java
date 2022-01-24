package com.ch.project.dao;


import com.ch.project.model.Rating;

public interface RatingDao {

	int selectRatingCount();

	void insertRscore(Rating rating);

}
