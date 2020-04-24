package kr.co.keycrafter.mapper;

import java.util.List;

import kr.co.keycrafter.domain.ProductAttachVO;

public interface ProductAttachMapper {
	public void insertAttach(ProductAttachVO productAttach);
	
	// public void delete(String uuid);
	
	public int deleteAllAttach(int pid);
	
	public List<ProductAttachVO> getAttachForProduct(int pid);
	
	// public ProductAttachVO getMainAttachByPid(int pid);
}
