package com.ch.project.dao;

import java.util.List;
import java.util.Map;

import com.ch.project.model.Rating;

public interface RatingDao {

	List<Rating> selectMyRatings(Map<String, Object> param);

	int selectMaxR_no();

	int insertRating(Rating rating);

	int updateRating(Rating rating);

	float selectAvgScore(String m_id);
	
}
