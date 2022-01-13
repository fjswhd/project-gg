package com.ch.project.dao;

import com.ch.project.model.Member;

public interface MemberDao {

	Member selectMember(String m_id);

	Member selectMemberWithNick(String nickname);

	int insert(Member member);

	int updateProfile(Member member);
	
}
