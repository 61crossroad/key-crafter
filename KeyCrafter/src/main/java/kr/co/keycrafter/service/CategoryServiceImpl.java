package kr.co.keycrafter.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.co.keycrafter.domain.CategoryVO;
import kr.co.keycrafter.mapper.CategoryMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class CategoryServiceImpl implements CategoryService {
	private CategoryMapper categoryMapper;

	@Override
	public void insertCategory(String catName) {
		log.info("insert Category: " + catName);
		categoryMapper.insertCategory(catName);
	}

	@Override
	public List<CategoryVO> selectCategoryList() {
		return categoryMapper.selectCategoryList();
	}
	
	@Override
	public int updateCategory(CategoryVO category) {
		return categoryMapper.updateCategory(category);
	}
	
	@Override
	public int deleteCategory(int catNum) {
		return categoryMapper.deleteCategoryByNum(catNum);
	}

	@Override
	public List<CategoryVO> selectCategoryForProduct(int pid) {
		return categoryMapper.selectCategoryForProduct(pid);
	}
}
