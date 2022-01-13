package com.ch.project.service;

import com.ch.project.model.Member;

public interface MemberService {
	Member selectMember(String m_id);
	Member selectMemberWithNick(String nickname);
	int insert(Member member);
	int updateProfile(Member member);

}
