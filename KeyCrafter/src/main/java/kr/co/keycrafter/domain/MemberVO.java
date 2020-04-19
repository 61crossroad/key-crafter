package kr.co.keycrafter.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private String id;
	private String password;
	private String name;
	private String email;
	private String contact;
	private String address;
	private String zipCode;
	private Date regDate;
	private boolean enabled;
	private List<AuthVO> authList;
}
