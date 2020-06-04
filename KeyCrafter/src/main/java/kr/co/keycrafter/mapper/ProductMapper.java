package kr.co.keycrafter.mapper;

import java.util.List;

import kr.co.keycrafter.domain.Criteria;

import kr.co.keycrafter.domain.ProductVO;

public interface ProductMapper {
	public void insertProduct(ProductVO product);
	
	public void insertSelectKeyProduct(ProductVO product);
	
	public int updateProduct(ProductVO product);
	
	public int deleteProduct(int pid);

	public ProductVO getProduct(int pid);
	
	public ProductVO getProductSimple(int pid);
	
	public List<ProductVO> getProductListForOrder(int onum);
	
	public List<ProductVO> getProductListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public int getOrderCount(int pid);
}
