package com.ch.project.service;


import com.ch.project.model.Rating;

public interface RatingService {

	int selectRatingCount();		// 평점 번호 구하기

	void insertRscore(Rating rating); // 평가점수 입력

}
