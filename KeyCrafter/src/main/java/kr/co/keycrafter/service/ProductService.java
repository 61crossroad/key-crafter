package kr.co.keycrafter.service;

import java.util.List;

import kr.co.keycrafter.domain.ProductVO;

public interface ProductService {
	public int insertProduct(ProductVO product);
	
	public List<ProductVO> getProductList();
}
