package kr.co.keycrafter.mapper;

import java.util.List;

import kr.co.keycrafter.domain.ProductVO;
import kr.co.keycrafter.domain.ProductCategoryDTO;

public interface ProductMapper {
	public void insertProduct(ProductVO product);
	
	public void insertSelectKeyProduct(ProductVO product);

	public ProductVO getProduct(int pid);
	
	public List<ProductVO> getProductList();
	
	public void insertCategoryToProduct(ProductCategoryDTO productCategoryDTO);
	
	public int deleteCategoryFromProduct(int pid);
	
	public int updateProduct(ProductVO product);
	
	public int deleteProduct(int pid);
}
