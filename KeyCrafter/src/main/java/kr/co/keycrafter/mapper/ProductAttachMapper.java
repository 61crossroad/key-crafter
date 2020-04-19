package kr.co.keycrafter.mapper;

import java.util.List;

import kr.co.keycrafter.domain.ProductAttachVO;

public interface ProductAttachMapper {
	public void insertAttach(ProductAttachVO productAttach);
	
	public void delete(String uuid);
	
	public List<ProductAttachVO> getAttachByPid(int pid);
	
	public ProductAttachVO getMainAttachByPid(int pid);
}
