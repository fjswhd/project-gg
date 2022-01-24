package com.ch.project.service;

import java.util.List;
import java.util.Map;

import com.ch.project.model.Parti;
import com.ch.project.model.Request;

public interface RequestService {

	List<Request> rqList(int b_no);					// 신청자 리스트 
	Request select(Map<String, Object> request);	// 참여 신청 가능 여부 확인
	int insert(Map<String, Object> request);		// 참여 신청
	
	int update(Map<String, Object> request);		// 신청 거절 후 재신청자
	
	int accept(Map<String, Object> accept);			// 참여 수락
	int reject(Map<String, Object> reject);			// 참여 거절 -> 신청자 리스트에서 삭제
	int cancel(Map<String, Object> cancel);			// 참여 신청 취소
	
	//b_no, m_id로 신청한 이력 확인
	Request selectRequest(Map<String, Object> request);
	
	//마지막 신청자를 수락할 때 나머지 신청자 거절
	void rejectAll(int b_no);
	
	//신청글 개수
	int selectTotalMyRequest(String m_id);		
	//내가 신청한 게시글 리스트(row)
	List<Request> selectMyRequest(Map<String, Object> param);
	
}
