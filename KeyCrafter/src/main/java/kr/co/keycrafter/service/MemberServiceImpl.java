package kr.co.keycrafter.service;

import org.springframework.stereotype.Service;
import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

import kr.co.keycrafter.domain.MemberVO;
import kr.co.keycrafter.domain.AuthVO;
import kr.co.keycrafter.mapper.MemberMapper;
import kr.co.keycrafter.security.CustomUserDetailsService;

@Log4j
@AllArgsConstructor
@Service
public class MemberServiceImpl implements MemberService {
	MemberMapper memberMapper;
	PasswordEncoder passwordEncoder;
	CustomUserDetailsService userDetailsService;
	
	@Override
	public void insertMember(MemberVO member, String auth) {
		log.info("insertMember: " + member.getId() + " with " + auth);
		
		member.setPassword(passwordEncoder.encode(member.getPassword()));
		memberMapper.insertMember(member);
		
		AuthVO memberAuth = new AuthVO();
		memberAuth.setId(member.getId());
		memberAuth.setAuth(auth);
		memberMapper.insertAuth(memberAuth);
		
		// To Be Modified?
		member = memberMapper.getMemberWithAuth(member.getId());
		
		userDetailsService.addAuthentication(member);
	}
	
	@Override
	public int updateMember(MemberVO member) {
		int result;
		if (member.getPassword() == null || member.getPassword().equals("")) {
			log.info("updateMemberNoPw: " + member.getId());
			result =  memberMapper.updateMemberNoPw(member);
		}
		else {
			log.info("updateMemberPw: " + member.getId());
			member.setPassword(passwordEncoder.encode(member.getPassword()));
			result = memberMapper.updateMemberPw(member);
		}
		
		if (result == 1) {
			MemberVO newMember = memberMapper.getMemberWithAuth(member.getId());
			CustomUserDetailsService customUserDetailsService = new CustomUserDetailsService();
			customUserDetailsService.updateAuthentication(newMember);
		}
		
		return result;
	}
	
	@Override
	public MemberVO getMemberWithAuth(String id) {
		log.info("getMemberWithAuth: " + id);
		return memberMapper.getMemberWithAuth(id);
	}

	@Override
	public String getId(String id) {
		log.info("getID: " + id);
		return memberMapper.getId(id);
	}
}
