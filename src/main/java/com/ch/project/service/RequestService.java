package com.ch.project.service;

import java.util.List;
import java.util.Map;

import com.ch.project.model.Parti;
import com.ch.project.model.Request;

public interface RequestService {

	List<Request> rqList(int b_no);					// 신청자 리스트 
	Request select(Map<String, Object> request);	// 참여 신청 가능 여부 확인
	int insert(Map<String, Object> request);		// 참여 신청
	int accept(Map<String, Object> accept);			// 참여 수락
	void insertParti(Map<String, Object> accept);	// 수락한뒤 참여자리스트로 이동
	int reject(Map<String, Object> reject);			// 참여 거절 -> 신청자 리스트에서 삭제
	int cancel(Map<String, Object> cancel);			// 참여 신청 취소
	
}
