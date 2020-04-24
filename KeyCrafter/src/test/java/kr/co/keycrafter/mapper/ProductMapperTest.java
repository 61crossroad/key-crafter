package kr.co.keycrafter.mapper;

import org.junit.Test;

import java.util.List;

import org.junit.After;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.beans.factory.annotation.Autowired;

import lombok.extern.log4j.Log4j;
import lombok.Setter;

import kr.co.keycrafter.mapper.ProductMapper;
import kr.co.keycrafter.domain.ProductVO;
import kr.co.keycrafter.domain.ProductAttachVO;
import kr.co.keycrafter.domain.CategoryVO;

@Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class ProductMapperTest {
	@Setter(onMethod_ = @Autowired)
	private ProductMapper productMapper;
	
	@Test
	public void getSingleProduct() {
		ProductVO product;
		
		product = productMapper.getProduct(3);
		
		log.info(product.getPid() + " " + product.getPName() + " " + product.getAttachList().size()
				+ " " + product.getCategoryList().size());
		
		/*
		List<ProductAttachVO> attachList = product.getAttachList();
		attachList.forEach(attach -> log.info(attach.getFileName()));
		*/
	}
	
	// @Test
	public void getProductList() {
		// productMapper.getProductList().forEach(product -> log.info(product));
		List<ProductVO> list = productMapper.getProductList();
		
		list.forEach(product -> {
			log.info(product.getPName());
			List<ProductAttachVO> attachList = product.getAttachList();
			
			attachList.forEach(attach -> log.info(attach.getFileName()));
			
			List<CategoryVO> catList = product.getCategoryList();
			
			catList.forEach(category -> log.info(category.getCatNum()));
		});
	}
	
	// @Test
	public void insertProduct() {
		ProductVO product = new ProductVO();
		product.setPName("상품3");
		product.setPrice(10000);
		product.setQuantity(100);
		product.setProductDesc("test 테스트");
		product.setCompany("그 회사");
		product.setMadeIn("KOREA");
		
		log.info(product);
		
		productMapper.insertProduct(product);
	}
}
