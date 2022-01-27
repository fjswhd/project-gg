package com.ch.project.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.project.model.Rating;

@Repository
public class RatingDaoImpl implements RatingDao {
	@Autowired
	private SqlSessionTemplate sst;
	
	public List<Rating> selectMyRatings(Map<String, Object> param) {
		return sst.selectList("ratingns.selectMyRatings", param);
	}
	public int selectMaxR_no() {
		return sst.selectOne("ratingns.selectMaxR_no");
	}
	public int insertRating(Rating rating) {
		return sst.insert("ratingns.insertRating", rating);
	}
	public int updateRating(Rating rating) {
		return sst.update("ratingns.updateRating", rating);
	}
	public float selectAvgScore(String m_id) {
		return sst.selectOne("ratingns.selectAvgScore", m_id);
	}
}
