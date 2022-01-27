package com.ch.project.service;

import java.util.List;
import java.util.Map;

import com.ch.project.model.Rating;

public interface RatingService {
	//내가 어떤 글에 대한 평가내역이 있는지 검사하기
	List<Rating> selectMyRatings(Map<String, Object> param);

	int selectMaxR_no();

	int insertRating(Rating rating);

	int updateRating(Rating rating);

	float selectAvgScore(String m_id);

}
