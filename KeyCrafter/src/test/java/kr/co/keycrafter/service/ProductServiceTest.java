package kr.co.keycrafter.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.keycrafter.service.ProductService;
import kr.co.keycrafter.domain.ProductVO;
import kr.co.keycrafter.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@RunWith(SpringJUnit4ClassRunner.class)
public class ProductServiceTest {
	@Setter(onMethod_ = @Autowired)
	private ProductService productService;
	
	@Test
	public void getList() {
		// productService.getProductList().forEach(product -> log.info(product));
		
		Criteria cri = new Criteria();
		
		cri.setShow(8);
		cri.setPage(2);
		
		List<ProductVO> list;
		
		list = productService.getProductList(cri);
		
		log.info("Get it started...... " + list.size());
		
		list.forEach(product -> {
			log.info(product);
		});
	}
}
