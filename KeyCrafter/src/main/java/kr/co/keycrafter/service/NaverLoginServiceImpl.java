package kr.co.keycrafter.service;

import java.math.BigInteger;
import java.security.SecureRandom;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class NaverLoginServiceImpl implements NaverLoginService {
	public String generateState() {
	    SecureRandom random = new SecureRandom();
	    return new BigInteger(130, random).toString(32);
	}
}
