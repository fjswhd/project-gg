package com.ch.project.dao;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.project.model.Rating;

@Repository
public class RatingDaoImpl implements RatingDao {
@Autowired 
	private SqlSessionTemplate sst;
	public int selectRatingCount() {
		return sst.selectOne("ratingns.selectRatingCount");
	}
	public void insertRscore(Rating rating) {
		sst.insert("ratingns.insertRscore", rating );
	}

}
