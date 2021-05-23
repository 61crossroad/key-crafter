package kr.co.keycrafter.domain;

import lombok.Setter;
import lombok.AccessLevel;
import lombok.Data;

@Data
public class CategoryVO {
	private int catNum;
	private String catName;
	private int lft;
	private int rgt;
	@Setter(AccessLevel.NONE)
	private int width;
	private int depth;
	
	public void setWidth() {
		width = rgt - lft + 1;
	}
}
