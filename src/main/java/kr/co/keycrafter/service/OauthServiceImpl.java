package kr.co.keycrafter.service;

import java.math.BigInteger;
import java.security.SecureRandom;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class OauthServiceImpl implements OauthService {
	public String generateState(String serviceName) {
		String state = null;
		
		if (serviceName.equals("naver")) {
		    SecureRandom random = new SecureRandom();
		    state = new BigInteger(130, random).toString(32);
		}
		
		return state;
	}
}
