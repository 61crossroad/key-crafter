package kr.co.keycrafter.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

import kr.co.keycrafter.domain.MemberVO;
import kr.co.keycrafter.mapper.MemberMapper;
import kr.co.keycrafter.security.domain.CustomUser;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.warn("Load User By UserName: " + username);
		
		log.info(memberMapper.getMemberWithAuth(username));
		MemberVO member = memberMapper.getMemberWithAuth(username);
		
		log.warn("queried by member mapper: " + member);
		
		return member == null ? null : new CustomUser(member);
	}
	
	public UsernamePasswordAuthenticationToken newAuth(MemberVO member) {
		UserDetails principal = new CustomUser(member);
		
		UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(
				principal, principal.getPassword(), principal.getAuthorities());
		
		return auth;
	}
	
	public void addAuthentication(MemberVO member) {
		log.info("setAuth username: " + member.getId());
		
		UsernamePasswordAuthenticationToken auth = newAuth(member);
		
		SecurityContextHolder.getContext().setAuthentication(auth);
		
		log.info("member auths: " + auth.getAuthorities());
		
	}
	
	public void updateAuthentication(MemberVO member) {
		log.info("updateAuth username: " + member.getId());
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		UsernamePasswordAuthenticationToken newAuth = newAuth(member);
		newAuth.setDetails(auth.getDetails());
		
		SecurityContextHolder.getContext().setAuthentication(newAuth);
	}
}
