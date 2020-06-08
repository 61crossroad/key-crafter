package kr.co.keycrafter.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Search {
	private String type;
	private String keyword;
	
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
}
