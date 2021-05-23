package kr.co.keycrafter.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.keycrafter.domain.CategoryVO;
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
	
	// @Test
	public void delete() {
		int catNum = 4;
		
		log.info(categoryService.deleteCategory(catNum));
		
		log.info(categoryService.selectCategoryList(1, 1));
	}
	
	// @Test
	public void selectList() {
		int rootCatNum = 2;
		
		log.info(categoryService.selectCategoryList(rootCatNum, 1));
	}
	
	@Test
	public void insertCategory() {
		CategoryVO category = new CategoryVO();
		category.setCatName("키보드");
		category.setCatNum(1);
		categoryService.insertCategory(category);
		log.info(categoryService.selectCategoryList(category.getCatNum(), 1));
	}
}
