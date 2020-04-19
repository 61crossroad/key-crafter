package kr.co.keycrafter.service;

import kr.co.keycrafter.domain.MemberVO;

public interface MemberService {
	public void insertMember(MemberVO member, String auth);
	
	public int updateMember(MemberVO member);
	
	public MemberVO getMemberWithAuth(String id);
	
	public String getId(String id);
}
