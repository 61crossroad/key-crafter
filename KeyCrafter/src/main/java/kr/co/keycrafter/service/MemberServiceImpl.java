package kr.co.keycrafter.service;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

import kr.co.keycrafter.domain.MemberVO;
import kr.co.keycrafter.domain.AuthVO;
import kr.co.keycrafter.domain.Criteria;
import kr.co.keycrafter.mapper.MemberMapper;
import kr.co.keycrafter.security.CustomUserDetailsService;

@Log4j
@AllArgsConstructor
@Service
public class MemberServiceImpl implements MemberService {
	private MemberMapper memberMapper;
	private PasswordEncoder passwordEncoder;
	private CustomUserDetailsService userDetailsService;
	
	@Transactional
	@Override
	public void insertMember(MemberVO member, String auth) {
		log.info("insertMember: " + member.getId() + " with " + auth);
		
		member.setPassword(passwordEncoder.encode(member.getPassword()));
		memberMapper.insertMember(member);
		
		AuthVO memberAuth = new AuthVO();
		memberAuth.setId(member.getId());
		memberAuth.setAuth(auth);
		memberMapper.insertAuth(memberAuth);
		
		member = memberMapper.getMemberWithAuth(member.getId());
		
		userDetailsService.addAuthentication(member);
	}
	
	@Override
	public int updateMember(MemberVO member) {
		// 회원의 자기 정보 업데이트
		
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
	
	@Transactional
	@Override
	public void modifyMember(MemberVO member) {
		// 관리자가 회원 정보 업데이트
		
		log.info("Update member info by Administrator");
		
		if (member.getPassword() == null || member.getPassword().equals("")) {
			log.info("updateMemberNoPw: " + member.getId());
			memberMapper.updateMemberNoPw(member);
		}
		else {
			log.info("updateMemberPw: " + member.getId());
			member.setPassword(passwordEncoder.encode(member.getPassword()));
			memberMapper.updateMemberPw(member);
		}
		
		memberMapper.updateAuth(member.getAuthList().get(0));
	}
	
	@Override
	public MemberVO getMemberWithAuth(String id) {
		log.info("getMemberWithAuth: " + id);
		MemberVO member = memberMapper.getMemberWithAuth(id);
		
		String auth = member.getAuthList().get(0).getAuth();
		
		member.setRole(authToRole(auth));
		
		return member;
	}
	
	@Override
	public String checkOverlap(MemberVO member) {
		String result;
		
		if (member.getId() != null) {
			result = memberMapper.getId(member.getId());
			
			if (result != null) {
				return "id";
			}
		}
		
		if (member.getEmail() != null) {
			result = memberMapper.getEmail(member.getEmail());
			
			if (result != null) {
				return "email";
			}
		}
		
		if (member.getContact() != null) {
			result = memberMapper.getContact(member.getContact());
			
			if (result != null) {
				return "contact";
			}
		}
		
		return "";
	}
	
	@Override
	public List<MemberVO> getMemberList(Criteria cri) {
		List<MemberVO> memberList = memberMapper.getMemberList(cri);
		
		memberList.forEach(member -> {
			String auth = member.getAuthList().get(0).getAuth();
			member.setRole(authToRole(auth));
		});
		
		return memberList;
	}
	
	@Override
	public int getMemberCount(Criteria cri) {
		return memberMapper.getMemberCount(cri);
	}
	
	private String authToRole(String auth) {
		if (auth.equals("ROLE_ADMIN")) {
			return "관리자";
		}
		else if (auth.equals("ROLE_MEMBER")) {
			return "운영자";
		}
		else {
			return "회원";
		}
	}
}
