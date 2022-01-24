package com.ch.project.service;

import com.ch.project.model.Member;

public interface MemberService {
	Member selectMember(String m_id);
	Member selectMemberWithNick(String nickname);
	int insert(Member member);
	int updateProfile(Member member);
	
	//멤버 정보 수정
	int updateMember(Member member);
	
	int updateRating(Member member);

}
