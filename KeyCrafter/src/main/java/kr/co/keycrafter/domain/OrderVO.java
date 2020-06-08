package kr.co.keycrafter.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class OrderVO {
	private int onum;
	private String id;
	private Date orderDate;
	private String name;
	private String email;
	private String contact;
	private String address;
	private String zipCode;
	private String note;
	private int price;
	private String payMethod;
	private String payOwner;
	private String payNum;
	private String payProvider;
	private int status;
	private String message;
	private String trackingNum;
	private List<ProductVO> productList;
}
