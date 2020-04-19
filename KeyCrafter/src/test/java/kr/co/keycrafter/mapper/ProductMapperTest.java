package kr.co.keycrafter.mapper;

import org.junit.Test;
import org.junit.After;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.beans.factory.annotation.Autowired;

import lombok.extern.log4j.Log4j;
import lombok.Setter;

import kr.co.keycrafter.mapper.ProductMapper;
import kr.co.keycrafter.domain.ProductVO;

@Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class ProductMapperTest {
	@Setter(onMethod_ = @Autowired)
	private ProductMapper productMapper;
	
	// @Test
	public void getProductList() {
		log.info(productMapper.getProductList());
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
