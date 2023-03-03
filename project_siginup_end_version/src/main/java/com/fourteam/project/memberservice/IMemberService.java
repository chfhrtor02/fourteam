package com.fourteam.project.memberservice;

import java.util.List;

import com.fourteam.project.membervo.MemberVO;

public interface IMemberService {

	String insertMember(MemberVO member);
	MemberVO getMember(String id);
	void updateMember(MemberVO member);
	void deleteMember(String id);
	List<MemberVO> getAllMembers();
//	List<MemberVO> getOneMember();
	boolean hasMember(String id);
	MemberVO getOneMember(MemberVO member);
	boolean isMember (String field, String value);
	boolean isPhone (String field, String memberphone);
}
