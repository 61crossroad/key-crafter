package kr.co.keycrafter.mapper;

import java.util.List;

import kr.co.keycrafter.domain.Criteria;
import kr.co.keycrafter.domain.MemberVO;
import kr.co.keycrafter.domain.AuthVO;

public interface MemberMapper {
	public String getTime();
	
	public void insertMember(MemberVO member);
	
	public void insertAuth(AuthVO memberAuth);
	
	public String getId(String id);
	
	public String getEmail(String email);
	
	public String getContact(String contact);
	
	public MemberVO getMember(String id);
	
	public MemberVO getMemberWithAuth(String id);
	
	public int updateMemberPw(MemberVO member);
	
	public int updateMemberNoPw(MemberVO member);
	
	public int updateAuth(AuthVO auth);
	
	public int deleteMember(String id);
	
	public int deleteAuth(String id);
	
	public List<MemberVO> getMemberList(Criteria cri);
	
	public int getMemberCount(Criteria cri);
}
