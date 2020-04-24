package kr.co.keycrafter.mapper;

import java.util.List;

import kr.co.keycrafter.domain.CategoryVO;

public interface CategoryMapper {
	public void insertCategory(String catName);
	
	public CategoryVO selectCategoryByNum(int catNum);
	
	public CategoryVO selectCategoryByName(String catName);
	
	public List<CategoryVO> selectCategoryList();
	
	public List<CategoryVO> selectCategoryForProduct(int pid);
	
	public int updateCategory(CategoryVO category);
	
	public int deleteCategoryByNum(int catNum);
	
	// public int deleteCategoryByName(String catName);
}
