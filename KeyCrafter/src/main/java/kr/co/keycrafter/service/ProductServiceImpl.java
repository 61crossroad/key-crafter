package kr.co.keycrafter.service;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.keycrafter.domain.ProductVO;
import kr.co.keycrafter.mapper.ProductMapper;
import kr.co.keycrafter.mapper.ProductAttachMapper;

import lombok.extern.log4j.Log4j;
import lombok.Setter;

@Log4j
@Service
public class ProductServiceImpl implements ProductService {
	@Setter(onMethod_ = @Autowired)
	private ProductMapper productMapper;
	
	@Setter(onMethod_ = @Autowired)
	private ProductAttachMapper productAttachMapper;

	@Transactional
	@Override
	public int insertProduct(ProductVO product) {
		log.info("Insert product");
		productMapper.insertSelectKeyProduct(product);
		
		if (product.getAttachList() == null || product.getAttachList().size() <= 0) {
			return product.getPid();
		}
		
		product.getAttachList().forEach(attach -> {
			attach.setPid(product.getPid());
			log.info(attach);
			productAttachMapper.insertAttach(attach);
		});
		
		return product.getPid();
	}
}
