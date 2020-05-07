package kr.co.keycrafter.mapper;

import java.util.List;

import kr.co.keycrafter.domain.Criteria;

import kr.co.keycrafter.domain.ProductVO;

public interface ProductMapper {
	public void insertSelectKeyProduct(ProductVO product);

	public ProductVO getProduct(int pid);
	
	public List<ProductVO> getProductListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public int updateProduct(ProductVO product);
	
	public int deleteProduct(int pid);
}
