package kr.co.keycrafter.service;

import java.util.List;

import kr.co.keycrafter.domain.ProductVO;
import kr.co.keycrafter.domain.ProductAttachVO;
import kr.co.keycrafter.domain.Criteria;

public interface ProductService {
	public int insertProduct(ProductVO product);
	
	public List<ProductVO> getProductList(Criteria cri);
	
	public ProductVO getProduct(int pid);
	
	public List<ProductAttachVO> getAttachForProduct(int pid);
	
	public int getTotalCount(Criteria cri);
	
	public int updateProduct(ProductVO product);
	
	public int deleteProduct(int pid);
}
