package kr.co.keycrafter.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.keycrafter.domain.CategoryVO;

public interface CategoryMapper {
	public void insertCategory(CategoryVO category);
	
	public int updateRight(@Param("leftOrRight") int leftOrRight, @Param("amount") int amount);
	
	public int updateLeft(@Param("leftOrRight") int leftOrRight, @Param("amount") int amount);
	
	public CategoryVO selectCategory(int catNum);
	
	public List<CategoryVO> selectCategoryList();
	
	public List<CategoryVO> selectCategoryPath(int catNum);
	
	public List<CategoryVO> selectCategorySubList(@Param("catNum") int catNum, @Param("all") int all);
	
	public int selectCatNum(int pid);
	
	public int updateCategory(CategoryVO category);
	
	public int deleteCategory(CategoryVO category);
}
