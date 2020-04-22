package kr.co.keycrafter.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.keycrafter.service.CategoryService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@RunWith(SpringJUnit4ClassRunner.class)
public class CategoryServiceTest {
	@Setter(onMethod_ = @Autowired)
	private CategoryService categoryService;
	
	@Test
	public void getCategoryList() {
		// categoryService.selectCategoryList().forEach(category -> log.info(category));
	}
}
