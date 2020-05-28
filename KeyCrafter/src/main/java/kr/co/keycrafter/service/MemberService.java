package kr.co.keycrafter.service;

import java.util.List;

import kr.co.keycrafter.domain.Criteria;
import kr.co.keycrafter.domain.MemberVO;

public interface MemberService {
	public void insertMember(MemberVO member, String auth);
	
	public int updateMember(MemberVO member);
	
	public void modifyMember(MemberVO member);
	
	public MemberVO getMemberWithAuth(String id);
	
	public String getId(String id);
	
	public String getEmail(String email);
	
	public List<MemberVO> getMemberList(Criteria cri);
	
	public int getMemberCount(Criteria cri);
}
