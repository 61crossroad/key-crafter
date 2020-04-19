package kr.co.keycrafter.mapper;

import kr.co.keycrafter.domain.MemberVO;
import kr.co.keycrafter.domain.AuthVO;

public interface MemberMapper {
	public String getTime();
	
	public void insertMember(MemberVO member);
	
	public void insertAuth(AuthVO memberAuth);
	
	public String getId(String id);
	
	public MemberVO getMember(String id);
	
	public MemberVO getMemberWithAuth(String id);
	
	public int updateMemberPw(MemberVO member);
	
	public int updateMemberNoPw(MemberVO member);
	
	public int deleteMember(String id);
}
