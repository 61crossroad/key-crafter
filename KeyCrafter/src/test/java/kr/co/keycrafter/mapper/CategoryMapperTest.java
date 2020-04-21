package kr.co.keycrafter.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.keycrafter.mapper.CategoryMapper;
import kr.co.keycrafter.domain.CategoryVO;

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
	
	@Test
	public void selectAll() {
		categoryMapper.selectCategoryList().forEach(category -> log.info(category));
	}
	
	// @Test
	public void insertThenSelect() {
		String catName = "청축";
		
		categoryMapper.insertCategory(catName);
		log.info(categoryMapper.selectCategoryByName(catName));
	}
}
