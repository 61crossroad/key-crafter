package kr.co.keycrafter.domain;

import java.util.Date;

import lombok.AccessLevel;
import lombok.Setter;
import lombok.Data;

@Data
public class ProductReplyVO {
	private int rnum;
	private int pid;
	private String id;
	private String userName;
	private String name;
	private String password;
	private String content;
	private Date replyDate;
	private Date updateDate;
	private String deleted;
	private int lft;
	private int rgt;
	@Setter(AccessLevel.NONE)
	private int width;
	private int depth;
	
	public void setWidth() {
		width = rgt - lft + 1;
	}
}
