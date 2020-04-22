package kr.co.keycrafter.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.keycrafter.domain.ProductCategoryDTO;
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
		int resultPid = product.getPid();
		
		if (product.getAttachList() != null && product.getAttachList().size() > 0) {
			product.getAttachList().forEach(attach -> {
				attach.setPid(resultPid);
				log.info(attach);
				productAttachMapper.insertAttach(attach);
			});
		}
		
		if (product.getCategoryList() != null && product.getCategoryList().size() > 0 ) {
			product.getCategoryList().forEach(category -> {
				log.info(category);
				ProductCategoryDTO productCategoryDTO = new ProductCategoryDTO();
				productCategoryDTO.setPid(resultPid);
				productCategoryDTO.setCatNum(category.getCatNum());
				
				log.info("Product Category DTO: " + productCategoryDTO);
				productMapper.insertCategoryToProduct(productCategoryDTO);
			});
		}
		
		return resultPid;
	}

	@Override
	public List<ProductVO> getProductList() {
		return productMapper.getProductList();
	}
}
