package kr.co.keycrafter.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.keycrafter.domain.CategoryVO;
import kr.co.keycrafter.mapper.CategoryMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class CategoryServiceImpl implements CategoryService {
	private CategoryMapper categoryMapper;

	@Transactional
	@Override
	public void insertCategory(CategoryVO category) {
		log.info("insert Category: " + category.getCatName());
		List<CategoryVO> subList = categoryMapper.selectCategorySubList(category.getCatNum(), 0);
		log.info(subList);
		
		// 다른 형제 카테고리가 없는 경우
		if (subList.size() == 1) {
			log.info("Only child");
			// 부모의 left 값을 get
			int left = subList.get(0).getLft();
			
			log.info("Left value: " + left);
			
			// 부모의 left 값을 기준으로 다른 카테고리들의 위치 이동
			categoryMapper.updateRight(left, 2);
			categoryMapper.updateLeft(left, 2);
			
			CategoryVO newCategory = new CategoryVO();
			newCategory.setCatName(category.getCatName());
			newCategory.setLft(left + 1);
			newCategory.setRgt(left + 2);
			log.info(newCategory);
			
			categoryMapper.insertCategory(newCategory);
		}
		// 형제들 중 마지막에 insert
		else {
			log.info("Last child");
			// 현재 마지막 순서에 있는 형제의 right 값을 get
			int right = subList.get(subList.size() - 1).getRgt();
			
			// 형제의 right 값을 기준으로 다른 카테고리들의 위치 이동
			categoryMapper.updateRight(right, 2);
			categoryMapper.updateLeft(right, 2);
			
			CategoryVO newCategory = new CategoryVO();
			newCategory.setCatName(category.getCatName());
			newCategory.setLft(right + 1);
			newCategory.setRgt(right + 2);
			
			categoryMapper.insertCategory(newCategory);
		}
	}

	@Override
	public List<CategoryVO> selectCategoryList(int rootCatNum, int all) {
		return categoryMapper.selectCategorySubList(rootCatNum, all);
	}
	
	@Override
	public List<CategoryVO> selectCategoryForProduct(int pid) {
		int catNum = categoryMapper.selectCatNum(pid);
		
		log.info("Product: " + pid + " Cat: " + catNum);
		
		return categoryMapper.selectCategoryPath(catNum);
	}
	
	@Override
	public int updateCategory(CategoryVO category) {
		return categoryMapper.updateCategory(category);
	}
	
	@Transactional
	@Override
	public int deleteCategory(int catNum) {
		log.info("Delete category");
		CategoryVO category = categoryMapper.selectCategory(catNum);
		category.setWidth();
		int right = category.getRgt();
		int left = category.getLft();
		int width = category.getWidth();
		
		int result = categoryMapper.deleteCategory(category);
		
		categoryMapper.updateRight(right, -1 * width);
		categoryMapper.updateLeft(left, -1 * width);
		
		return result;
	}
	
	@Override
	public int getCategoryForKeyword(String keyword) {
		return categoryMapper.selectCategoryForKeyword(keyword);
	}
}
