package kr.co.keycrafter.domain;

import lombok.Data;

@Data
public class ProductAttachVO {
	private String uuid;
	private String uploadPath;
	private String fileName;
	private int pid;
	private char mainImage;
}
