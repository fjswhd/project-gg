package com.ch.project.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.ch.project.model.Request;


@Repository
public class RequestDaoImpl implements RequestDao{
	@Autowired
	private SqlSessionTemplate sst;

	public List<Request> rqList(int b_no) {
		return sst.selectList("requestns.rqList",b_no);
	}
}
