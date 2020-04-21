package kr.co.keycrafter.service;

import java.util.List;

import kr.co.keycrafter.domain.CategoryVO;

public interface CategoryService {
	public void insertCategory(String catName);
	
	public List<CategoryVO> selectCategoryList();
	
	public int updateCategory(CategoryVO category);
	
	public int deleteCategory(int catNum);
}
