package kr.co.keycrafter.mapper;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.keycrafter.mapper.CategoryMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@RunWith(SpringJUnit4ClassRunner.class)
public class CategoryMapperTest {
	@Setter(onMethod_ = @Autowired)
	private CategoryMapper categoryMapper;
	
	// @Test
	public void selectPath() {
		int catNum = 5;
		log.info(categoryMapper.selectCategoryPath(catNum));
	}
	
	// @Test
	public void updateCategory() {
		categoryMapper.updateRight(2, 1);
		log.info(categoryMapper.selectCategoryList());
	}
	
	// @Test
	public void selectCategorySubList() {
		log.info(categoryMapper.selectCategorySubList(1, 1));
	}
	
	@Test
	public void search() {
		int catNum = categoryMapper.selectCategoryForKeyword("키캡");
		
		log.info(categoryMapper.selectCategory(catNum));
	}
}
