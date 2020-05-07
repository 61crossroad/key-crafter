package kr.co.keycrafter.controller;

import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.log4j.Log4j;
import lombok.AllArgsConstructor;

import kr.co.keycrafter.domain.CategoryVO;
import kr.co.keycrafter.service.CategoryService;

@Log4j
@AllArgsConstructor
@Controller
@RequestMapping("/category")
public class CategoryController {
	private CategoryService categoryService;
	
	@ResponseBody
	@GetMapping(value = "/list",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<CategoryVO>> list(@RequestParam("cat") int catNum, @RequestParam("all") int all) {
		log.info("* Get category list...... " + catNum);
		
		List<CategoryVO> list = categoryService.selectCategoryList(catNum, all);
		list.forEach(category -> log.info(category));
		
		// log.info(list);
		
		return new ResponseEntity<List<CategoryVO>>(list, HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value="/product/{pid}",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<CategoryVO>> listForProduct(@PathVariable("pid") int pid) {
		List<CategoryVO> list = categoryService.selectCategoryForProduct(pid);
		
		log.info("* Categories for: " + pid);
		list.forEach(category -> log.info(category));
		return new ResponseEntity<List<CategoryVO>>(list, HttpStatus.OK);
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@GetMapping("/modify")
	public String modify(Model model) {
		log.info("Category modify page......");
		
		List<CategoryVO> list = categoryService.selectCategoryList(1, 1);
		model.addAttribute("list", list);
		
		return "/category/categoryModify";
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@PostMapping("/insert")
	public String insert(CategoryVO category) {
		log.info("Parent: " + category.getCatNum() + " Name: " + category.getCatName());
		
		categoryService.insertCategory(category);
		
		return "redirect:/category/modify";
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@PostMapping("/update")
	public String update(CategoryVO category) {
		log.info("Update Category");
		log.info(category);
		
		categoryService.updateCategory(category);
		
		return "redirect:/category/modify";
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@PostMapping("/delete")
	public String delete(@RequestParam("catNum") int catNum) {
		log.info("Delete category: " + catNum);
		
		categoryService.deleteCategory(catNum);
		
		return "redirect:/category/modify";
	}
}
