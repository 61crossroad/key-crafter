package kr.co.keycrafter.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ProductVO {
	private int pid;
	private String pName;
	private int price;
	private int quantity;
	private String productDesc;
	private String company;
	private String madeIn;
	private int catNum;
	private Date regDate;
	private Date updateDate;
	private List<ProductAttachVO> attachList;
	private List<CategoryVO> categoryList;
}
