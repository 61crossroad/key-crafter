package kr.co.keycrafter.service;

import java.util.List;

import kr.co.keycrafter.domain.CategoryVO;

public interface CategoryService {
	public void insertCategory(CategoryVO category);
	
	public List<CategoryVO> selectCategoryList(int RootcatNum, int all);
	
	public List<CategoryVO> selectCategoryForProduct(int pid);
	
	public int updateCategory(CategoryVO category);
	
	public int deleteCategory(int catNum);
	
	public int getCategoryForKeyword(String keyword);
}
