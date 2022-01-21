package com.ch.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.project.dao.MemberDao;
import com.ch.project.model.Member;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDao md;
	
	public Member selectMember(String m_id) {
		return md.selectMember(m_id);
	}
	public Member selectMemberWithNick(String nickname) {
		return md.selectMemberWithNick(nickname);
	}
	public int insert(Member member) {
		return md.insert(member);
	}
	public int updateProfile(Member member) {
		return md.updateProfile(member);
	}
	public int updateMember(Member member) {
		return md.updateMember(member);
	}
}
